//==============================================================================
// Author: Erik Anderson 
// Email: efa@eecs.berkeley.edu 
// Description: <Insert Description Here> 
// Naming conventions:
//    signals => snake_case
//    Parameters (aliasing signal values) => SNAKE_CASE with all caps
//    Parameters (not aliasing signal values) => CamelCase 
//==============================================================================
`timescale 1ns/1ps
`default_nettype none

interface ssp1_controller_bfm;
//------------------------------------------------------------------------------
// Parameters 
//------------------------------------------------------------------------------
parameter real SysClockCycle = 1.0;
parameter real UserClockCycle = 1.0;

`include "parameters.vh"
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Constants (localparam) 
//------------------------------------------------------------------------------
localparam real HalfSysClockCycle = SysClockCycle/2.0;
localparam real HalfUserClockCycle = UserClockCycle/2.0;
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Inputs/Outputs 
//------------------------------------------------------------------------------
logic i_sys_clk;
logic i_user_clk;
logic i_rst;
    
// MISC FPGA/PCB signals
logic o_shifter_oe_n;
logic [7:0] o_led;

// UART interface
logic [UARTDataSize-1:0] tx_data, rx_data;
logic tx_ready, tx_valid;
logic rx_ready, rx_valid;

logic i_sda, i_scl;
logic o_sda_oe_n, o_scl_oe_n;
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Tasks
//------------------------------------------------------------------------------
int i;

//task write(input [7:0] address, input [7:0] data);
//    begin
//        // Write address byte (MSb = 0, lower bits are address)
//        tx_valid = 1'b1;
//        tx_data = {1'b0, address};
//        #(SysClockCycle);
//        tx_valid = 1'b0;
//        #(100000*SysClockCycle);
//        // Write data byte 
//        tx_valid = 1'b1;
//        tx_data = data;
//        #(SysClockCycle);
//        tx_valid = 1'b0;
//        #(100000*SysClockCycle);
//    end
//endtask
//
//task read(input [7:0] address, output [7:0] data);
//    begin
//        // Write address byte 1 (MSb = 1, lower bits are address)
//        tx_valid = 1'b1;
//        tx_data = {1'b1, address[14:8]};
//        while (tx_ready != 1'b1) begin
//            #(SysClockCycle);
//        end
//        
//        // Write address byte 2
//        tx_valid = 1'b1;
//        tx_data = address[7:0];
//        while (tx_ready != 1'b1) begin
//            #(SysClockCycle);
//        end
//
//        // Receive data
//        tx_valid = 1'b0;
//        while(rx_valid != 1) begin
//            #(SysClockCycle);
//        end
//        data = rx_data;
//        
//        //#(100000*SysClockCycle);
//        ////while (received == 1'b0) #(SysClockCycle);
//        //#(100000*SysClockCycle);
//        //data = rx_data;
//    end
//endtask

task write(input [7:0] address, input [7:0] data);
    begin
        // Write address byte 1 (MSb = 0, lower bits are address)
        tx_valid = 1'b1;
        tx_data = {1'b0, address[7:1]};
        while (tx_ready != 1'b1) begin
            #(SysClockCycle);
        end
        #(SysClockCycle);
        
        // Write address byte 2
        tx_valid = 1'b1;
        tx_data = {address[0], 7'd0};
        while (tx_ready != 1'b1) begin
            #(SysClockCycle);
        end
        #(SysClockCycle);
        
        // Write data byte
        tx_valid = 1'b1;
        tx_data = data;
        while (tx_ready != 1'b1) begin
            #(SysClockCycle);
        end
        #(SysClockCycle);
        
        // Wait for tx_ready
        while (tx_ready != 1'b1) begin
            #(SysClockCycle);
        end
    end
endtask

task read(input [7:0] address, output [7:0] data);
    begin
        // Write address byte (MSb = 1, lower bits are address)
        tx_valid = 1'b1;
        tx_data = {1'b1, address[7:1]};
        while (tx_ready != 1'b1) begin
            #(SysClockCycle);
        end
        #(SysClockCycle);
        
        // Write address byte 2
        tx_valid = 1'b1;
        tx_data = {address[0], 7'd0};
        while (tx_ready != 1'b1) begin
            #(SysClockCycle);
        end
        #(SysClockCycle);
        
        // Receive data
        tx_valid = 1'b0;
        while(rx_valid != 1) begin
            #(SysClockCycle);
        end
        data = rx_data;
        
        // Wait for tx_ready
        while (tx_ready != 1'b1) begin
            #(SysClockCycle);
        end
    end
endtask

`include "uart_tasks.svh"
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Initial stuff
//------------------------------------------------------------------------------
initial begin
    i_sys_clk = 0;
    forever begin
        #(HalfSysClockCycle);
        i_sys_clk = ~i_sys_clk;
    end
end

initial begin
    i_user_clk = 0;
    forever begin
        #(HalfUserClockCycle);
        i_user_clk = ~i_user_clk;
    end
end
//------------------------------------------------------------------------------
endinterface : ssp1_controller_bfm 

`default_nettype wire 
