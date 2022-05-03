//==============================================================================
// Author: Erik Anderson
// Description: Driver for superswitch chip w/ added uart interface
// Really just a bunch of scan controllers in parallel.
// Naming conventions:
//    signals => snake_case
//    Parameters (aliasing signal values) => SNAKE_CASE with all caps
//    Parameters (not aliasing signal values) => CamelCase 
//==============================================================================

`default_nettype none
`timescale 1ns/1ps
module ssp1_controller (
    i_sys_clk,
    i_user_clk,
    i_rst,
    o_shifter_oe_n,
    o_led,

    o_uart_tx,
    i_uart_rx,
    o_uart_rts_n,
    i_uart_cts_n,

    i_sda,
    i_scl,
    o_sda_oe_n,
    o_scl_oe_n,

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
parameter NumInstChains = 8;
parameter InstChainLength = 28;
parameter AddressChainLength = 28;
parameter ScanClkDiv = 4;
parameter UARTDataSize = 8;
parameter BaudRate = 115200;
parameter SysClockFrequency = 200000000;
//-----------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------
// Constants 
//-----------------------------------------------------------------------------------
localparam FrameWidth = NumInstChains * InstChainLength;
//-----------------------------------------------------------------------------------
    
//-----------------------------------------------------------------------------------
// IOs
//-----------------------------------------------------------------------------------
input wire i_sys_clk;
input wire i_user_clk;
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
input wire i_sda;
input wire i_scl;
output wire o_sda_oe_n;
output wire o_scl_oe_n;

// Data input interface
output wire o_scan_clk_p;
output wire o_scan_clk_n;
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

//-----------------------------------------------------------------------------------
// Signals
//-----------------------------------------------------------------------------------
genvar i;

wire scan_clk_p, scan_clk_n, scan_cg_en;
wire rst_sync_sys, rst_sync_user, rst_sync_i2c, rst_sync_scan;

wire [3:0] uart_ack_addr_in, uart_ack_addr_in_sync;
wire [3:0] uart_req_addr_in, uart_req_addr_in_sync;
wire [3:0] rv0_addr_valid, rv0_addr_ready;
wire [3:0] [AddressChainLength-1:0] rv0_addr_address;
wire [3:0] [1:0] rv0_addr_cmd;

wire [3:0] uart_ack_inst_in, uart_ack_inst_in_sync;
wire [3:0] uart_req_inst_in, uart_req_inst_in_sync;
wire [3:0] rv0_inst_valid, rv0_inst_ready;
wire [3:0] [FrameWidth-1:0] rv0_inst_insts;
wire [3:0] [1:0] rv0_inst_cmd;

wire [3:0] rv1_loopback_valid;
wire [3:0] rv1_loopback_valid_sync;
wire [3:0] [InstChainLength-1:0] rv1_loopback_so_data;
reg [3:0] [InstChainLength-1:0] rv1_loopback_so_data_sync;

wire uart_mm_reset;
wire i2c_clk;
wire i2c_req, i2c_ack, i2c_ack_sync;
wire [6:0] i2c_slave_address;
wire [1:0] i2c_burst_count_wr;
wire [1:0] i2c_burst_count_rd;
wire i2c_rd_wrn;
wire [3:0] [7:0] i2c_wdata, i2c_rdata;
wire i2c_nack;
wire i2c_rv1_req, i2c_rv1_ack;
//-----------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------
// System clock domain (fixed 200 MHz)
//-----------------------------------------------------------------------------------
// For sys_clk
reset_sync rst_sync_sys_inst (
    .i_clk(i_sys_clk),
    .i_rst_in(i_rst),
    .o_rst_out(rst_sync_sys)
);

// Synchronize incoming addr in ack signal into sys clk domain
generate for (i = 0; i < 4; i++) begin
    synchronizer #(
        .DataSize(1)
    ) addr_in_ack_sync_inst (
        .i_clk(i_sys_clk),
        .i_rst(rst_sync_sys),
        .i_data(uart_ack_addr_in[i]),
        .o_data(uart_ack_addr_in_sync[i])
    );
end endgenerate

// Synchronize incoming inst in ack signal into sys clk domain
generate for (i = 0; i < 4; i++) begin
    synchronizer #(
        .DataSize(1)
    ) inst_in_ack_sync_inst (
        .i_clk(i_sys_clk),
        .i_rst(rst_sync_sys),
        .i_data(uart_ack_inst_in[i]),
        .o_data(uart_ack_inst_in_sync[i])
    );
