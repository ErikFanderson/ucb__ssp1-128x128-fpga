//==============================================================================
// Author: Erik Anderson
// Description: Driver for superswitch chip.
// Really just a bunch of scan controllers in parallel.
// Expects a 2 phase clkn and clkp
// Naming conventions:
//    signals => snake_case
//    Parameters (aliasing signal values) => SNAKE_CASE with all caps
//    Parameters (not aliasing signal values) => CamelCase 
//==============================================================================

`default_nettype none
`timescale 1ns/1ps
module superswitch_driver (
    // Control interface
    i_clk_p,
    i_clk_n,
    i_rst,
    i_rv0_inst_valid, // CPU tells driver that all instructions are valid
    i_rv0_inst_cmd, // Command for all inst scan chains
    i_rv0_inst_insts, // instructions! These are the instructions for each column
    o_rv0_inst_ready, // Tells FIFO that inst chains are ready to scan
    o_rv1_loopback_valid, // Address scan tells CPU that new scan out data is valid  
    o_rv1_loopback_so_data, // Scan out data from loopback scan
    i_rv1_loopback_ready, // Tells loopback scan that so_data has been read 
    i_rv0_addr_valid, // CPU tells driver that address is ready
    i_rv0_addr_cmd,  // Command for address chain
    i_rv0_addr_address, // Address to be programmed
    o_rv0_addr_ready, // Tells CPU that we are ready to accept new address
    o_rv1_addr_valid, // Address scan tells CPU that new scan out data is valid  
    o_rv1_addr_so_data, // Scan out data from address scan 
    i_rv1_addr_ready, // Tells address scan that so_data has been read 

    // Connections to chip
    o_scan_reset,
    o_scan_update,
    o_scan_en_inst,
    o_scan_in_inst,
    i_scan_clk_p,
    i_scan_clk_n,
    i_scan_reset,
    i_scan_update,
    i_scan_en_inst,
    i_scan_in_inst,
    o_scan_in_address,
    i_scan_out_address,
    o_scan_en_address,
    i_scan_en_address,
    o_scan_in_loopback,
    i_scan_out_loopback
);

//-----------------------------------------------------------------------------------
// Parameters 
//-----------------------------------------------------------------------------------
parameter NumInstChains = 8;
parameter InstChainLength = 28;
parameter AddressChainLength = 7;
//-----------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------
// IOs
//-----------------------------------------------------------------------------------
input wire i_clk_p, i_clk_n;
input wire i_rst;
    
// Ready valid interface for sending commands to instruction chains
input wire i_rv0_inst_valid;
input wire [1:0] i_rv0_inst_cmd;
input wire [NumInstChains-1:0] [InstChainLength-1:0] i_rv0_inst_insts;
output wire o_rv0_inst_ready;
    
// Ready valid interface for receving scan out data from loopback scan
output wire o_rv1_loopback_valid;
output wire [InstChainLength-1:0] o_rv1_loopback_so_data;
input wire i_rv1_loopback_ready;
    
// Ready valid interface for sending commands to address scan
input wire i_rv0_addr_valid;
input wire [AddressChainLength-1:0] i_rv0_addr_address;
input wire [1:0] i_rv0_addr_cmd;
output wire o_rv0_addr_ready;
    
// Ready valid interface for receiving scan out data from address scan
output wire o_rv1_addr_valid;
output wire [AddressChainLength-1:0] o_rv1_addr_so_data;
input wire i_rv1_addr_ready;

// Data input interface
//output wire o_scan_clk_p;
//output wire o_scan_clk_n;
output wire o_scan_reset;
output wire o_scan_update;
output wire o_scan_en_inst;
output wire [NumInstChains-1:0] o_scan_in_inst;
    
// Data output interface (for debug)
input wire i_scan_clk_p;
input wire i_scan_clk_n;
input wire i_scan_reset;
input wire i_scan_update;
input wire i_scan_en_inst;
input wire [NumInstChains-1:0] i_scan_in_inst;

// Address scan in/out and enable signals
output wire o_scan_in_address;
input wire i_scan_out_address;
output wire o_scan_en_address;
input wire i_scan_en_address;

