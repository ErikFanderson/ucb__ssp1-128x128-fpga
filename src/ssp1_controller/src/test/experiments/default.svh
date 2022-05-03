//==============================================================================
// Author: Erik Anderson 
// Email: efa@eecs.berkeley.edu
// Description: Top level testbench for "ssp1_controller"
// Naming conventions:
//    signals => snake_case
//    Parameters (aliasing signal values) => SNAKE_CASE with all caps
//    Parameters (not aliasing signal values) => CamelCase 
//==============================================================================
task run_experiment;
    bit test;
    int rdata, i;
    test = 1;

    // Initialize IOs
    bfm.i_rst = 1'b1;
    bfm.tx_valid = 1'b0;
    bfm.tx_data = 7'd0;
    bfm.rx_ready = 1'b1;
    #(1*bfm.SysClockCycle);
    bfm.i_rst = 1'b0;
        
    // Extra cycles to allow for reset sync to get deasserted 
    #(1000*bfm.SysClockCycle);
    
    // Place design in reset (i.e. not UART but everything else)
    $display("Place design in reset via UART...");
    bfm.write_FIELD_RESET_REG_reset(1'b1);
    bfm.read_FIELD_RESET_REG_reset(rdata);
    $display("rst: %0d", rdata);
    
    // Reset everything to 0 while design is in reset!
    for (i = 0; i <= 255; i = i +1) begin
        if (i != `RESET_field_addr) begin
            $display("Writing address: [%0d]", i);
            bfm.write(i, 8'h00);
        end
    end
    
    // Take design out of reset
    $display("Place design out of reset via UART...");
    bfm.write_FIELD_RESET_REG_reset(1'b0);
    bfm.read_FIELD_RESET_REG_reset(rdata);
    $display("rst: %0d", rdata);
    bfm.write_FIELD_USER_REG_scan_cg_en(1'b1);
   
    //-------------------------------------------------------------------------
    // Reset scan chains
    //-------------------------------------------------------------------------
    // COLUMN 0
    $display("Resetting scan chains column 0...");
    bfm.write_FIELD_ADDRESS_0_REG_scan_in_addr_cmd_0(2'b00); // Scan reset
    bfm.write_FIELD_ADDRESS_0_REG_scan_in_addr_req_0(1'b1);
    bfm.read_FIELD_ADDRESS_0_REG_scan_in_addr_ack_0(rdata);
    while (rdata != 1'b1) begin
        bfm.read_FIELD_ADDRESS_0_REG_scan_in_addr_ack_0(rdata); // Read advances time
    end
    $display("Scan chains placed in reset.");
    
    bfm.write_FIELD_ADDRESS_0_REG_scan_in_addr_req_0(1'b0);
    bfm.read_FIELD_ADDRESS_0_REG_scan_in_addr_ack_0(rdata);
    while (rdata != 1'b0) begin
        bfm.read_FIELD_ADDRESS_0_REG_scan_in_addr_ack_0(rdata); // Read advances time
    end
    $display("Scan chains placed out of reset.");
    
    // COLUMN 1 
    $display("Resetting scan chains column 1...");
    bfm.write_FIELD_ADDRESS_1_REG_scan_in_addr_cmd_1(2'b00); // Scan reset
    bfm.write_FIELD_ADDRESS_1_REG_scan_in_addr_req_1(1'b1);
    bfm.read_FIELD_ADDRESS_1_REG_scan_in_addr_ack_1(rdata);
    while (rdata != 1'b1) begin
        bfm.read_FIELD_ADDRESS_1_REG_scan_in_addr_ack_1(rdata); // Read advances time
    end
    $display("Scan chains placed in reset.");
    
    bfm.write_FIELD_ADDRESS_1_REG_scan_in_addr_req_1(1'b0);
    bfm.read_FIELD_ADDRESS_1_REG_scan_in_addr_ack_1(rdata);
    while (rdata != 1'b0) begin
        bfm.read_FIELD_ADDRESS_1_REG_scan_in_addr_ack_1(rdata); // Read advances time
    end
    $display("Scan chains placed out of reset.");
    
    // COLUMN 2 
    $display("Resetting scan chains column 2...");
    bfm.write_FIELD_ADDRESS_2_REG_scan_in_addr_cmd_2(2'b00); // Scan reset
    bfm.write_FIELD_ADDRESS_2_REG_scan_in_addr_req_2(1'b1);
    bfm.read_FIELD_ADDRESS_2_REG_scan_in_addr_ack_2(rdata);
    while (rdata != 1'b1) begin
        bfm.read_FIELD_ADDRESS_2_REG_scan_in_addr_ack_2(rdata); // Read advances time
    end
    $display("Scan chains placed in reset.");
    
    bfm.write_FIELD_ADDRESS_2_REG_scan_in_addr_req_2(1'b0);
    bfm.read_FIELD_ADDRESS_2_REG_scan_in_addr_ack_2(rdata);
    while (rdata != 1'b0) begin
        bfm.read_FIELD_ADDRESS_2_REG_scan_in_addr_ack_2(rdata); // Read advances time
    end
    $display("Scan chains placed out of reset.");
    
    // COLUMN 3 
    $display("Resetting scan chains column 3...");
    bfm.write_FIELD_ADDRESS_3_REG_scan_in_addr_cmd_3(2'b00); // Scan reset
    bfm.write_FIELD_ADDRESS_3_REG_scan_in_addr_req_3(1'b1);
    bfm.read_FIELD_ADDRESS_3_REG_scan_in_addr_ack_3(rdata);
    while (rdata != 1'b1) begin
        bfm.read_FIELD_ADDRESS_3_REG_scan_in_addr_ack_3(rdata); // Read advances time
    end
    $display("Scan chains placed in reset.");
    
    bfm.write_FIELD_ADDRESS_3_REG_scan_in_addr_req_3(1'b0);
    bfm.read_FIELD_ADDRESS_3_REG_scan_in_addr_ack_3(rdata);
    while (rdata != 1'b0) begin
        bfm.read_FIELD_ADDRESS_3_REG_scan_in_addr_ack_3(rdata); // Read advances time
    end
    $display("Scan chains placed out of reset.");
    //-------------------------------------------------------------------------
    
    //-------------------------------------------------------------------------
    // Program address
    //-------------------------------------------------------------------------
    // Column 0
    $display("Program address column 0...");
    bfm.write_FIELD_ADDRESS_0_REG_scan_in_addr_address_0_r0(2'b11);
    bfm.write_FIELD_ADDRESS_0_REG_scan_in_addr_lb_sel_0_r0(4'b0000);
    bfm.write_FIELD_ADDRESS_0_REG_scan_in_addr_enable_0_r0(1'b0);
    bfm.write_FIELD_ADDRESS_0_REG_scan_in_addr_address_0_r1(2'b10);
    bfm.write_FIELD_ADDRESS_0_REG_scan_in_addr_lb_sel_0_r1(4'b0000);
    bfm.write_FIELD_ADDRESS_0_REG_scan_in_addr_enable_0_r1(1'b0);
    bfm.write_FIELD_ADDRESS_0_REG_scan_in_addr_address_0_r2(2'b01);
    bfm.write_FIELD_ADDRESS_0_REG_scan_in_addr_lb_sel_0_r2(4'b0000);
    bfm.write_FIELD_ADDRESS_0_REG_scan_in_addr_enable_0_r2(1'b0);
    bfm.write_FIELD_ADDRESS_0_REG_scan_in_addr_address_0_r3(2'b00);
    bfm.write_FIELD_ADDRESS_0_REG_scan_in_addr_lb_sel_0_r3(4'b0000);
    bfm.write_FIELD_ADDRESS_0_REG_scan_in_addr_enable_0_r3(1'b0);
    bfm.write_FIELD_ADDRESS_0_REG_scan_in_addr_cmd_0(2'b01); // Scan in 
    
    bfm.write_FIELD_ADDRESS_0_REG_scan_in_addr_req_0(1'b1);
    bfm.read_FIELD_ADDRESS_0_REG_scan_in_addr_ack_0(rdata);
    while (rdata != 1'b1) begin
        bfm.read_FIELD_ADDRESS_0_REG_scan_in_addr_ack_0(rdata); // Read advances time
    end
    $display("Address scan in complete.");
    
    // Column 1 
    $display("Program address column 1...");
    bfm.write_FIELD_ADDRESS_1_REG_scan_in_addr_address_1_r0(2'b11);
    bfm.write_FIELD_ADDRESS_1_REG_scan_in_addr_lb_sel_1_r0(4'b0000);
    bfm.write_FIELD_ADDRESS_1_REG_scan_in_addr_enable_1_r0(1'b0);
    bfm.write_FIELD_ADDRESS_1_REG_scan_in_addr_address_1_r1(2'b10);
    bfm.write_FIELD_ADDRESS_1_REG_scan_in_addr_lb_sel_1_r1(4'b0000);
    bfm.write_FIELD_ADDRESS_1_REG_scan_in_addr_enable_1_r1(1'b0);
    bfm.write_FIELD_ADDRESS_1_REG_scan_in_addr_address_1_r2(2'b01);
    bfm.write_FIELD_ADDRESS_1_REG_scan_in_addr_lb_sel_1_r2(4'b0000);
    bfm.write_FIELD_ADDRESS_1_REG_scan_in_addr_enable_1_r2(1'b0);
    bfm.write_FIELD_ADDRESS_1_REG_scan_in_addr_address_1_r3(2'b00);
    bfm.write_FIELD_ADDRESS_1_REG_scan_in_addr_lb_sel_1_r3(4'b0000);
    bfm.write_FIELD_ADDRESS_1_REG_scan_in_addr_enable_1_r3(1'b0);
    bfm.write_FIELD_ADDRESS_1_REG_scan_in_addr_cmd_1(2'b01); // Scan in 
    
    bfm.write_FIELD_ADDRESS_1_REG_scan_in_addr_req_1(1'b1);
    bfm.read_FIELD_ADDRESS_1_REG_scan_in_addr_ack_1(rdata);
    while (rdata != 1'b1) begin
        bfm.read_FIELD_ADDRESS_1_REG_scan_in_addr_ack_1(rdata); // Read advances time
    end
    $display("Address scan in complete.");
    
    // Column 2 
    $display("Program address column 2...");
    bfm.write_FIELD_ADDRESS_2_REG_scan_in_addr_address_2_r0(2'b11);
    bfm.write_FIELD_ADDRESS_2_REG_scan_in_addr_lb_sel_2_r0(4'b0000);
    bfm.write_FIELD_ADDRESS_2_REG_scan_in_addr_enable_2_r0(1'b0);
    bfm.write_FIELD_ADDRESS_2_REG_scan_in_addr_address_2_r1(2'b10);
    bfm.write_FIELD_ADDRESS_2_REG_scan_in_addr_lb_sel_2_r1(4'b0000);
    bfm.write_FIELD_ADDRESS_2_REG_scan_in_addr_enable_2_r1(1'b0);
    bfm.write_FIELD_ADDRESS_2_REG_scan_in_addr_address_2_r2(2'b01);
    bfm.write_FIELD_ADDRESS_2_REG_scan_in_addr_lb_sel_2_r2(4'b0000);
    bfm.write_FIELD_ADDRESS_2_REG_scan_in_addr_enable_2_r2(1'b0);
    bfm.write_FIELD_ADDRESS_2_REG_scan_in_addr_address_2_r3(2'b00);
    bfm.write_FIELD_ADDRESS_2_REG_scan_in_addr_lb_sel_2_r3(4'b0000);
    bfm.write_FIELD_ADDRESS_2_REG_scan_in_addr_enable_2_r3(1'b0);
    bfm.write_FIELD_ADDRESS_2_REG_scan_in_addr_cmd_2(2'b01); // Scan in 
    
    bfm.write_FIELD_ADDRESS_2_REG_scan_in_addr_req_2(1'b1);
    bfm.read_FIELD_ADDRESS_2_REG_scan_in_addr_ack_2(rdata);
    while (rdata != 1'b1) begin
        bfm.read_FIELD_ADDRESS_2_REG_scan_in_addr_ack_2(rdata); // Read advances time
    end
    $display("Address scan in complete.");
    
    // Column 3 
    $display("Program address column 3...");
    bfm.write_FIELD_ADDRESS_3_REG_scan_in_addr_address_3_r0(2'b11);
    bfm.write_FIELD_ADDRESS_3_REG_scan_in_addr_lb_sel_3_r0(4'b0000);
    bfm.write_FIELD_ADDRESS_3_REG_scan_in_addr_enable_3_r0(1'b0);
    bfm.write_FIELD_ADDRESS_3_REG_scan_in_addr_address_3_r1(2'b10);
    bfm.write_FIELD_ADDRESS_3_REG_scan_in_addr_lb_sel_3_r1(4'b0000);
    bfm.write_FIELD_ADDRESS_3_REG_scan_in_addr_enable_3_r1(1'b0);
    bfm.write_FIELD_ADDRESS_3_REG_scan_in_addr_address_3_r2(2'b01);
    bfm.write_FIELD_ADDRESS_3_REG_scan_in_addr_lb_sel_3_r2(4'b0000);
    bfm.write_FIELD_ADDRESS_3_REG_scan_in_addr_enable_3_r2(1'b0);
    bfm.write_FIELD_ADDRESS_3_REG_scan_in_addr_address_3_r3(2'b00);
    bfm.write_FIELD_ADDRESS_3_REG_scan_in_addr_lb_sel_3_r3(4'b0000);
    bfm.write_FIELD_ADDRESS_3_REG_scan_in_addr_enable_3_r3(1'b0);
    bfm.write_FIELD_ADDRESS_3_REG_scan_in_addr_cmd_3(2'b01); // Scan in 
    
    bfm.write_FIELD_ADDRESS_3_REG_scan_in_addr_req_3(1'b1);
    bfm.read_FIELD_ADDRESS_3_REG_scan_in_addr_ack_3(rdata);
    while (rdata != 1'b1) begin
        bfm.read_FIELD_ADDRESS_3_REG_scan_in_addr_ack_3(rdata); // Read advances time
    end
    $display("Address scan in complete.");
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Loopback test
    //-------------------------------------------------------------------------
    // Column 0
    $display("Running loopback test chiplet column 0...");
    bfm.write_FIELD_INSTRUCTION_0_REG_scan_in_inst_0_data_0({5'b00000, 2'b11});
    bfm.write_FIELD_INSTRUCTION_0_REG_scan_in_inst_1_data_0({5'b00000, 2'b11});
    bfm.write_FIELD_INSTRUCTION_0_REG_scan_in_inst_2_data_0({5'b00000, 2'b11});
    bfm.write_FIELD_INSTRUCTION_0_REG_scan_in_inst_3_data_0({5'b00000, 2'b11});
    bfm.write_FIELD_INSTRUCTION_0_REG_scan_in_inst_4_data_0({5'b00000, 2'b11});
    bfm.write_FIELD_INSTRUCTION_0_REG_scan_in_inst_5_data_0({5'b00000, 2'b11});
    bfm.write_FIELD_INSTRUCTION_0_REG_scan_in_inst_6_data_0({5'b00000, 2'b11});
    bfm.write_FIELD_INSTRUCTION_0_REG_scan_in_inst_7_data_0({5'b00000, 2'b11});
    bfm.write_FIELD_INSTRUCTION_0_REG_scan_in_inst_8_data_0({5'b00000, 2'b11});
    bfm.write_FIELD_INSTRUCTION_0_REG_scan_in_inst_9_data_0({5'b00000, 2'b11});
    bfm.write_FIELD_INSTRUCTION_0_REG_scan_in_inst_10_data_0({5'b00000, 2'b11});
    bfm.write_FIELD_INSTRUCTION_0_REG_scan_in_inst_11_data_0({5'b00000, 2'b11});
    bfm.write_FIELD_INSTRUCTION_0_REG_scan_in_inst_12_data_0({5'b00000, 2'b11});
    bfm.write_FIELD_INSTRUCTION_0_REG_scan_in_inst_13_data_0({5'b00000, 2'b11});
    bfm.write_FIELD_INSTRUCTION_0_REG_scan_in_inst_14_data_0({5'b00000, 2'b11});
    bfm.write_FIELD_INSTRUCTION_0_REG_scan_in_inst_15_data_0({5'b00000, 2'b11});
    bfm.write_FIELD_INSTRUCTION_0_REG_scan_in_inst_16_data_0({5'b00000, 2'b11});
    bfm.write_FIELD_INSTRUCTION_0_REG_scan_in_inst_17_data_0({5'b00000, 2'b11});
    bfm.write_FIELD_INSTRUCTION_0_REG_scan_in_inst_18_data_0({5'b00000, 2'b11});
    bfm.write_FIELD_INSTRUCTION_0_REG_scan_in_inst_19_data_0({5'b00000, 2'b11});
    bfm.write_FIELD_INSTRUCTION_0_REG_scan_in_inst_20_data_0({5'b00000, 2'b11});
    bfm.write_FIELD_INSTRUCTION_0_REG_scan_in_inst_21_data_0({5'b00000, 2'b11});
    bfm.write_FIELD_INSTRUCTION_0_REG_scan_in_inst_22_data_0({5'b00000, 2'b11});
    bfm.write_FIELD_INSTRUCTION_0_REG_scan_in_inst_23_data_0({5'b00000, 2'b11});
    bfm.write_FIELD_INSTRUCTION_0_REG_scan_in_inst_24_data_0({5'b00000, 2'b11});
    bfm.write_FIELD_INSTRUCTION_0_REG_scan_in_inst_25_data_0({5'b00000, 2'b11});
    bfm.write_FIELD_INSTRUCTION_0_REG_scan_in_inst_26_data_0({5'b00000, 2'b11});
    bfm.write_FIELD_INSTRUCTION_0_REG_scan_in_inst_27_data_0({5'b00000, 2'b11});
    bfm.write_FIELD_INSTRUCTION_0_REG_scan_in_inst_28_data_0({5'b00000, 2'b11});
    bfm.write_FIELD_INSTRUCTION_0_REG_scan_in_inst_29_data_0({5'b00000, 2'b11});
    bfm.write_FIELD_INSTRUCTION_0_REG_scan_in_inst_30_data_0({5'b00000, 2'b11});
    bfm.write_FIELD_INSTRUCTION_0_REG_scan_in_inst_31_data_0({5'b00000, 2'b11});
    
    bfm.write_FIELD_INSTRUCTION_0_REG_scan_in_inst_cmd_0(2'b01); // Scan in
    bfm.write_FIELD_INSTRUCTION_0_REG_scan_in_inst_req_0(1'b1);
    bfm.read_FIELD_INSTRUCTION_0_REG_scan_in_inst_ack_0(rdata);
    while (rdata != 1'b1) begin
        bfm.read_FIELD_INSTRUCTION_0_REG_scan_in_inst_ack_0(rdata); // Read advances time
    end
    $display("Instruction scan in complete.");
    bfm.read_FIELD_LOOPBACK_REG_loopback_so_data_0(rdata);
    $display("Loopback data: %028b", rdata);
    
    // Column 1
    $display("Running loopback test chiplet column 1...");
    bfm.write_FIELD_INSTRUCTION_1_REG_scan_in_inst_0_data_1({5'b00001, 2'b11});
    bfm.write_FIELD_INSTRUCTION_1_REG_scan_in_inst_1_data_1({5'b00001, 2'b11});
    bfm.write_FIELD_INSTRUCTION_1_REG_scan_in_inst_2_data_1({5'b00001, 2'b11});
    bfm.write_FIELD_INSTRUCTION_1_REG_scan_in_inst_3_data_1({5'b00001, 2'b11});
    bfm.write_FIELD_INSTRUCTION_1_REG_scan_in_inst_4_data_1({5'b00001, 2'b11});
    bfm.write_FIELD_INSTRUCTION_1_REG_scan_in_inst_5_data_1({5'b00001, 2'b11});
    bfm.write_FIELD_INSTRUCTION_1_REG_scan_in_inst_6_data_1({5'b00001, 2'b11});
    bfm.write_FIELD_INSTRUCTION_1_REG_scan_in_inst_7_data_1({5'b00001, 2'b11});
    bfm.write_FIELD_INSTRUCTION_1_REG_scan_in_inst_8_data_1({5'b00001, 2'b11});
    bfm.write_FIELD_INSTRUCTION_1_REG_scan_in_inst_9_data_1({5'b00001, 2'b11});
    bfm.write_FIELD_INSTRUCTION_1_REG_scan_in_inst_10_data_1({5'b00001, 2'b11});
    bfm.write_FIELD_INSTRUCTION_1_REG_scan_in_inst_11_data_1({5'b00001, 2'b11});
    bfm.write_FIELD_INSTRUCTION_1_REG_scan_in_inst_12_data_1({5'b00001, 2'b11});
    bfm.write_FIELD_INSTRUCTION_1_REG_scan_in_inst_13_data_1({5'b00001, 2'b11});
    bfm.write_FIELD_INSTRUCTION_1_REG_scan_in_inst_14_data_1({5'b00001, 2'b11});
    bfm.write_FIELD_INSTRUCTION_1_REG_scan_in_inst_15_data_1({5'b00001, 2'b11});
    bfm.write_FIELD_INSTRUCTION_1_REG_scan_in_inst_16_data_1({5'b00001, 2'b11});
    bfm.write_FIELD_INSTRUCTION_1_REG_scan_in_inst_17_data_1({5'b00001, 2'b11});
    bfm.write_FIELD_INSTRUCTION_1_REG_scan_in_inst_18_data_1({5'b00001, 2'b11});
    bfm.write_FIELD_INSTRUCTION_1_REG_scan_in_inst_19_data_1({5'b00001, 2'b11});
    bfm.write_FIELD_INSTRUCTION_1_REG_scan_in_inst_20_data_1({5'b00001, 2'b11});
    bfm.write_FIELD_INSTRUCTION_1_REG_scan_in_inst_21_data_1({5'b00001, 2'b11});
    bfm.write_FIELD_INSTRUCTION_1_REG_scan_in_inst_22_data_1({5'b00001, 2'b11});
    bfm.write_FIELD_INSTRUCTION_1_REG_scan_in_inst_23_data_1({5'b00001, 2'b11});
    bfm.write_FIELD_INSTRUCTION_1_REG_scan_in_inst_24_data_1({5'b00001, 2'b11});
    bfm.write_FIELD_INSTRUCTION_1_REG_scan_in_inst_25_data_1({5'b00001, 2'b11});
    bfm.write_FIELD_INSTRUCTION_1_REG_scan_in_inst_26_data_1({5'b00001, 2'b11});
    bfm.write_FIELD_INSTRUCTION_1_REG_scan_in_inst_27_data_1({5'b00001, 2'b11});
    bfm.write_FIELD_INSTRUCTION_1_REG_scan_in_inst_28_data_1({5'b00001, 2'b11});
    bfm.write_FIELD_INSTRUCTION_1_REG_scan_in_inst_29_data_1({5'b00001, 2'b11});
    bfm.write_FIELD_INSTRUCTION_1_REG_scan_in_inst_30_data_1({5'b00001, 2'b11});
    bfm.write_FIELD_INSTRUCTION_1_REG_scan_in_inst_31_data_1({5'b00001, 2'b11});
    
    bfm.write_FIELD_INSTRUCTION_1_REG_scan_in_inst_cmd_1(2'b01); // Scan in
    bfm.write_FIELD_INSTRUCTION_1_REG_scan_in_inst_req_1(1'b1);
    bfm.read_FIELD_INSTRUCTION_1_REG_scan_in_inst_ack_1(rdata);
    while (rdata != 1'b1) begin
        bfm.read_FIELD_INSTRUCTION_1_REG_scan_in_inst_ack_1(rdata); // Read advances time
    end
    $display("Instruction scan in complete.");
    bfm.read_FIELD_LOOPBACK_REG_loopback_so_data_1(rdata);
    $display("Loopback data: %028b", rdata);
    
    // Column 2 
    $display("Running loopback test chiplet column 2...");
    bfm.write_FIELD_INSTRUCTION_2_REG_scan_in_inst_0_data_2({5'b00011, 2'b11});
    bfm.write_FIELD_INSTRUCTION_2_REG_scan_in_inst_1_data_2({5'b00011, 2'b11});
    bfm.write_FIELD_INSTRUCTION_2_REG_scan_in_inst_2_data_2({5'b00011, 2'b11});
    bfm.write_FIELD_INSTRUCTION_2_REG_scan_in_inst_3_data_2({5'b00011, 2'b11});
    bfm.write_FIELD_INSTRUCTION_2_REG_scan_in_inst_4_data_2({5'b00011, 2'b11});
    bfm.write_FIELD_INSTRUCTION_2_REG_scan_in_inst_5_data_2({5'b00011, 2'b11});
    bfm.write_FIELD_INSTRUCTION_2_REG_scan_in_inst_6_data_2({5'b00011, 2'b11});
    bfm.write_FIELD_INSTRUCTION_2_REG_scan_in_inst_7_data_2({5'b00011, 2'b11});
    bfm.write_FIELD_INSTRUCTION_2_REG_scan_in_inst_8_data_2({5'b00011, 2'b11});
    bfm.write_FIELD_INSTRUCTION_2_REG_scan_in_inst_9_data_2({5'b00011, 2'b11});
    bfm.write_FIELD_INSTRUCTION_2_REG_scan_in_inst_10_data_2({5'b00011, 2'b11});
    bfm.write_FIELD_INSTRUCTION_2_REG_scan_in_inst_11_data_2({5'b00011, 2'b11});
    bfm.write_FIELD_INSTRUCTION_2_REG_scan_in_inst_12_data_2({5'b00011, 2'b11});
    bfm.write_FIELD_INSTRUCTION_2_REG_scan_in_inst_13_data_2({5'b00011, 2'b11});
    bfm.write_FIELD_INSTRUCTION_2_REG_scan_in_inst_14_data_2({5'b00011, 2'b11});
    bfm.write_FIELD_INSTRUCTION_2_REG_scan_in_inst_15_data_2({5'b00011, 2'b11});
    bfm.write_FIELD_INSTRUCTION_2_REG_scan_in_inst_16_data_2({5'b00011, 2'b11});
    bfm.write_FIELD_INSTRUCTION_2_REG_scan_in_inst_17_data_2({5'b00011, 2'b11});
    bfm.write_FIELD_INSTRUCTION_2_REG_scan_in_inst_18_data_2({5'b00011, 2'b11});
    bfm.write_FIELD_INSTRUCTION_2_REG_scan_in_inst_19_data_2({5'b00011, 2'b11});
    bfm.write_FIELD_INSTRUCTION_2_REG_scan_in_inst_20_data_2({5'b00011, 2'b11});
    bfm.write_FIELD_INSTRUCTION_2_REG_scan_in_inst_21_data_2({5'b00011, 2'b11});
    bfm.write_FIELD_INSTRUCTION_2_REG_scan_in_inst_22_data_2({5'b00011, 2'b11});
    bfm.write_FIELD_INSTRUCTION_2_REG_scan_in_inst_23_data_2({5'b00011, 2'b11});
    bfm.write_FIELD_INSTRUCTION_2_REG_scan_in_inst_24_data_2({5'b00011, 2'b11});
    bfm.write_FIELD_INSTRUCTION_2_REG_scan_in_inst_25_data_2({5'b00011, 2'b11});
    bfm.write_FIELD_INSTRUCTION_2_REG_scan_in_inst_26_data_2({5'b00011, 2'b11});
    bfm.write_FIELD_INSTRUCTION_2_REG_scan_in_inst_27_data_2({5'b00011, 2'b11});
    bfm.write_FIELD_INSTRUCTION_2_REG_scan_in_inst_28_data_2({5'b00011, 2'b11});
    bfm.write_FIELD_INSTRUCTION_2_REG_scan_in_inst_29_data_2({5'b00011, 2'b11});
    bfm.write_FIELD_INSTRUCTION_2_REG_scan_in_inst_30_data_2({5'b00011, 2'b11});
    bfm.write_FIELD_INSTRUCTION_2_REG_scan_in_inst_31_data_2({5'b00011, 2'b11});
    
    bfm.write_FIELD_INSTRUCTION_2_REG_scan_in_inst_cmd_2(2'b01); // Scan in
    bfm.write_FIELD_INSTRUCTION_2_REG_scan_in_inst_req_2(1'b1);
    bfm.read_FIELD_INSTRUCTION_2_REG_scan_in_inst_ack_2(rdata);
    while (rdata != 1'b1) begin
        bfm.read_FIELD_INSTRUCTION_2_REG_scan_in_inst_ack_2(rdata); // Read advances time
    end
    $display("Instruction scan in complete.");
    bfm.read_FIELD_LOOPBACK_REG_loopback_so_data_2(rdata);
    $display("Loopback data: %028b", rdata);
    
    // Column 3 
    $display("Running loopback test chiplet column 3...");
    bfm.write_FIELD_INSTRUCTION_3_REG_scan_in_inst_0_data_3({5'b00111, 2'b11});
    bfm.write_FIELD_INSTRUCTION_3_REG_scan_in_inst_1_data_3({5'b00111, 2'b11});
    bfm.write_FIELD_INSTRUCTION_3_REG_scan_in_inst_2_data_3({5'b00111, 2'b11});
    bfm.write_FIELD_INSTRUCTION_3_REG_scan_in_inst_3_data_3({5'b00111, 2'b11});
    bfm.write_FIELD_INSTRUCTION_3_REG_scan_in_inst_4_data_3({5'b00111, 2'b11});
    bfm.write_FIELD_INSTRUCTION_3_REG_scan_in_inst_5_data_3({5'b00111, 2'b11});
    bfm.write_FIELD_INSTRUCTION_3_REG_scan_in_inst_6_data_3({5'b00111, 2'b11});
    bfm.write_FIELD_INSTRUCTION_3_REG_scan_in_inst_7_data_3({5'b00111, 2'b11});
    bfm.write_FIELD_INSTRUCTION_3_REG_scan_in_inst_8_data_3({5'b00111, 2'b11});
    bfm.write_FIELD_INSTRUCTION_3_REG_scan_in_inst_9_data_3({5'b00111, 2'b11});
    bfm.write_FIELD_INSTRUCTION_3_REG_scan_in_inst_10_data_3({5'b00111, 2'b11});
    bfm.write_FIELD_INSTRUCTION_3_REG_scan_in_inst_11_data_3({5'b00111, 2'b11});
    bfm.write_FIELD_INSTRUCTION_3_REG_scan_in_inst_12_data_3({5'b00111, 2'b11});
    bfm.write_FIELD_INSTRUCTION_3_REG_scan_in_inst_13_data_3({5'b00111, 2'b11});
    bfm.write_FIELD_INSTRUCTION_3_REG_scan_in_inst_14_data_3({5'b00111, 2'b11});
    bfm.write_FIELD_INSTRUCTION_3_REG_scan_in_inst_15_data_3({5'b00111, 2'b11});
    bfm.write_FIELD_INSTRUCTION_3_REG_scan_in_inst_16_data_3({5'b00111, 2'b11});
    bfm.write_FIELD_INSTRUCTION_3_REG_scan_in_inst_17_data_3({5'b00111, 2'b11});
    bfm.write_FIELD_INSTRUCTION_3_REG_scan_in_inst_18_data_3({5'b00111, 2'b11});
    bfm.write_FIELD_INSTRUCTION_3_REG_scan_in_inst_19_data_3({5'b00111, 2'b11});
    bfm.write_FIELD_INSTRUCTION_3_REG_scan_in_inst_20_data_3({5'b00111, 2'b11});
    bfm.write_FIELD_INSTRUCTION_3_REG_scan_in_inst_21_data_3({5'b00111, 2'b11});
    bfm.write_FIELD_INSTRUCTION_3_REG_scan_in_inst_22_data_3({5'b00111, 2'b11});
    bfm.write_FIELD_INSTRUCTION_3_REG_scan_in_inst_23_data_3({5'b00111, 2'b11});
    bfm.write_FIELD_INSTRUCTION_3_REG_scan_in_inst_24_data_3({5'b00111, 2'b11});
    bfm.write_FIELD_INSTRUCTION_3_REG_scan_in_inst_25_data_3({5'b00111, 2'b11});
    bfm.write_FIELD_INSTRUCTION_3_REG_scan_in_inst_26_data_3({5'b00111, 2'b11});
    bfm.write_FIELD_INSTRUCTION_3_REG_scan_in_inst_27_data_3({5'b00111, 2'b11});
    bfm.write_FIELD_INSTRUCTION_3_REG_scan_in_inst_28_data_3({5'b00111, 2'b11});
    bfm.write_FIELD_INSTRUCTION_3_REG_scan_in_inst_29_data_3({5'b00111, 2'b11});
    bfm.write_FIELD_INSTRUCTION_3_REG_scan_in_inst_30_data_3({5'b00111, 2'b11});
    bfm.write_FIELD_INSTRUCTION_3_REG_scan_in_inst_31_data_3({5'b00111, 2'b11});
    
    bfm.write_FIELD_INSTRUCTION_3_REG_scan_in_inst_cmd_3(2'b01); // Scan in
    bfm.write_FIELD_INSTRUCTION_3_REG_scan_in_inst_req_3(1'b1);
    bfm.read_FIELD_INSTRUCTION_3_REG_scan_in_inst_ack_3(rdata);
    while (rdata != 1'b1) begin
        bfm.read_FIELD_INSTRUCTION_3_REG_scan_in_inst_ack_3(rdata); // Read advances time
    end
    $display("Instruction scan in complete.");
    bfm.read_FIELD_LOOPBACK_REG_loopback_so_data_3(rdata);
    $display("Loopback data: %028b", rdata);
    //-------------------------------------------------------------------------

    // Extra cycles
    #(1000*bfm.SysClockCycle);
    
    $display("###############");
    if (test) begin
        $display("# TEST PASSED #");
    end else begin
        $display("# TEST FAILED #");
    end
    $display("###############");
endtask