end endgenerate

// Synchronize incoming i2c ack signal into sys clk domain
synchronizer #(
    .DataSize(1)
) i2c_ack_sync_inst (
    .i_clk(i_sys_clk),
    .i_rst(rst_sync_sys),
    .i_data(i2c_ack),
    .o_data(i2c_ack_sync)
);

// Loopback data sync
generate for (i = 0; i < 4; i++) begin
    // Synchronize incoming loopback valid signal into sys clk domain
    synchronizer #(
        .DataSize(1)
    ) lb_valid_sync_inst (
        .i_clk(i_sys_clk),
        .i_rst(rst_sync_sys),
        .i_data(rv1_loopback_valid[i]),
        .o_data(rv1_loopback_valid_sync[i])
    );

    // Register lb out data (50MHz -> 200MHz pulse will be captured!). Pulse
    // does not need stretching for these launch and capture frequencies
    always @(posedge i_sys_clk or posedge rst_sync_sys) begin
        if (rst_sync_sys) begin
            rv1_loopback_so_data_sync[i] <= {InstChainLength{1'b0}};
        end else if (rv1_loopback_valid_sync) begin
            rv1_loopback_so_data_sync[i] <= rv1_loopback_so_data[i];
        end
    end
end endgenerate

// UART interface
ssp1_controller_uart #(
    .BaudRate(BaudRate),
    .SystemClockFrequency(SysClockFrequency)
) uart (
    .i_clk(i_sys_clk),
    .i_rst(rst_sync_sys),
    
    .o_uart_tx(o_uart_tx),
    .i_uart_rx(i_uart_rx),
    .o_uart_rts_n(o_uart_rts_n),
    .i_uart_cts_n(i_uart_cts_n),
    
    .o_mem_reset(uart_mm_reset),
    .o_mem_leds(o_led),
    .o_mem_shifter_oe_n(o_shifter_oe_n),
    .o_mem_scan_cg_en(scan_cg_en),
    
    .i_mem_loopback_so_data_0(rv1_loopback_so_data_sync[0]),
    .i_mem_loopback_so_data_1(rv1_loopback_so_data_sync[1]),
    .i_mem_loopback_so_data_2(rv1_loopback_so_data_sync[2]),
    .i_mem_loopback_so_data_3(rv1_loopback_so_data_sync[3]),
    
    .o_mem_scan_in_addr_address_0_r0(rv0_addr_address[0][1:0]),
    .o_mem_scan_in_addr_lb_sel_0_r0(rv0_addr_address[0][5:2]),
    .o_mem_scan_in_addr_enable_0_r0(rv0_addr_address[0][6]),
    .o_mem_scan_in_addr_address_0_r1(rv0_addr_address[0][8:7]),
    .o_mem_scan_in_addr_lb_sel_0_r1(rv0_addr_address[0][12:9]),
    .o_mem_scan_in_addr_enable_0_r1(rv0_addr_address[0][13]),
    .o_mem_scan_in_addr_address_0_r2(rv0_addr_address[0][15:14]),
    .o_mem_scan_in_addr_lb_sel_0_r2(rv0_addr_address[0][19:16]),
    .o_mem_scan_in_addr_enable_0_r2(rv0_addr_address[0][20]),
    .o_mem_scan_in_addr_address_0_r3(rv0_addr_address[0][22:21]),
    .o_mem_scan_in_addr_lb_sel_0_r3(rv0_addr_address[0][26:23]),
    .o_mem_scan_in_addr_enable_0_r3(rv0_addr_address[0][27]),
    .o_mem_scan_in_addr_req_0(uart_req_addr_in[0]),
    .i_mem_scan_in_addr_ack_0(uart_ack_addr_in_sync[0]),
    .o_mem_scan_in_addr_cmd_0(rv0_addr_cmd[0]),
    
    .o_mem_scan_in_addr_address_1_r0(rv0_addr_address[1][1:0]),
    .o_mem_scan_in_addr_lb_sel_1_r0(rv0_addr_address[1][5:2]),
    .o_mem_scan_in_addr_enable_1_r0(rv0_addr_address[1][6]),
    .o_mem_scan_in_addr_address_1_r1(rv0_addr_address[1][8:7]),
    .o_mem_scan_in_addr_lb_sel_1_r1(rv0_addr_address[1][12:9]),
    .o_mem_scan_in_addr_enable_1_r1(rv0_addr_address[1][13]),
    .o_mem_scan_in_addr_address_1_r2(rv0_addr_address[1][15:14]),
    .o_mem_scan_in_addr_lb_sel_1_r2(rv0_addr_address[1][19:16]),
    .o_mem_scan_in_addr_enable_1_r2(rv0_addr_address[1][20]),
    .o_mem_scan_in_addr_address_1_r3(rv0_addr_address[1][22:21]),
    .o_mem_scan_in_addr_lb_sel_1_r3(rv0_addr_address[1][26:23]),
    .o_mem_scan_in_addr_enable_1_r3(rv0_addr_address[1][27]),
    .o_mem_scan_in_addr_req_1(uart_req_addr_in[1]),
    .i_mem_scan_in_addr_ack_1(uart_ack_addr_in_sync[1]),
    .o_mem_scan_in_addr_cmd_1(rv0_addr_cmd[1]),
    
    .o_mem_scan_in_addr_address_2_r0(rv0_addr_address[2][1:0]),
    .o_mem_scan_in_addr_lb_sel_2_r0(rv0_addr_address[2][5:2]),
    .o_mem_scan_in_addr_enable_2_r0(rv0_addr_address[2][6]),
    .o_mem_scan_in_addr_address_2_r1(rv0_addr_address[2][8:7]),
    .o_mem_scan_in_addr_lb_sel_2_r1(rv0_addr_address[2][12:9]),
    .o_mem_scan_in_addr_enable_2_r1(rv0_addr_address[2][13]),
    .o_mem_scan_in_addr_address_2_r2(rv0_addr_address[2][15:14]),
    .o_mem_scan_in_addr_lb_sel_2_r2(rv0_addr_address[2][19:16]),
    .o_mem_scan_in_addr_enable_2_r2(rv0_addr_address[2][20]),
    .o_mem_scan_in_addr_address_2_r3(rv0_addr_address[2][22:21]),
    .o_mem_scan_in_addr_lb_sel_2_r3(rv0_addr_address[2][26:23]),
    .o_mem_scan_in_addr_enable_2_r3(rv0_addr_address[2][27]),
    .o_mem_scan_in_addr_req_2(uart_req_addr_in[2]),
    .i_mem_scan_in_addr_ack_2(uart_ack_addr_in_sync[2]),
    .o_mem_scan_in_addr_cmd_2(rv0_addr_cmd[2]),
    
    .o_mem_scan_in_addr_address_3_r0(rv0_addr_address[3][1:0]),
    .o_mem_scan_in_addr_lb_sel_3_r0(rv0_addr_address[3][5:2]),
    .o_mem_scan_in_addr_enable_3_r0(rv0_addr_address[3][6]),
    .o_mem_scan_in_addr_address_3_r1(rv0_addr_address[3][8:7]),
    .o_mem_scan_in_addr_lb_sel_3_r1(rv0_addr_address[3][12:9]),
    .o_mem_scan_in_addr_enable_3_r1(rv0_addr_address[3][13]),
    .o_mem_scan_in_addr_address_3_r2(rv0_addr_address[3][15:14]),
    .o_mem_scan_in_addr_lb_sel_3_r2(rv0_addr_address[3][19:16]),
    .o_mem_scan_in_addr_enable_3_r2(rv0_addr_address[3][20]),
    .o_mem_scan_in_addr_address_3_r3(rv0_addr_address[3][22:21]),
    .o_mem_scan_in_addr_lb_sel_3_r3(rv0_addr_address[3][26:23]),
    .o_mem_scan_in_addr_enable_3_r3(rv0_addr_address[3][27]),
    .o_mem_scan_in_addr_req_3(uart_req_addr_in[3]),
    .i_mem_scan_in_addr_ack_3(uart_ack_addr_in_sync[3]),
    .o_mem_scan_in_addr_cmd_3(rv0_addr_cmd[3]),
    
    .o_mem_scan_in_inst_0_data_0(rv0_inst_insts[0][6:0]),
    .o_mem_scan_in_inst_1_data_0(rv0_inst_insts[0][13:7]),
    .o_mem_scan_in_inst_2_data_0(rv0_inst_insts[0][20:14]),
    .o_mem_scan_in_inst_3_data_0(rv0_inst_insts[0][27:21]),
    .o_mem_scan_in_inst_4_data_0(rv0_inst_insts[0][34:28]),
    .o_mem_scan_in_inst_5_data_0(rv0_inst_insts[0][41:35]),
    .o_mem_scan_in_inst_6_data_0(rv0_inst_insts[0][48:42]),
    .o_mem_scan_in_inst_7_data_0(rv0_inst_insts[0][55:49]),
    .o_mem_scan_in_inst_8_data_0(rv0_inst_insts[0][62:56]),
    .o_mem_scan_in_inst_9_data_0(rv0_inst_insts[0][69:63]),
    .o_mem_scan_in_inst_10_data_0(rv0_inst_insts[0][76:70]),
    .o_mem_scan_in_inst_11_data_0(rv0_inst_insts[0][83:77]),
    .o_mem_scan_in_inst_12_data_0(rv0_inst_insts[0][90:84]),
    .o_mem_scan_in_inst_13_data_0(rv0_inst_insts[0][97:91]),
    .o_mem_scan_in_inst_14_data_0(rv0_inst_insts[0][104:98]),
    .o_mem_scan_in_inst_15_data_0(rv0_inst_insts[0][111:105]),
    .o_mem_scan_in_inst_16_data_0(rv0_inst_insts[0][118:112]),
    .o_mem_scan_in_inst_17_data_0(rv0_inst_insts[0][125:119]),
    .o_mem_scan_in_inst_18_data_0(rv0_inst_insts[0][132:126]),
    .o_mem_scan_in_inst_19_data_0(rv0_inst_insts[0][139:133]),
    .o_mem_scan_in_inst_20_data_0(rv0_inst_insts[0][146:140]),
    .o_mem_scan_in_inst_21_data_0(rv0_inst_insts[0][153:147]),
    .o_mem_scan_in_inst_22_data_0(rv0_inst_insts[0][160:154]),
    .o_mem_scan_in_inst_23_data_0(rv0_inst_insts[0][167:161]),
    .o_mem_scan_in_inst_24_data_0(rv0_inst_insts[0][174:168]),
    .o_mem_scan_in_inst_25_data_0(rv0_inst_insts[0][181:175]),
    .o_mem_scan_in_inst_26_data_0(rv0_inst_insts[0][188:182]),
    .o_mem_scan_in_inst_27_data_0(rv0_inst_insts[0][195:189]),
    .o_mem_scan_in_inst_28_data_0(rv0_inst_insts[0][202:196]),
    .o_mem_scan_in_inst_29_data_0(rv0_inst_insts[0][209:203]),
    .o_mem_scan_in_inst_30_data_0(rv0_inst_insts[0][216:210]),
    .o_mem_scan_in_inst_31_data_0(rv0_inst_insts[0][223:217]),
    .o_mem_scan_in_inst_req_0(uart_req_inst_in[0]),
    .i_mem_scan_in_inst_ack_0(uart_ack_inst_in_sync[0]),
    .o_mem_scan_in_inst_cmd_0(rv0_inst_cmd[0]),
    
    .o_mem_scan_in_inst_0_data_1(rv0_inst_insts[1][6:0]),
    .o_mem_scan_in_inst_1_data_1(rv0_inst_insts[1][13:7]),
    .o_mem_scan_in_inst_2_data_1(rv0_inst_insts[1][20:14]),
    .o_mem_scan_in_inst_3_data_1(rv0_inst_insts[1][27:21]),
    .o_mem_scan_in_inst_4_data_1(rv0_inst_insts[1][34:28]),
    .o_mem_scan_in_inst_5_data_1(rv0_inst_insts[1][41:35]),
    .o_mem_scan_in_inst_6_data_1(rv0_inst_insts[1][48:42]),
    .o_mem_scan_in_inst_7_data_1(rv0_inst_insts[1][55:49]),
    .o_mem_scan_in_inst_8_data_1(rv0_inst_insts[1][62:56]),
    .o_mem_scan_in_inst_9_data_1(rv0_inst_insts[1][69:63]),
    .o_mem_scan_in_inst_10_data_1(rv0_inst_insts[1][76:70]),
    .o_mem_scan_in_inst_11_data_1(rv0_inst_insts[1][83:77]),
    .o_mem_scan_in_inst_12_data_1(rv0_inst_insts[1][90:84]),
    .o_mem_scan_in_inst_13_data_1(rv0_inst_insts[1][97:91]),
    .o_mem_scan_in_inst_14_data_1(rv0_inst_insts[1][104:98]),
    .o_mem_scan_in_inst_15_data_1(rv0_inst_insts[1][111:105]),
    .o_mem_scan_in_inst_16_data_1(rv0_inst_insts[1][118:112]),
    .o_mem_scan_in_inst_17_data_1(rv0_inst_insts[1][125:119]),
    .o_mem_scan_in_inst_18_data_1(rv0_inst_insts[1][132:126]),
    .o_mem_scan_in_inst_19_data_1(rv0_inst_insts[1][139:133]),
    .o_mem_scan_in_inst_20_data_1(rv0_inst_insts[1][146:140]),
    .o_mem_scan_in_inst_21_data_1(rv0_inst_insts[1][153:147]),
    .o_mem_scan_in_inst_22_data_1(rv0_inst_insts[1][160:154]),
    .o_mem_scan_in_inst_23_data_1(rv0_inst_insts[1][167:161]),
    .o_mem_scan_in_inst_24_data_1(rv0_inst_insts[1][174:168]),
    .o_mem_scan_in_inst_25_data_1(rv0_inst_insts[1][181:175]),
    .o_mem_scan_in_inst_26_data_1(rv0_inst_insts[1][188:182]),
    .o_mem_scan_in_inst_27_data_1(rv0_inst_insts[1][195:189]),
    .o_mem_scan_in_inst_28_data_1(rv0_inst_insts[1][202:196]),
    .o_mem_scan_in_inst_29_data_1(rv0_inst_insts[1][209:203]),
    .o_mem_scan_in_inst_30_data_1(rv0_inst_insts[1][216:210]),
    .o_mem_scan_in_inst_31_data_1(rv0_inst_insts[1][223:217]),
    .o_mem_scan_in_inst_req_1(uart_req_inst_in[1]),
    .i_mem_scan_in_inst_ack_1(uart_ack_inst_in_sync[1]),
    .o_mem_scan_in_inst_cmd_1(rv0_inst_cmd[1]),
    
    .o_mem_scan_in_inst_0_data_2(rv0_inst_insts[2][6:0]),
    .o_mem_scan_in_inst_1_data_2(rv0_inst_insts[2][13:7]),
    .o_mem_scan_in_inst_2_data_2(rv0_inst_insts[2][20:14]),
    .o_mem_scan_in_inst_3_data_2(rv0_inst_insts[2][27:21]),
    .o_mem_scan_in_inst_4_data_2(rv0_inst_insts[2][34:28]),
    .o_mem_scan_in_inst_5_data_2(rv0_inst_insts[2][41:35]),
    .o_mem_scan_in_inst_6_data_2(rv0_inst_insts[2][48:42]),
    .o_mem_scan_in_inst_7_data_2(rv0_inst_insts[2][55:49]),
    .o_mem_scan_in_inst_8_data_2(rv0_inst_insts[2][62:56]),
    .o_mem_scan_in_inst_9_data_2(rv0_inst_insts[2][69:63]),
    .o_mem_scan_in_inst_10_data_2(rv0_inst_insts[2][76:70]),
    .o_mem_scan_in_inst_11_data_2(rv0_inst_insts[2][83:77]),
    .o_mem_scan_in_inst_12_data_2(rv0_inst_insts[2][90:84]),
    .o_mem_scan_in_inst_13_data_2(rv0_inst_insts[2][97:91]),
    .o_mem_scan_in_inst_14_data_2(rv0_inst_insts[2][104:98]),
    .o_mem_scan_in_inst_15_data_2(rv0_inst_insts[2][111:105]),
    .o_mem_scan_in_inst_16_data_2(rv0_inst_insts[2][118:112]),
    .o_mem_scan_in_inst_17_data_2(rv0_inst_insts[2][125:119]),
    .o_mem_scan_in_inst_18_data_2(rv0_inst_insts[2][132:126]),
    .o_mem_scan_in_inst_19_data_2(rv0_inst_insts[2][139:133]),
    .o_mem_scan_in_inst_20_data_2(rv0_inst_insts[2][146:140]),
    .o_mem_scan_in_inst_21_data_2(rv0_inst_insts[2][153:147]),
    .o_mem_scan_in_inst_22_data_2(rv0_inst_insts[2][160:154]),
    .o_mem_scan_in_inst_23_data_2(rv0_inst_insts[2][167:161]),
    .o_mem_scan_in_inst_24_data_2(rv0_inst_insts[2][174:168]),
    .o_mem_scan_in_inst_25_data_2(rv0_inst_insts[2][181:175]),
    .o_mem_scan_in_inst_26_data_2(rv0_inst_insts[2][188:182]),
    .o_mem_scan_in_inst_27_data_2(rv0_inst_insts[2][195:189]),
    .o_mem_scan_in_inst_28_data_2(rv0_inst_insts[2][202:196]),
    .o_mem_scan_in_inst_29_data_2(rv0_inst_insts[2][209:203]),
    .o_mem_scan_in_inst_30_data_2(rv0_inst_insts[2][216:210]),
    .o_mem_scan_in_inst_31_data_2(rv0_inst_insts[2][223:217]),
    .o_mem_scan_in_inst_req_2(uart_req_inst_in[2]),
    .i_mem_scan_in_inst_ack_2(uart_ack_inst_in_sync[2]),
    .o_mem_scan_in_inst_cmd_2(rv0_inst_cmd[2]),
    
    .o_mem_scan_in_inst_0_data_3(rv0_inst_insts[3][6:0]),
    .o_mem_scan_in_inst_1_data_3(rv0_inst_insts[3][13:7]),
    .o_mem_scan_in_inst_2_data_3(rv0_inst_insts[3][20:14]),
    .o_mem_scan_in_inst_3_data_3(rv0_inst_insts[3][27:21]),
    .o_mem_scan_in_inst_4_data_3(rv0_inst_insts[3][34:28]),
    .o_mem_scan_in_inst_5_data_3(rv0_inst_insts[3][41:35]),
    .o_mem_scan_in_inst_6_data_3(rv0_inst_insts[3][48:42]),
    .o_mem_scan_in_inst_7_data_3(rv0_inst_insts[3][55:49]),
    .o_mem_scan_in_inst_8_data_3(rv0_inst_insts[3][62:56]),
    .o_mem_scan_in_inst_9_data_3(rv0_inst_insts[3][69:63]),
    .o_mem_scan_in_inst_10_data_3(rv0_inst_insts[3][76:70]),
    .o_mem_scan_in_inst_11_data_3(rv0_inst_insts[3][83:77]),
    .o_mem_scan_in_inst_12_data_3(rv0_inst_insts[3][90:84]),
    .o_mem_scan_in_inst_13_data_3(rv0_inst_insts[3][97:91]),
    .o_mem_scan_in_inst_14_data_3(rv0_inst_insts[3][104:98]),
    .o_mem_scan_in_inst_15_data_3(rv0_inst_insts[3][111:105]),
    .o_mem_scan_in_inst_16_data_3(rv0_inst_insts[3][118:112]),
    .o_mem_scan_in_inst_17_data_3(rv0_inst_insts[3][125:119]),
    .o_mem_scan_in_inst_18_data_3(rv0_inst_insts[3][132:126]),
    .o_mem_scan_in_inst_19_data_3(rv0_inst_insts[3][139:133]),
    .o_mem_scan_in_inst_20_data_3(rv0_inst_insts[3][146:140]),
    .o_mem_scan_in_inst_21_data_3(rv0_inst_insts[3][153:147]),
    .o_mem_scan_in_inst_22_data_3(rv0_inst_insts[3][160:154]),
    .o_mem_scan_in_inst_23_data_3(rv0_inst_insts[3][167:161]),
    .o_mem_scan_in_inst_24_data_3(rv0_inst_insts[3][174:168]),
    .o_mem_scan_in_inst_25_data_3(rv0_inst_insts[3][181:175]),
    .o_mem_scan_in_inst_26_data_3(rv0_inst_insts[3][188:182]),
    .o_mem_scan_in_inst_27_data_3(rv0_inst_insts[3][195:189]),
    .o_mem_scan_in_inst_28_data_3(rv0_inst_insts[3][202:196]),
    .o_mem_scan_in_inst_29_data_3(rv0_inst_insts[3][209:203]),
    .o_mem_scan_in_inst_30_data_3(rv0_inst_insts[3][216:210]),
    .o_mem_scan_in_inst_31_data_3(rv0_inst_insts[3][223:217]),
    .o_mem_scan_in_inst_req_3(uart_req_inst_in[3]),
    .i_mem_scan_in_inst_ack_3(uart_ack_inst_in_sync[3]),
    .o_mem_scan_in_inst_cmd_3(rv0_inst_cmd[3]),
    
    .o_mem_i2c_req(i2c_req),
    .i_mem_i2c_ack(i2c_ack_sync),
    .o_mem_i2c_slave_address(i2c_slave_address),
    .o_mem_i2c_burst_count_wr(i2c_burst_count_wr),
    .o_mem_i2c_burst_count_rd(i2c_burst_count_rd),
    .o_mem_i2c_wdata0(i2c_wdata[0]),
    .o_mem_i2c_wdata1(i2c_wdata[1]),
    .o_mem_i2c_wdata2(i2c_wdata[2]),
    .o_mem_i2c_wdata3(i2c_wdata[3]),
    .o_mem_i2c_rd_wrn(i2c_rd_wrn),
    .i_mem_i2c_nack(i2c_nack),
    .i_mem_i2c_rdata0(i2c_rdata[0]),
    .i_mem_i2c_rdata1(i2c_rdata[1]),
    .i_mem_i2c_rdata2(i2c_rdata[2]),
    .i_mem_i2c_rdata3(i2c_rdata[3])
);
//-----------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------
// I2C clock domain - generated from Sys clk but treated as asynchronous
//-----------------------------------------------------------------------------------
// Clock divider for I2C clock (DIVIDE BY 800)
flex_clk_div #(
    .CntWidth(10)
) i2c_clk_div (
    .i_ref_clk(i_sys_clk),
    .i_rst(rst_sync_sys || uart_mm_reset),
    .i_div_cnt(10'd799),
    .i_high_cnt(10'd400),
    .i_low_cnt(10'd0),
    .o_out_clk(i2c_clk)
);

// For i2c clk
reset_sync rst_sync_i2c_inst (
    .i_clk(i2c_clk),
    .i_rst_in(i_rst || uart_mm_reset),
    .o_rst_out(rst_sync_i2c)
);

// Controller and consumer are same entity! Simplify Req/ack for i2c
assign i2c_rv1_ack = i2c_rv1_req;

// I2C async master (includes syncs for incoming req/ack signals)
i2c_master_async i2c_master_inst (
    .i_clk(i2c_clk),
    .i_rst(rst_sync_i2c),
    .o_sda_oe_n(o_sda_oe_n),
    .o_scl_oe_n(o_scl_oe_n),
    .i_sda(i_sda),
    .i_scl(i_scl),
    .i_rv0_req(i2c_req),
    .o_rv0_ack(i2c_ack),
    .i_rv0_slave_address(i2c_slave_address),
    .i_rv0_wdata(i2c_wdata),
    .i_rv0_burst_count_wr(i2c_burst_count_wr),
    .i_rv0_burst_count_rd(i2c_burst_count_rd),
    .i_rv0_rd_wrn(i2c_rd_wrn),
    .o_rv1_req(i2c_rv1_req), // Unused
    .i_rv1_ack(i2c_rv1_ack), // Unused
    .o_rv1_rdata(i2c_rdata),
    .o_rv1_nack(i2c_nack)
);
//-----------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------
// User/Scan clock domain
//-----------------------------------------------------------------------------------
// For user_clk
reset_sync rst_sync_user_inst (
    .i_clk(i_user_clk),
    .i_rst_in(i_rst || uart_mm_reset),
    .o_rst_out(rst_sync_user)
);

// Generate scan clocks (User clock div by 4)
scan_clk_gen #(.ScanClkDiv(ScanClkDiv)) sclk_gen_inst (
    .i_clk(i_user_clk),
    .i_rst(rst_sync_user),
    .o_scan_clk_p(scan_clk_p),
    .o_scan_clk_n(scan_clk_n)
);

// Clock gate for scan clk p
clock_gate scan_cg_p (
    .i_en(scan_cg_en), 
    .i_clk(scan_clk_p), 
    .o_clk(o_scan_clk_p)
);

// Clock gate for scan clk n 
clock_gate scan_cg_n (
    .i_en(scan_cg_en), 
    .i_clk(scan_clk_n), 
    .o_clk(o_scan_clk_n)
);

// For scan_clk
reset_sync rst_sync_scan_inst (
    .i_clk(o_scan_clk_p),
    .i_rst_in(i_rst || uart_mm_reset),
    .o_rst_out(rst_sync_scan)
);

generate for (i = 0; i < 4; i++) begin
    // Address in req synchronizer 
    synchronizer #(
        .DataSize(1)
    ) addr_in_req_sync_inst (
        .i_clk(o_scan_clk_p),
        .i_rst(rst_sync_scan),
        .i_data(uart_req_addr_in[i]),
        .o_data(uart_req_addr_in_sync[i])
    );
    
    // Instruction in req synchronizer 
    synchronizer #(
        .DataSize(1)
    ) inst_in_req_sync_inst (
        .i_clk(o_scan_clk_p),
        .i_rst(rst_sync_scan),
        .i_data(uart_req_inst_in[i]),
        .o_data(uart_req_inst_in_sync[i])
    );
    
    // Address in handshake
    req_async_handshake addr_in_hs (
        .i_clk(o_scan_clk_p),
        .i_rst(rst_sync_scan),
        .i_ready(rv0_addr_ready[i]),
        .o_valid(rv0_addr_valid[i]),
        .i_req(uart_req_addr_in_sync[i]),
        .o_ack(uart_ack_addr_in[i])
    );
   
    // Instruction in handshake
    req_async_handshake inst_in_hs (
        .i_clk(o_scan_clk_p),
        .i_rst(rst_sync_scan),
        .i_ready(rv0_inst_ready[i]),
        .o_valid(rv0_inst_valid[i]),
        .i_req(uart_req_inst_in_sync[i]),
        .o_ack(uart_ack_inst_in[i])
    );

    // Superswitch driver
    superswitch_driver #(
        .NumInstChains(NumInstChains),
        .InstChainLength(InstChainLength),
        .AddressChainLength(AddressChainLength)
    ) ss_inst (
        .i_clk_p(o_scan_clk_p),
        .i_clk_n(o_scan_clk_n),
        .i_rst(rst_sync_scan),
        // Instruction scan in
        .i_rv0_inst_valid(rv0_inst_valid[i]),
        .i_rv0_inst_cmd(rv0_inst_cmd[i]),
        .i_rv0_inst_insts(rv0_inst_insts[i]),
        .o_rv0_inst_ready(rv0_inst_ready[i]),
        // Loopback scan out
        .o_rv1_loopback_valid(rv1_loopback_valid[i]),
        .o_rv1_loopback_so_data(rv1_loopback_so_data[i]),
        .i_rv1_loopback_ready(1'b1), // Always ready! (just use rv0 req/ack)
        // Address scan in
        .i_rv0_addr_valid(rv0_addr_valid[i]),
        .i_rv0_addr_cmd(rv0_addr_cmd[i]),
        .i_rv0_addr_address(rv0_addr_address[i]),
        .o_rv0_addr_ready(rv0_addr_ready[i]),
        // Address scan out
        .o_rv1_addr_valid(), // Unused
        .o_rv1_addr_so_data(), // Unused
        .i_rv1_addr_ready(1'b1),
        // Chip connections
        //.o_scan_clk_p(o_scan_clk_p), // TODO gated output clocks?
        //.o_scan_clk_n(o_scan_clk_n), // TODO gated output clocks?
        .o_scan_reset(o_scan_reset[i]),
        .o_scan_update(o_scan_update[i]),
        .o_scan_en_inst(o_scan_en_inst[i]),
        .o_scan_in_inst(o_scan_in_inst[i]),
        .i_scan_clk_p(1'b0), // Unused
        .i_scan_clk_n(1'b0), // Unused
        .i_scan_reset(1'b0), // Unused
        .i_scan_update(1'b0), // Unused
        .i_scan_en_inst(1'b0), // Unused
        .i_scan_in_inst(8'd0), // Unused
        .o_scan_in_address(o_scan_in_address[i]),
        .i_scan_out_address(1'b0), // Unused
        .o_scan_en_address(o_scan_en_address[i]),
        .i_scan_en_address(1'b0), // Unused
        .o_scan_in_loopback(), // Unused
        .i_scan_out_loopback(i_scan_out_loopback[i])
    );
end endgenerate
//-----------------------------------------------------------------------------------

endmodule
`default_nettype wire