// Misc signals - loopback debug and level shifter output enable
output wire o_scan_in_loopback;
input wire i_scan_out_loopback;
//-----------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------
// Signals
//-----------------------------------------------------------------------------------
genvar i;
wire scan_update_address, scan_reset_address;
wire scan_update_inst, scan_reset_inst;
//-----------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------
// Assigns 
//-----------------------------------------------------------------------------------
assign o_scan_update = scan_update_address || scan_update_inst;        
assign o_scan_reset = scan_reset_address || scan_reset_inst;        

// TODO Not using scan_in_loopback right now 
assign o_scan_in_loopback = 1'b0;
//--------------------------------------------------------------------------------

//--------------------------------------------------------------------------------
// Scan controllers 
//--------------------------------------------------------------------------------
// Address scan chain
scan_controller_single #(
    .ScanChainLength(AddressChainLength)
) s_ctrl_addr (
    .i_clk_p(i_clk_p),
    .i_clk_n(i_clk_n),
    .i_rst(i_rst),
    
    .o_clk_p_gated(), // TODO
    .o_clk_n_gated(), // TODO
    
    .o_rv0_ready(o_rv0_addr_ready),
    .i_rv0_valid(i_rv0_addr_valid),
    .i_rv0_cmd(i_rv0_addr_cmd),
    .i_rv0_scan_in_mem(i_rv0_addr_address),
    
    .i_rv1_ready(i_rv1_addr_ready),
    .o_rv1_valid(o_rv1_addr_valid),
    .o_rv1_scan_out_mem(o_rv1_addr_so_data),

    .i_scan_out(i_scan_out_address),
    .o_scan_en(o_scan_en_address),
    .o_scan_update(scan_update_address),
    .o_scan_reset(scan_reset_address),
    .o_scan_in(o_scan_in_address)
);

// Instruction scan 0 (connects enable, update, and reset)
scan_controller_single #(
    .ScanChainLength(InstChainLength)
) s_ctrl_inst_0 (
    .i_clk_p(i_clk_p),
    .i_clk_n(i_clk_n),
    .i_rst(i_rst),
    
    .o_clk_p_gated(), // TODO
    .o_clk_n_gated(), // TODO
    
    .o_rv0_ready(o_rv0_inst_ready),
    .i_rv0_valid(i_rv0_inst_valid),
    .i_rv0_cmd(i_rv0_inst_cmd),
    .i_rv0_scan_in_mem(i_rv0_inst_insts[0]),
    
    .i_rv1_ready(i_rv1_loopback_ready),
    .o_rv1_valid(o_rv1_loopback_valid),
    .o_rv1_scan_out_mem(o_rv1_loopback_so_data),

    .i_scan_out(i_scan_out_loopback),
    .o_scan_en(o_scan_en_inst),
    .o_scan_update(scan_update_inst),
    .o_scan_reset(scan_reset_inst),
    .o_scan_in(o_scan_in_inst[0])
);

// Instruction scan chains
generate for(i = 0; i < NumInstChains - 1; i = i + 1) begin
    scan_controller_single #(
        .ScanChainLength(InstChainLength)
    ) s_ctrl_inst (
        .i_clk_p(i_clk_p),
        .i_clk_n(i_clk_n),
        .i_rst(i_rst),
        
        .o_clk_p_gated(), // TODO
        .o_clk_n_gated(), // TODO
        
        .o_rv0_ready(), // Unused 
        .i_rv0_valid(i_rv0_inst_valid),
        .i_rv0_cmd(i_rv0_inst_cmd),
        .i_rv0_scan_in_mem(i_rv0_inst_insts[i+1]),
        
        .i_rv1_ready(1'b1),
        .o_rv1_valid(), // Unused
        .o_rv1_scan_out_mem(), // Unused

        .i_scan_out(), // Unused
        .o_scan_en(), // Unused 
        .o_scan_update(), // Unused
        .o_scan_reset(), // Unused
        .o_scan_in(o_scan_in_inst[i+1])
    );
end endgenerate
//--------------------------------------------------------------------------------
endmodule
`default_nettype wire
