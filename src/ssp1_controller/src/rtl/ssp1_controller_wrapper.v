//==============================================================================
// Author: Erik Anderson
// Description: FPGA wrapper for superswitch chip.
// Adds in explicit IO buffers for things like converting CML clocks to single
// ended
// Naming conventions:
//    signals => snake_case
//    Parameters (aliasing signal values) => SNAKE_CASE with all caps
//    Parameters (not aliasing signal values) => CamelCase 
//==============================================================================

`default_nettype none
`timescale 1ns/1ps
module ssp1_controller_wrapper (
    i_sys_clk_p,
    i_sys_clk_n,
    i_user_clk_p,
    i_user_clk_n,
    i_rst,
    o_shifter_oe_n,
    o_led,

    o_uart_tx,
    i_uart_rx,
    o_uart_rts_n,
    i_uart_cts_n,

    io_sda,
    io_scl,
    o_i2c_rst_n,

    o_scan_clk_p,
    o_scan_clk_n,
    o_scan_reset,
    o_scan_update,
    o_scan_en_inst,
    o_scan_in_inst,
    o_scan_in_address,
    o_scan_en_address,
    i_scan_out_loopback
);

//-----------------------------------------------------------------------------------
// Parameters 
//-----------------------------------------------------------------------------------
`include "parameters.vh"
//-----------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------
// IOs
//-----------------------------------------------------------------------------------
// Clocks and reset
input wire i_sys_clk_p;
input wire i_sys_clk_n;
input wire i_user_clk_p;
input wire i_user_clk_n;
input wire i_rst;

// MISC FPGA/PCB signals
output wire o_shifter_oe_n;
output wire [7:0] o_led;

// UART interface
output wire o_uart_tx;
input wire i_uart_rx;
output wire o_uart_rts_n;
input wire i_uart_cts_n;
    
// I2C interface
inout wire io_sda;
inout wire io_scl;
output wire o_i2c_rst_n;

// Data input interface
output wire [3:0] o_scan_clk_p; // TODO
output wire [3:0] o_scan_clk_n; // TODO
output wire [3:0] o_scan_reset;
output wire [3:0] o_scan_update;
output wire [3:0] o_scan_en_inst;
output wire [3:0] [NumInstChains-1:0] o_scan_in_inst;
    
// Address scan in/out and enable signals
output wire [3:0] o_scan_in_address;
output wire [3:0] o_scan_en_address;

// Misc signals - loopback debug and level shifter output enable
input wire [3:0] i_scan_out_loopback;
//-----------------------------------------------------------------------------------

// Convert LVDS clock to internal clock signal
wire sys_clk;
IBUFGDS #(
    .DIFF_TERM("FALSE"), // Differential termination
    .IBUF_LOW_PWR("TRUE"), // Low power="TRUE", High performance="FALSE"
    .IOSTANDARD("DEFAULT") // Specify input IO standard
) IBUFGDS_sys_clk_inst (
    .O(sys_clk), // Clock output buffer
    .I(i_sys_clk_p), // Diff_p clock buffer input (connect directly to top-level port)
    .IB(i_sys_clk_n) // Diff_n clock buffer input (connect directly to top-level port)
);

// Convert LVDS clock to internal clock signal
wire user_clk;
IBUFGDS #(
    .DIFF_TERM("FALSE"), // Differential termination
    .IBUF_LOW_PWR("TRUE"), // Low power="TRUE", High performance="FALSE"
    .IOSTANDARD("DEFAULT") // Specify input IO standard
) IBUFGDS_user_clk_inst (
    .O(user_clk), // Clock output buffer
    .I(i_user_clk_p), // Diff_p clock buffer input (connect directly to top-level port)
    .IB(i_user_clk_n) // Diff_n clock buffer input (connect directly to top-level port)
);

// SDA I2C I/O buffer
wire sda_oe_n, sda;
IOBUF #(
    .DRIVE(12), // Specify the output drive strength
    .IBUF_LOW_PWR("TRUE"), // Low Power - "TRUE", High Performance = "FALSE"
    .IOSTANDARD("DEFAULT"), // Specify the output I/O standard
    .SLEW("SLOW") // Specify the output slew rate
) sda_iobuf (
    .O(sda), // Buffer output
    .IO(io_sda), // Buffer inout port (connect directly to top-level port)
    .I(1'b0), // Buffer input
    .T(sda_oe_n) // 3-state enable input, high=input, low=output
);

// SCL I2C I/O buffer
wire scl_oe_n, scl;
IOBUF #(
    .DRIVE(12), // Specify the output drive strength
    .IBUF_LOW_PWR("TRUE"), // Low Power - "TRUE", High Performance = "FALSE"
    .IOSTANDARD("DEFAULT"), // Specify the output I/O standard
    .SLEW("SLOW") // Specify the output slew rate
) scl_iobuf (
    .O(scl), // Buffer output
    .IO(io_scl), // Buffer inout port (connect directly to top-level port)
    .I(1'b0), // Buffer input
    .T(scl_oe_n) // 3-state enable input, high=input, low=output
);

// Pull i2c bus mux out of reset
assign o_i2c_rst_n = 1'b1;

//-----------------------------------------------------------------------------------
// Connect actual superswitch driver
//-----------------------------------------------------------------------------------
// Fanout clocks
genvar i;
wire scan_clk_p, scan_clk_n;
generate for (i = 0; i < 4; i++) begin
    assign o_scan_clk_p[i] = scan_clk_p;
    assign o_scan_clk_n[i] = scan_clk_n;
end endgenerate

// Instantiate controller
ssp1_controller #(
    .NumInstChains(NumInstChains),
    .InstChainLength(InstChainLength),
    .AddressChainLength(AddressChainLength),
    .ScanClkDiv(ScanClkDiv),
    .UARTDataSize(UARTDataSize),
    .BaudRate(BaudRate),
    .SysClockFrequency(SysClockFrequency)
) driver_inst (
    .i_sys_clk(sys_clk),
    .i_user_clk(user_clk),
    .i_rst(i_rst),
    .o_shifter_oe_n(o_shifter_oe_n),
    .o_led(o_led),

    .o_uart_tx(o_uart_tx),
    .i_uart_rx(i_uart_rx),
    .o_uart_rts_n(o_uart_rts_n),
    .i_uart_cts_n(i_uart_cts_n),

    .i_sda(sda),
    .i_scl(scl),
    .o_sda_oe_n(sda_oe_n),
    .o_scl_oe_n(scl_oe_n),

    .o_scan_clk_p(scan_clk_p),
    .o_scan_clk_n(scan_clk_n),
    .o_scan_reset(o_scan_reset),
    .o_scan_update(o_scan_update),
    .o_scan_en_inst(o_scan_en_inst),
    .o_scan_in_inst(o_scan_in_inst),
    .o_scan_in_address(o_scan_in_address),
    .o_scan_en_address(o_scan_en_address),
    .i_scan_out_loopback(i_scan_out_loopback)
);
//-----------------------------------------------------------------------------------
endmodule
`default_nettype wire
