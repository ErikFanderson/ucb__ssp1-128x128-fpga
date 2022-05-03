// Description: dummy io module to be used w/ top verilog generator
`default_nettype none
`timescale 1ns/1ps
module MemsDriver (
        input wire IN,
        input wire EN,
        output wire OUT 
    );
    
    assign OUT = (EN) ? IN : 1'bz;

endmodule
`default_nettype wire
