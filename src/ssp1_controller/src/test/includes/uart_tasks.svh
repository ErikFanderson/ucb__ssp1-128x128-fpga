//------------------------------------------------------------------------------
// Basic read and write methods 
//------------------------------------------------------------------------------
//task write(input [7:0] address, input [7:0] data);
//    begin
//        // TODO Implement me - Write address byte (MSb = 0, lower bits are address)
//    end
//endtask
//
//task read(input [7:0] address, output [7:0] data);
//    begin
//        // TODO implement me - Write address byte (MSb = 1, lower bits are address)
//    end
//endtask
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Read all bytes task 
//------------------------------------------------------------------------------
task read_all_bytes(input [7:0] start_address, end_address, output [999:0] data);
    logic [7:0] read_byte;
    begin
        data = '0;
        for (i = 0; i <= (end_address - start_address); i = i + 1) begin
            read(start_address + i, read_byte);
            data[8*i +: 8] = read_byte;
        end
    end
endtask
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Field: RESET
//------------------------------------------------------------------------------
// Register: reset
task read_FIELD_RESET_REG_reset(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(0, 0, rdata);
        data = {{999{1'b0}}, rdata[0:0]};
    end
endtask
task write_FIELD_RESET_REG_reset(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(0, 0, rdata);
        wdata = rdata;
        wdata[0:0] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(0 + i, wdata[8*i +: 8]);
        end 
    end 
endtask
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Field: USER
//------------------------------------------------------------------------------
// Register: leds
task read_FIELD_USER_REG_leds(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(1, 1, rdata);
        data = {{992{1'b0}}, rdata[7:0]};
    end
endtask
task write_FIELD_USER_REG_leds(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(1, 1, rdata);
        wdata = rdata;
        wdata[7:0] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(1 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: shifter_oe_n
task read_FIELD_USER_REG_shifter_oe_n(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(2, 2, rdata);
        data = {{999{1'b0}}, rdata[0:0]};
    end
endtask
task write_FIELD_USER_REG_shifter_oe_n(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(2, 2, rdata);
        wdata = rdata;
        wdata[0:0] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(2 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_cg_en
task read_FIELD_USER_REG_scan_cg_en(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(2, 2, rdata);
        data = {{999{1'b0}}, rdata[1:1]};
    end
endtask
task write_FIELD_USER_REG_scan_cg_en(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(2, 2, rdata);
        wdata = rdata;
        wdata[1:1] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(2 + i, wdata[8*i +: 8]);
        end 
    end 
endtask
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Field: LOOPBACK
//------------------------------------------------------------------------------
// Register: loopback_so_data_0
task read_FIELD_LOOPBACK_REG_loopback_so_data_0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(3, 6, rdata);
        data = {{972{1'b0}}, rdata[27:0]};
    end
endtask

// Register: loopback_so_data_1
task read_FIELD_LOOPBACK_REG_loopback_so_data_1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(6, 9, rdata);
        data = {{972{1'b0}}, rdata[31:4]};
    end
endtask

// Register: loopback_so_data_2
task read_FIELD_LOOPBACK_REG_loopback_so_data_2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(10, 13, rdata);
        data = {{972{1'b0}}, rdata[27:0]};
    end
endtask

// Register: loopback_so_data_3
task read_FIELD_LOOPBACK_REG_loopback_so_data_3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(13, 16, rdata);
        data = {{972{1'b0}}, rdata[31:4]};
    end
endtask
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Field: ADDRESS_0
//------------------------------------------------------------------------------
// Register: scan_in_addr_address_0_r0
task read_FIELD_ADDRESS_0_REG_scan_in_addr_address_0_r0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(17, 17, rdata);
        data = {{998{1'b0}}, rdata[1:0]};
    end
endtask
task write_FIELD_ADDRESS_0_REG_scan_in_addr_address_0_r0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(17, 17, rdata);
        wdata = rdata;
        wdata[1:0] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(17 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_lb_sel_0_r0
task read_FIELD_ADDRESS_0_REG_scan_in_addr_lb_sel_0_r0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(17, 17, rdata);
        data = {{996{1'b0}}, rdata[5:2]};
    end
endtask
task write_FIELD_ADDRESS_0_REG_scan_in_addr_lb_sel_0_r0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(17, 17, rdata);
        wdata = rdata;
        wdata[5:2] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(17 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_enable_0_r0
task read_FIELD_ADDRESS_0_REG_scan_in_addr_enable_0_r0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(17, 17, rdata);
        data = {{999{1'b0}}, rdata[6:6]};
    end
endtask
task write_FIELD_ADDRESS_0_REG_scan_in_addr_enable_0_r0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(17, 17, rdata);
        wdata = rdata;
        wdata[6:6] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(17 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_address_0_r1
task read_FIELD_ADDRESS_0_REG_scan_in_addr_address_0_r1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(17, 18, rdata);
        data = {{998{1'b0}}, rdata[8:7]};
    end
endtask
task write_FIELD_ADDRESS_0_REG_scan_in_addr_address_0_r1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(17, 18, rdata);
        wdata = rdata;
        wdata[8:7] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(17 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_lb_sel_0_r1
task read_FIELD_ADDRESS_0_REG_scan_in_addr_lb_sel_0_r1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(18, 18, rdata);
        data = {{996{1'b0}}, rdata[4:1]};
    end
endtask
task write_FIELD_ADDRESS_0_REG_scan_in_addr_lb_sel_0_r1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(18, 18, rdata);
        wdata = rdata;
        wdata[4:1] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(18 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_enable_0_r1
task read_FIELD_ADDRESS_0_REG_scan_in_addr_enable_0_r1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(18, 18, rdata);
        data = {{999{1'b0}}, rdata[5:5]};
    end
endtask
task write_FIELD_ADDRESS_0_REG_scan_in_addr_enable_0_r1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(18, 18, rdata);
        wdata = rdata;
        wdata[5:5] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(18 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_address_0_r2
task read_FIELD_ADDRESS_0_REG_scan_in_addr_address_0_r2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(18, 18, rdata);
        data = {{998{1'b0}}, rdata[7:6]};
    end
endtask
task write_FIELD_ADDRESS_0_REG_scan_in_addr_address_0_r2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(18, 18, rdata);
        wdata = rdata;
        wdata[7:6] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(18 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_lb_sel_0_r2
task read_FIELD_ADDRESS_0_REG_scan_in_addr_lb_sel_0_r2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(19, 19, rdata);
        data = {{996{1'b0}}, rdata[3:0]};
    end
endtask
task write_FIELD_ADDRESS_0_REG_scan_in_addr_lb_sel_0_r2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(19, 19, rdata);
        wdata = rdata;
        wdata[3:0] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(19 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_enable_0_r2
task read_FIELD_ADDRESS_0_REG_scan_in_addr_enable_0_r2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(19, 19, rdata);
        data = {{999{1'b0}}, rdata[4:4]};
    end
endtask
task write_FIELD_ADDRESS_0_REG_scan_in_addr_enable_0_r2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(19, 19, rdata);
        wdata = rdata;
        wdata[4:4] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(19 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_address_0_r3
task read_FIELD_ADDRESS_0_REG_scan_in_addr_address_0_r3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(19, 19, rdata);
        data = {{998{1'b0}}, rdata[6:5]};
    end
endtask
task write_FIELD_ADDRESS_0_REG_scan_in_addr_address_0_r3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(19, 19, rdata);
        wdata = rdata;
        wdata[6:5] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(19 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_lb_sel_0_r3
task read_FIELD_ADDRESS_0_REG_scan_in_addr_lb_sel_0_r3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(19, 20, rdata);
        data = {{996{1'b0}}, rdata[10:7]};
    end
endtask
task write_FIELD_ADDRESS_0_REG_scan_in_addr_lb_sel_0_r3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(19, 20, rdata);
        wdata = rdata;
        wdata[10:7] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(19 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_enable_0_r3
task read_FIELD_ADDRESS_0_REG_scan_in_addr_enable_0_r3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(20, 20, rdata);
        data = {{999{1'b0}}, rdata[3:3]};
    end
endtask
task write_FIELD_ADDRESS_0_REG_scan_in_addr_enable_0_r3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(20, 20, rdata);
        wdata = rdata;
        wdata[3:3] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(20 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_req_0
task read_FIELD_ADDRESS_0_REG_scan_in_addr_req_0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(20, 20, rdata);
        data = {{999{1'b0}}, rdata[4:4]};
    end
endtask
task write_FIELD_ADDRESS_0_REG_scan_in_addr_req_0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(20, 20, rdata);
        wdata = rdata;
        wdata[4:4] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(20 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_cmd_0
task read_FIELD_ADDRESS_0_REG_scan_in_addr_cmd_0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(20, 20, rdata);
        data = {{998{1'b0}}, rdata[6:5]};
    end
endtask
task write_FIELD_ADDRESS_0_REG_scan_in_addr_cmd_0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(20, 20, rdata);
        wdata = rdata;
        wdata[6:5] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(20 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_ack_0
task read_FIELD_ADDRESS_0_REG_scan_in_addr_ack_0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(20, 20, rdata);
        data = {{999{1'b0}}, rdata[7:7]};
    end
endtask
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Field: ADDRESS_1
//------------------------------------------------------------------------------
// Register: scan_in_addr_address_1_r0
task read_FIELD_ADDRESS_1_REG_scan_in_addr_address_1_r0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(21, 21, rdata);
        data = {{998{1'b0}}, rdata[1:0]};
    end
endtask
task write_FIELD_ADDRESS_1_REG_scan_in_addr_address_1_r0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(21, 21, rdata);
        wdata = rdata;
        wdata[1:0] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(21 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_lb_sel_1_r0
task read_FIELD_ADDRESS_1_REG_scan_in_addr_lb_sel_1_r0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(21, 21, rdata);
        data = {{996{1'b0}}, rdata[5:2]};
    end
endtask
task write_FIELD_ADDRESS_1_REG_scan_in_addr_lb_sel_1_r0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(21, 21, rdata);
        wdata = rdata;
        wdata[5:2] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(21 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_enable_1_r0
task read_FIELD_ADDRESS_1_REG_scan_in_addr_enable_1_r0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(21, 21, rdata);
        data = {{999{1'b0}}, rdata[6:6]};
    end
endtask
task write_FIELD_ADDRESS_1_REG_scan_in_addr_enable_1_r0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(21, 21, rdata);
        wdata = rdata;
        wdata[6:6] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(21 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_address_1_r1
task read_FIELD_ADDRESS_1_REG_scan_in_addr_address_1_r1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(21, 22, rdata);
        data = {{998{1'b0}}, rdata[8:7]};
    end
endtask
task write_FIELD_ADDRESS_1_REG_scan_in_addr_address_1_r1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(21, 22, rdata);
        wdata = rdata;
        wdata[8:7] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(21 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_lb_sel_1_r1
task read_FIELD_ADDRESS_1_REG_scan_in_addr_lb_sel_1_r1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(22, 22, rdata);
        data = {{996{1'b0}}, rdata[4:1]};
    end
endtask
task write_FIELD_ADDRESS_1_REG_scan_in_addr_lb_sel_1_r1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(22, 22, rdata);
        wdata = rdata;
        wdata[4:1] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(22 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_enable_1_r1
task read_FIELD_ADDRESS_1_REG_scan_in_addr_enable_1_r1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(22, 22, rdata);
        data = {{999{1'b0}}, rdata[5:5]};
    end
endtask
task write_FIELD_ADDRESS_1_REG_scan_in_addr_enable_1_r1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(22, 22, rdata);
        wdata = rdata;
        wdata[5:5] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(22 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_address_1_r2
task read_FIELD_ADDRESS_1_REG_scan_in_addr_address_1_r2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(22, 22, rdata);
        data = {{998{1'b0}}, rdata[7:6]};
    end
endtask
task write_FIELD_ADDRESS_1_REG_scan_in_addr_address_1_r2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(22, 22, rdata);
        wdata = rdata;
        wdata[7:6] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(22 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_lb_sel_1_r2
task read_FIELD_ADDRESS_1_REG_scan_in_addr_lb_sel_1_r2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(23, 23, rdata);
        data = {{996{1'b0}}, rdata[3:0]};
    end
endtask
task write_FIELD_ADDRESS_1_REG_scan_in_addr_lb_sel_1_r2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(23, 23, rdata);
        wdata = rdata;
        wdata[3:0] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(23 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_enable_1_r2
task read_FIELD_ADDRESS_1_REG_scan_in_addr_enable_1_r2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(23, 23, rdata);
        data = {{999{1'b0}}, rdata[4:4]};
    end
endtask
task write_FIELD_ADDRESS_1_REG_scan_in_addr_enable_1_r2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(23, 23, rdata);
        wdata = rdata;
        wdata[4:4] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(23 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_address_1_r3
task read_FIELD_ADDRESS_1_REG_scan_in_addr_address_1_r3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(23, 23, rdata);
        data = {{998{1'b0}}, rdata[6:5]};
    end
endtask
task write_FIELD_ADDRESS_1_REG_scan_in_addr_address_1_r3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(23, 23, rdata);
        wdata = rdata;
        wdata[6:5] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(23 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_lb_sel_1_r3
task read_FIELD_ADDRESS_1_REG_scan_in_addr_lb_sel_1_r3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(23, 24, rdata);
        data = {{996{1'b0}}, rdata[10:7]};
    end
endtask
task write_FIELD_ADDRESS_1_REG_scan_in_addr_lb_sel_1_r3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(23, 24, rdata);
        wdata = rdata;
        wdata[10:7] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(23 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_enable_1_r3
task read_FIELD_ADDRESS_1_REG_scan_in_addr_enable_1_r3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(24, 24, rdata);
        data = {{999{1'b0}}, rdata[3:3]};
    end
endtask
task write_FIELD_ADDRESS_1_REG_scan_in_addr_enable_1_r3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(24, 24, rdata);
        wdata = rdata;
        wdata[3:3] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(24 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_req_1
task read_FIELD_ADDRESS_1_REG_scan_in_addr_req_1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(24, 24, rdata);
        data = {{999{1'b0}}, rdata[4:4]};
    end
endtask
task write_FIELD_ADDRESS_1_REG_scan_in_addr_req_1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(24, 24, rdata);
        wdata = rdata;
        wdata[4:4] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(24 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_cmd_1
task read_FIELD_ADDRESS_1_REG_scan_in_addr_cmd_1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(24, 24, rdata);
        data = {{998{1'b0}}, rdata[6:5]};
    end
endtask
task write_FIELD_ADDRESS_1_REG_scan_in_addr_cmd_1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(24, 24, rdata);
        wdata = rdata;
        wdata[6:5] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(24 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_ack_1
task read_FIELD_ADDRESS_1_REG_scan_in_addr_ack_1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(24, 24, rdata);
        data = {{999{1'b0}}, rdata[7:7]};
    end
endtask
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Field: ADDRESS_2
//------------------------------------------------------------------------------
// Register: scan_in_addr_address_2_r0
task read_FIELD_ADDRESS_2_REG_scan_in_addr_address_2_r0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(25, 25, rdata);
        data = {{998{1'b0}}, rdata[1:0]};
    end
endtask
task write_FIELD_ADDRESS_2_REG_scan_in_addr_address_2_r0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(25, 25, rdata);
        wdata = rdata;
        wdata[1:0] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(25 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_lb_sel_2_r0
task read_FIELD_ADDRESS_2_REG_scan_in_addr_lb_sel_2_r0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(25, 25, rdata);
        data = {{996{1'b0}}, rdata[5:2]};
    end
endtask
task write_FIELD_ADDRESS_2_REG_scan_in_addr_lb_sel_2_r0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(25, 25, rdata);
        wdata = rdata;
        wdata[5:2] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(25 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_enable_2_r0
task read_FIELD_ADDRESS_2_REG_scan_in_addr_enable_2_r0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(25, 25, rdata);
        data = {{999{1'b0}}, rdata[6:6]};
    end
endtask
task write_FIELD_ADDRESS_2_REG_scan_in_addr_enable_2_r0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(25, 25, rdata);
        wdata = rdata;
        wdata[6:6] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(25 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_address_2_r1
task read_FIELD_ADDRESS_2_REG_scan_in_addr_address_2_r1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(25, 26, rdata);
        data = {{998{1'b0}}, rdata[8:7]};
    end
endtask
task write_FIELD_ADDRESS_2_REG_scan_in_addr_address_2_r1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(25, 26, rdata);
        wdata = rdata;
        wdata[8:7] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(25 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_lb_sel_2_r1
task read_FIELD_ADDRESS_2_REG_scan_in_addr_lb_sel_2_r1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(26, 26, rdata);
        data = {{996{1'b0}}, rdata[4:1]};
    end
endtask
task write_FIELD_ADDRESS_2_REG_scan_in_addr_lb_sel_2_r1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(26, 26, rdata);
        wdata = rdata;
        wdata[4:1] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(26 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_enable_2_r1
task read_FIELD_ADDRESS_2_REG_scan_in_addr_enable_2_r1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(26, 26, rdata);
        data = {{999{1'b0}}, rdata[5:5]};
    end
endtask
task write_FIELD_ADDRESS_2_REG_scan_in_addr_enable_2_r1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(26, 26, rdata);
        wdata = rdata;
        wdata[5:5] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(26 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_address_2_r2
task read_FIELD_ADDRESS_2_REG_scan_in_addr_address_2_r2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(26, 26, rdata);
        data = {{998{1'b0}}, rdata[7:6]};
    end
endtask
task write_FIELD_ADDRESS_2_REG_scan_in_addr_address_2_r2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(26, 26, rdata);
        wdata = rdata;
        wdata[7:6] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(26 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_lb_sel_2_r2
task read_FIELD_ADDRESS_2_REG_scan_in_addr_lb_sel_2_r2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(27, 27, rdata);
        data = {{996{1'b0}}, rdata[3:0]};
    end
endtask
task write_FIELD_ADDRESS_2_REG_scan_in_addr_lb_sel_2_r2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(27, 27, rdata);
        wdata = rdata;
        wdata[3:0] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(27 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_enable_2_r2
task read_FIELD_ADDRESS_2_REG_scan_in_addr_enable_2_r2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(27, 27, rdata);
        data = {{999{1'b0}}, rdata[4:4]};
    end
endtask
task write_FIELD_ADDRESS_2_REG_scan_in_addr_enable_2_r2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(27, 27, rdata);
        wdata = rdata;
        wdata[4:4] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(27 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_address_2_r3
task read_FIELD_ADDRESS_2_REG_scan_in_addr_address_2_r3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(27, 27, rdata);
        data = {{998{1'b0}}, rdata[6:5]};
    end
endtask
task write_FIELD_ADDRESS_2_REG_scan_in_addr_address_2_r3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(27, 27, rdata);
        wdata = rdata;
        wdata[6:5] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(27 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_lb_sel_2_r3
task read_FIELD_ADDRESS_2_REG_scan_in_addr_lb_sel_2_r3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(27, 28, rdata);
        data = {{996{1'b0}}, rdata[10:7]};
    end
endtask
task write_FIELD_ADDRESS_2_REG_scan_in_addr_lb_sel_2_r3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(27, 28, rdata);
        wdata = rdata;
        wdata[10:7] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(27 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_enable_2_r3
task read_FIELD_ADDRESS_2_REG_scan_in_addr_enable_2_r3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(28, 28, rdata);
        data = {{999{1'b0}}, rdata[3:3]};
    end
endtask
task write_FIELD_ADDRESS_2_REG_scan_in_addr_enable_2_r3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(28, 28, rdata);
        wdata = rdata;
        wdata[3:3] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(28 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_req_2
task read_FIELD_ADDRESS_2_REG_scan_in_addr_req_2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(28, 28, rdata);
        data = {{999{1'b0}}, rdata[4:4]};
    end
endtask
task write_FIELD_ADDRESS_2_REG_scan_in_addr_req_2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(28, 28, rdata);
        wdata = rdata;
        wdata[4:4] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(28 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_cmd_2
task read_FIELD_ADDRESS_2_REG_scan_in_addr_cmd_2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(28, 28, rdata);
        data = {{998{1'b0}}, rdata[6:5]};
    end
endtask
task write_FIELD_ADDRESS_2_REG_scan_in_addr_cmd_2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(28, 28, rdata);
        wdata = rdata;
        wdata[6:5] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(28 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_ack_2
task read_FIELD_ADDRESS_2_REG_scan_in_addr_ack_2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(28, 28, rdata);
        data = {{999{1'b0}}, rdata[7:7]};
    end
endtask
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Field: ADDRESS_3
//------------------------------------------------------------------------------
// Register: scan_in_addr_address_3_r0
task read_FIELD_ADDRESS_3_REG_scan_in_addr_address_3_r0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(29, 29, rdata);
        data = {{998{1'b0}}, rdata[1:0]};
    end
endtask
task write_FIELD_ADDRESS_3_REG_scan_in_addr_address_3_r0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(29, 29, rdata);
        wdata = rdata;
        wdata[1:0] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(29 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_lb_sel_3_r0
task read_FIELD_ADDRESS_3_REG_scan_in_addr_lb_sel_3_r0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(29, 29, rdata);
        data = {{996{1'b0}}, rdata[5:2]};
    end
endtask
task write_FIELD_ADDRESS_3_REG_scan_in_addr_lb_sel_3_r0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(29, 29, rdata);
        wdata = rdata;
        wdata[5:2] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(29 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_enable_3_r0
task read_FIELD_ADDRESS_3_REG_scan_in_addr_enable_3_r0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(29, 29, rdata);
        data = {{999{1'b0}}, rdata[6:6]};
    end
endtask
task write_FIELD_ADDRESS_3_REG_scan_in_addr_enable_3_r0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(29, 29, rdata);
        wdata = rdata;
        wdata[6:6] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(29 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_address_3_r1
task read_FIELD_ADDRESS_3_REG_scan_in_addr_address_3_r1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(29, 30, rdata);
        data = {{998{1'b0}}, rdata[8:7]};
    end
endtask
task write_FIELD_ADDRESS_3_REG_scan_in_addr_address_3_r1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(29, 30, rdata);
        wdata = rdata;
        wdata[8:7] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(29 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_lb_sel_3_r1
task read_FIELD_ADDRESS_3_REG_scan_in_addr_lb_sel_3_r1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(30, 30, rdata);
        data = {{996{1'b0}}, rdata[4:1]};
    end
endtask
task write_FIELD_ADDRESS_3_REG_scan_in_addr_lb_sel_3_r1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(30, 30, rdata);
        wdata = rdata;
        wdata[4:1] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(30 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_enable_3_r1
task read_FIELD_ADDRESS_3_REG_scan_in_addr_enable_3_r1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(30, 30, rdata);
        data = {{999{1'b0}}, rdata[5:5]};
    end
endtask
task write_FIELD_ADDRESS_3_REG_scan_in_addr_enable_3_r1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(30, 30, rdata);
        wdata = rdata;
        wdata[5:5] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(30 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_address_3_r2
task read_FIELD_ADDRESS_3_REG_scan_in_addr_address_3_r2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(30, 30, rdata);
        data = {{998{1'b0}}, rdata[7:6]};
    end
endtask
task write_FIELD_ADDRESS_3_REG_scan_in_addr_address_3_r2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(30, 30, rdata);
        wdata = rdata;
        wdata[7:6] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(30 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_lb_sel_3_r2
task read_FIELD_ADDRESS_3_REG_scan_in_addr_lb_sel_3_r2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(31, 31, rdata);
        data = {{996{1'b0}}, rdata[3:0]};
    end
endtask
task write_FIELD_ADDRESS_3_REG_scan_in_addr_lb_sel_3_r2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(31, 31, rdata);
        wdata = rdata;
        wdata[3:0] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(31 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_enable_3_r2
task read_FIELD_ADDRESS_3_REG_scan_in_addr_enable_3_r2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(31, 31, rdata);
        data = {{999{1'b0}}, rdata[4:4]};
    end
endtask
task write_FIELD_ADDRESS_3_REG_scan_in_addr_enable_3_r2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(31, 31, rdata);
        wdata = rdata;
        wdata[4:4] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(31 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_address_3_r3
task read_FIELD_ADDRESS_3_REG_scan_in_addr_address_3_r3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(31, 31, rdata);
        data = {{998{1'b0}}, rdata[6:5]};
    end
endtask
task write_FIELD_ADDRESS_3_REG_scan_in_addr_address_3_r3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(31, 31, rdata);
        wdata = rdata;
        wdata[6:5] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(31 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_lb_sel_3_r3
task read_FIELD_ADDRESS_3_REG_scan_in_addr_lb_sel_3_r3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(31, 32, rdata);
        data = {{996{1'b0}}, rdata[10:7]};
    end
endtask
task write_FIELD_ADDRESS_3_REG_scan_in_addr_lb_sel_3_r3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(31, 32, rdata);
        wdata = rdata;
        wdata[10:7] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(31 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_enable_3_r3
task read_FIELD_ADDRESS_3_REG_scan_in_addr_enable_3_r3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(32, 32, rdata);
        data = {{999{1'b0}}, rdata[3:3]};
    end
endtask
task write_FIELD_ADDRESS_3_REG_scan_in_addr_enable_3_r3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(32, 32, rdata);
        wdata = rdata;
        wdata[3:3] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(32 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_req_3
task read_FIELD_ADDRESS_3_REG_scan_in_addr_req_3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(32, 32, rdata);
        data = {{999{1'b0}}, rdata[4:4]};
    end
endtask
task write_FIELD_ADDRESS_3_REG_scan_in_addr_req_3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(32, 32, rdata);
        wdata = rdata;
        wdata[4:4] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(32 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_cmd_3
task read_FIELD_ADDRESS_3_REG_scan_in_addr_cmd_3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(32, 32, rdata);
        data = {{998{1'b0}}, rdata[6:5]};
    end
endtask
task write_FIELD_ADDRESS_3_REG_scan_in_addr_cmd_3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(32, 32, rdata);
        wdata = rdata;
        wdata[6:5] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(32 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_addr_ack_3
task read_FIELD_ADDRESS_3_REG_scan_in_addr_ack_3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(32, 32, rdata);
        data = {{999{1'b0}}, rdata[7:7]};
    end
endtask
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Field: INSTRUCTION_0
//------------------------------------------------------------------------------
// Register: scan_in_inst_0_data_0
task read_FIELD_INSTRUCTION_0_REG_scan_in_inst_0_data_0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(33, 33, rdata);
        data = {{993{1'b0}}, rdata[6:0]};
    end
endtask
task write_FIELD_INSTRUCTION_0_REG_scan_in_inst_0_data_0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(33, 33, rdata);
        wdata = rdata;
        wdata[6:0] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(33 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_1_data_0
task read_FIELD_INSTRUCTION_0_REG_scan_in_inst_1_data_0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(33, 34, rdata);
        data = {{993{1'b0}}, rdata[13:7]};
    end
endtask
task write_FIELD_INSTRUCTION_0_REG_scan_in_inst_1_data_0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(33, 34, rdata);
        wdata = rdata;
        wdata[13:7] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(33 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_2_data_0
task read_FIELD_INSTRUCTION_0_REG_scan_in_inst_2_data_0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(34, 35, rdata);
        data = {{993{1'b0}}, rdata[12:6]};
    end
endtask
task write_FIELD_INSTRUCTION_0_REG_scan_in_inst_2_data_0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(34, 35, rdata);
        wdata = rdata;
        wdata[12:6] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(34 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_3_data_0
task read_FIELD_INSTRUCTION_0_REG_scan_in_inst_3_data_0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(35, 36, rdata);
        data = {{993{1'b0}}, rdata[11:5]};
    end
endtask
task write_FIELD_INSTRUCTION_0_REG_scan_in_inst_3_data_0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(35, 36, rdata);
        wdata = rdata;
        wdata[11:5] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(35 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_4_data_0
task read_FIELD_INSTRUCTION_0_REG_scan_in_inst_4_data_0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(36, 37, rdata);
        data = {{993{1'b0}}, rdata[10:4]};
    end
endtask
task write_FIELD_INSTRUCTION_0_REG_scan_in_inst_4_data_0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(36, 37, rdata);
        wdata = rdata;
        wdata[10:4] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(36 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_5_data_0
task read_FIELD_INSTRUCTION_0_REG_scan_in_inst_5_data_0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(37, 38, rdata);
        data = {{993{1'b0}}, rdata[9:3]};
    end
endtask
task write_FIELD_INSTRUCTION_0_REG_scan_in_inst_5_data_0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(37, 38, rdata);
        wdata = rdata;
        wdata[9:3] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(37 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_6_data_0
task read_FIELD_INSTRUCTION_0_REG_scan_in_inst_6_data_0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(38, 39, rdata);
        data = {{993{1'b0}}, rdata[8:2]};
    end
endtask
task write_FIELD_INSTRUCTION_0_REG_scan_in_inst_6_data_0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(38, 39, rdata);
        wdata = rdata;
        wdata[8:2] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(38 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_7_data_0
task read_FIELD_INSTRUCTION_0_REG_scan_in_inst_7_data_0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(39, 39, rdata);
        data = {{993{1'b0}}, rdata[7:1]};
    end
endtask
task write_FIELD_INSTRUCTION_0_REG_scan_in_inst_7_data_0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(39, 39, rdata);
        wdata = rdata;
        wdata[7:1] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(39 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_8_data_0
task read_FIELD_INSTRUCTION_0_REG_scan_in_inst_8_data_0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(40, 40, rdata);
        data = {{993{1'b0}}, rdata[6:0]};
    end
endtask
task write_FIELD_INSTRUCTION_0_REG_scan_in_inst_8_data_0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(40, 40, rdata);
        wdata = rdata;
        wdata[6:0] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(40 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_9_data_0
task read_FIELD_INSTRUCTION_0_REG_scan_in_inst_9_data_0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(40, 41, rdata);
        data = {{993{1'b0}}, rdata[13:7]};
    end
endtask
task write_FIELD_INSTRUCTION_0_REG_scan_in_inst_9_data_0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(40, 41, rdata);
        wdata = rdata;
        wdata[13:7] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(40 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_10_data_0
task read_FIELD_INSTRUCTION_0_REG_scan_in_inst_10_data_0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(41, 42, rdata);
        data = {{993{1'b0}}, rdata[12:6]};
    end
endtask
task write_FIELD_INSTRUCTION_0_REG_scan_in_inst_10_data_0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(41, 42, rdata);
        wdata = rdata;
        wdata[12:6] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(41 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_11_data_0
task read_FIELD_INSTRUCTION_0_REG_scan_in_inst_11_data_0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(42, 43, rdata);
        data = {{993{1'b0}}, rdata[11:5]};
    end
endtask
task write_FIELD_INSTRUCTION_0_REG_scan_in_inst_11_data_0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(42, 43, rdata);
        wdata = rdata;
        wdata[11:5] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(42 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_12_data_0
task read_FIELD_INSTRUCTION_0_REG_scan_in_inst_12_data_0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(43, 44, rdata);
        data = {{993{1'b0}}, rdata[10:4]};
    end
endtask
task write_FIELD_INSTRUCTION_0_REG_scan_in_inst_12_data_0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(43, 44, rdata);
        wdata = rdata;
        wdata[10:4] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(43 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_13_data_0
task read_FIELD_INSTRUCTION_0_REG_scan_in_inst_13_data_0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(44, 45, rdata);
        data = {{993{1'b0}}, rdata[9:3]};
    end
endtask
task write_FIELD_INSTRUCTION_0_REG_scan_in_inst_13_data_0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(44, 45, rdata);
        wdata = rdata;
        wdata[9:3] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(44 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_14_data_0
task read_FIELD_INSTRUCTION_0_REG_scan_in_inst_14_data_0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(45, 46, rdata);
        data = {{993{1'b0}}, rdata[8:2]};
    end
endtask
task write_FIELD_INSTRUCTION_0_REG_scan_in_inst_14_data_0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(45, 46, rdata);
        wdata = rdata;
        wdata[8:2] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(45 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_15_data_0
task read_FIELD_INSTRUCTION_0_REG_scan_in_inst_15_data_0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(46, 46, rdata);
        data = {{993{1'b0}}, rdata[7:1]};
    end
endtask
task write_FIELD_INSTRUCTION_0_REG_scan_in_inst_15_data_0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(46, 46, rdata);
        wdata = rdata;
        wdata[7:1] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(46 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_16_data_0
task read_FIELD_INSTRUCTION_0_REG_scan_in_inst_16_data_0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(47, 47, rdata);
        data = {{993{1'b0}}, rdata[6:0]};
    end
endtask
task write_FIELD_INSTRUCTION_0_REG_scan_in_inst_16_data_0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(47, 47, rdata);
        wdata = rdata;
        wdata[6:0] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(47 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_17_data_0
task read_FIELD_INSTRUCTION_0_REG_scan_in_inst_17_data_0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(47, 48, rdata);
        data = {{993{1'b0}}, rdata[13:7]};
    end
endtask
task write_FIELD_INSTRUCTION_0_REG_scan_in_inst_17_data_0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(47, 48, rdata);
        wdata = rdata;
        wdata[13:7] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(47 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_18_data_0
task read_FIELD_INSTRUCTION_0_REG_scan_in_inst_18_data_0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(48, 49, rdata);
        data = {{993{1'b0}}, rdata[12:6]};
    end
endtask
task write_FIELD_INSTRUCTION_0_REG_scan_in_inst_18_data_0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(48, 49, rdata);
        wdata = rdata;
        wdata[12:6] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(48 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_19_data_0
task read_FIELD_INSTRUCTION_0_REG_scan_in_inst_19_data_0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(49, 50, rdata);
        data = {{993{1'b0}}, rdata[11:5]};
    end
endtask
task write_FIELD_INSTRUCTION_0_REG_scan_in_inst_19_data_0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(49, 50, rdata);
        wdata = rdata;
        wdata[11:5] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(49 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_20_data_0
task read_FIELD_INSTRUCTION_0_REG_scan_in_inst_20_data_0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(50, 51, rdata);
        data = {{993{1'b0}}, rdata[10:4]};
    end
endtask
task write_FIELD_INSTRUCTION_0_REG_scan_in_inst_20_data_0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(50, 51, rdata);
        wdata = rdata;
        wdata[10:4] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(50 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_21_data_0
task read_FIELD_INSTRUCTION_0_REG_scan_in_inst_21_data_0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(51, 52, rdata);
        data = {{993{1'b0}}, rdata[9:3]};
    end
endtask
task write_FIELD_INSTRUCTION_0_REG_scan_in_inst_21_data_0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(51, 52, rdata);
        wdata = rdata;
        wdata[9:3] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(51 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_22_data_0
task read_FIELD_INSTRUCTION_0_REG_scan_in_inst_22_data_0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(52, 53, rdata);
        data = {{993{1'b0}}, rdata[8:2]};
    end
endtask
task write_FIELD_INSTRUCTION_0_REG_scan_in_inst_22_data_0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(52, 53, rdata);
        wdata = rdata;
        wdata[8:2] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(52 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_23_data_0
task read_FIELD_INSTRUCTION_0_REG_scan_in_inst_23_data_0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(53, 53, rdata);
        data = {{993{1'b0}}, rdata[7:1]};
    end
endtask
task write_FIELD_INSTRUCTION_0_REG_scan_in_inst_23_data_0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(53, 53, rdata);
        wdata = rdata;
        wdata[7:1] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(53 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_24_data_0
task read_FIELD_INSTRUCTION_0_REG_scan_in_inst_24_data_0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(54, 54, rdata);
        data = {{993{1'b0}}, rdata[6:0]};
    end
endtask
task write_FIELD_INSTRUCTION_0_REG_scan_in_inst_24_data_0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(54, 54, rdata);
        wdata = rdata;
        wdata[6:0] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(54 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_25_data_0
task read_FIELD_INSTRUCTION_0_REG_scan_in_inst_25_data_0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(54, 55, rdata);
        data = {{993{1'b0}}, rdata[13:7]};
    end
endtask
task write_FIELD_INSTRUCTION_0_REG_scan_in_inst_25_data_0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(54, 55, rdata);
        wdata = rdata;
        wdata[13:7] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(54 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_26_data_0
task read_FIELD_INSTRUCTION_0_REG_scan_in_inst_26_data_0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(55, 56, rdata);
        data = {{993{1'b0}}, rdata[12:6]};
    end
endtask
task write_FIELD_INSTRUCTION_0_REG_scan_in_inst_26_data_0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(55, 56, rdata);
        wdata = rdata;
        wdata[12:6] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(55 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_27_data_0
task read_FIELD_INSTRUCTION_0_REG_scan_in_inst_27_data_0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(56, 57, rdata);
        data = {{993{1'b0}}, rdata[11:5]};
    end
endtask
task write_FIELD_INSTRUCTION_0_REG_scan_in_inst_27_data_0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(56, 57, rdata);
        wdata = rdata;
        wdata[11:5] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(56 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_28_data_0
task read_FIELD_INSTRUCTION_0_REG_scan_in_inst_28_data_0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(57, 58, rdata);
        data = {{993{1'b0}}, rdata[10:4]};
    end
endtask
task write_FIELD_INSTRUCTION_0_REG_scan_in_inst_28_data_0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(57, 58, rdata);
        wdata = rdata;
        wdata[10:4] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(57 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_29_data_0
task read_FIELD_INSTRUCTION_0_REG_scan_in_inst_29_data_0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(58, 59, rdata);
        data = {{993{1'b0}}, rdata[9:3]};
    end
endtask
task write_FIELD_INSTRUCTION_0_REG_scan_in_inst_29_data_0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(58, 59, rdata);
        wdata = rdata;
        wdata[9:3] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(58 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_30_data_0
task read_FIELD_INSTRUCTION_0_REG_scan_in_inst_30_data_0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(59, 60, rdata);
        data = {{993{1'b0}}, rdata[8:2]};
    end
endtask
task write_FIELD_INSTRUCTION_0_REG_scan_in_inst_30_data_0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(59, 60, rdata);
        wdata = rdata;
        wdata[8:2] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(59 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_31_data_0
task read_FIELD_INSTRUCTION_0_REG_scan_in_inst_31_data_0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(60, 60, rdata);
        data = {{993{1'b0}}, rdata[7:1]};
    end
endtask
task write_FIELD_INSTRUCTION_0_REG_scan_in_inst_31_data_0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(60, 60, rdata);
        wdata = rdata;
        wdata[7:1] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(60 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_req_0
task read_FIELD_INSTRUCTION_0_REG_scan_in_inst_req_0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(61, 61, rdata);
        data = {{999{1'b0}}, rdata[0:0]};
    end
endtask
task write_FIELD_INSTRUCTION_0_REG_scan_in_inst_req_0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(61, 61, rdata);
        wdata = rdata;
        wdata[0:0] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(61 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_cmd_0
task read_FIELD_INSTRUCTION_0_REG_scan_in_inst_cmd_0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(61, 61, rdata);
        data = {{998{1'b0}}, rdata[2:1]};
    end
endtask
task write_FIELD_INSTRUCTION_0_REG_scan_in_inst_cmd_0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(61, 61, rdata);
        wdata = rdata;
        wdata[2:1] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(61 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_ack_0
task read_FIELD_INSTRUCTION_0_REG_scan_in_inst_ack_0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(61, 61, rdata);
        data = {{999{1'b0}}, rdata[3:3]};
    end
endtask
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Field: INSTRUCTION_1
//------------------------------------------------------------------------------
// Register: scan_in_inst_0_data_1
task read_FIELD_INSTRUCTION_1_REG_scan_in_inst_0_data_1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(62, 62, rdata);
        data = {{993{1'b0}}, rdata[6:0]};
    end
endtask
task write_FIELD_INSTRUCTION_1_REG_scan_in_inst_0_data_1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(62, 62, rdata);
        wdata = rdata;
        wdata[6:0] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(62 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_1_data_1
task read_FIELD_INSTRUCTION_1_REG_scan_in_inst_1_data_1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(62, 63, rdata);
        data = {{993{1'b0}}, rdata[13:7]};
    end
endtask
task write_FIELD_INSTRUCTION_1_REG_scan_in_inst_1_data_1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(62, 63, rdata);
        wdata = rdata;
        wdata[13:7] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(62 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_2_data_1
task read_FIELD_INSTRUCTION_1_REG_scan_in_inst_2_data_1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(63, 64, rdata);
        data = {{993{1'b0}}, rdata[12:6]};
    end
endtask
task write_FIELD_INSTRUCTION_1_REG_scan_in_inst_2_data_1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(63, 64, rdata);
        wdata = rdata;
        wdata[12:6] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(63 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_3_data_1
task read_FIELD_INSTRUCTION_1_REG_scan_in_inst_3_data_1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(64, 65, rdata);
        data = {{993{1'b0}}, rdata[11:5]};
    end
endtask
task write_FIELD_INSTRUCTION_1_REG_scan_in_inst_3_data_1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(64, 65, rdata);
        wdata = rdata;
        wdata[11:5] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(64 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_4_data_1
task read_FIELD_INSTRUCTION_1_REG_scan_in_inst_4_data_1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(65, 66, rdata);
        data = {{993{1'b0}}, rdata[10:4]};
    end
endtask
task write_FIELD_INSTRUCTION_1_REG_scan_in_inst_4_data_1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(65, 66, rdata);
        wdata = rdata;
        wdata[10:4] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(65 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_5_data_1
task read_FIELD_INSTRUCTION_1_REG_scan_in_inst_5_data_1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(66, 67, rdata);
        data = {{993{1'b0}}, rdata[9:3]};
    end
endtask
task write_FIELD_INSTRUCTION_1_REG_scan_in_inst_5_data_1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(66, 67, rdata);
        wdata = rdata;
        wdata[9:3] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(66 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_6_data_1
task read_FIELD_INSTRUCTION_1_REG_scan_in_inst_6_data_1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(67, 68, rdata);
        data = {{993{1'b0}}, rdata[8:2]};
    end
endtask
task write_FIELD_INSTRUCTION_1_REG_scan_in_inst_6_data_1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(67, 68, rdata);
        wdata = rdata;
        wdata[8:2] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(67 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_7_data_1
task read_FIELD_INSTRUCTION_1_REG_scan_in_inst_7_data_1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(68, 68, rdata);
        data = {{993{1'b0}}, rdata[7:1]};
    end
endtask
task write_FIELD_INSTRUCTION_1_REG_scan_in_inst_7_data_1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(68, 68, rdata);
        wdata = rdata;
        wdata[7:1] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(68 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_8_data_1
task read_FIELD_INSTRUCTION_1_REG_scan_in_inst_8_data_1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(69, 69, rdata);
        data = {{993{1'b0}}, rdata[6:0]};
    end
endtask
task write_FIELD_INSTRUCTION_1_REG_scan_in_inst_8_data_1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(69, 69, rdata);
        wdata = rdata;
        wdata[6:0] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(69 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_9_data_1
task read_FIELD_INSTRUCTION_1_REG_scan_in_inst_9_data_1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(69, 70, rdata);
        data = {{993{1'b0}}, rdata[13:7]};
    end
endtask
task write_FIELD_INSTRUCTION_1_REG_scan_in_inst_9_data_1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(69, 70, rdata);
        wdata = rdata;
        wdata[13:7] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(69 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_10_data_1
task read_FIELD_INSTRUCTION_1_REG_scan_in_inst_10_data_1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(70, 71, rdata);
        data = {{993{1'b0}}, rdata[12:6]};
    end
endtask
task write_FIELD_INSTRUCTION_1_REG_scan_in_inst_10_data_1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(70, 71, rdata);
        wdata = rdata;
        wdata[12:6] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(70 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_11_data_1
task read_FIELD_INSTRUCTION_1_REG_scan_in_inst_11_data_1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(71, 72, rdata);
        data = {{993{1'b0}}, rdata[11:5]};
    end
endtask
task write_FIELD_INSTRUCTION_1_REG_scan_in_inst_11_data_1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(71, 72, rdata);
        wdata = rdata;
        wdata[11:5] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(71 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_12_data_1
task read_FIELD_INSTRUCTION_1_REG_scan_in_inst_12_data_1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(72, 73, rdata);
        data = {{993{1'b0}}, rdata[10:4]};
    end
endtask
task write_FIELD_INSTRUCTION_1_REG_scan_in_inst_12_data_1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(72, 73, rdata);
        wdata = rdata;
        wdata[10:4] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(72 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_13_data_1
task read_FIELD_INSTRUCTION_1_REG_scan_in_inst_13_data_1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(73, 74, rdata);
        data = {{993{1'b0}}, rdata[9:3]};
    end
endtask
task write_FIELD_INSTRUCTION_1_REG_scan_in_inst_13_data_1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(73, 74, rdata);
        wdata = rdata;
        wdata[9:3] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(73 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_14_data_1
task read_FIELD_INSTRUCTION_1_REG_scan_in_inst_14_data_1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(74, 75, rdata);
        data = {{993{1'b0}}, rdata[8:2]};
    end
endtask
task write_FIELD_INSTRUCTION_1_REG_scan_in_inst_14_data_1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(74, 75, rdata);
        wdata = rdata;
        wdata[8:2] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(74 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_15_data_1
task read_FIELD_INSTRUCTION_1_REG_scan_in_inst_15_data_1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(75, 75, rdata);
        data = {{993{1'b0}}, rdata[7:1]};
    end
endtask
task write_FIELD_INSTRUCTION_1_REG_scan_in_inst_15_data_1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(75, 75, rdata);
        wdata = rdata;
        wdata[7:1] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(75 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_16_data_1
task read_FIELD_INSTRUCTION_1_REG_scan_in_inst_16_data_1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(76, 76, rdata);
        data = {{993{1'b0}}, rdata[6:0]};
    end
endtask
task write_FIELD_INSTRUCTION_1_REG_scan_in_inst_16_data_1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(76, 76, rdata);
        wdata = rdata;
        wdata[6:0] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(76 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_17_data_1
task read_FIELD_INSTRUCTION_1_REG_scan_in_inst_17_data_1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(76, 77, rdata);
        data = {{993{1'b0}}, rdata[13:7]};
    end
endtask
task write_FIELD_INSTRUCTION_1_REG_scan_in_inst_17_data_1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(76, 77, rdata);
        wdata = rdata;
        wdata[13:7] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(76 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_18_data_1
task read_FIELD_INSTRUCTION_1_REG_scan_in_inst_18_data_1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(77, 78, rdata);
        data = {{993{1'b0}}, rdata[12:6]};
    end
endtask
task write_FIELD_INSTRUCTION_1_REG_scan_in_inst_18_data_1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(77, 78, rdata);
        wdata = rdata;
        wdata[12:6] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(77 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_19_data_1
task read_FIELD_INSTRUCTION_1_REG_scan_in_inst_19_data_1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(78, 79, rdata);
        data = {{993{1'b0}}, rdata[11:5]};
    end
endtask
task write_FIELD_INSTRUCTION_1_REG_scan_in_inst_19_data_1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(78, 79, rdata);
        wdata = rdata;
        wdata[11:5] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(78 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_20_data_1
task read_FIELD_INSTRUCTION_1_REG_scan_in_inst_20_data_1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(79, 80, rdata);
        data = {{993{1'b0}}, rdata[10:4]};
    end
endtask
task write_FIELD_INSTRUCTION_1_REG_scan_in_inst_20_data_1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(79, 80, rdata);
        wdata = rdata;
        wdata[10:4] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(79 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_21_data_1
task read_FIELD_INSTRUCTION_1_REG_scan_in_inst_21_data_1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(80, 81, rdata);
        data = {{993{1'b0}}, rdata[9:3]};
    end
endtask
task write_FIELD_INSTRUCTION_1_REG_scan_in_inst_21_data_1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(80, 81, rdata);
        wdata = rdata;
        wdata[9:3] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(80 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_22_data_1
task read_FIELD_INSTRUCTION_1_REG_scan_in_inst_22_data_1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(81, 82, rdata);
        data = {{993{1'b0}}, rdata[8:2]};
    end
endtask
task write_FIELD_INSTRUCTION_1_REG_scan_in_inst_22_data_1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(81, 82, rdata);
        wdata = rdata;
        wdata[8:2] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(81 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_23_data_1
task read_FIELD_INSTRUCTION_1_REG_scan_in_inst_23_data_1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(82, 82, rdata);
        data = {{993{1'b0}}, rdata[7:1]};
    end
endtask
task write_FIELD_INSTRUCTION_1_REG_scan_in_inst_23_data_1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(82, 82, rdata);
        wdata = rdata;
        wdata[7:1] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(82 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_24_data_1
task read_FIELD_INSTRUCTION_1_REG_scan_in_inst_24_data_1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(83, 83, rdata);
        data = {{993{1'b0}}, rdata[6:0]};
    end
endtask
task write_FIELD_INSTRUCTION_1_REG_scan_in_inst_24_data_1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(83, 83, rdata);
        wdata = rdata;
        wdata[6:0] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(83 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_25_data_1
task read_FIELD_INSTRUCTION_1_REG_scan_in_inst_25_data_1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(83, 84, rdata);
        data = {{993{1'b0}}, rdata[13:7]};
    end
endtask
task write_FIELD_INSTRUCTION_1_REG_scan_in_inst_25_data_1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(83, 84, rdata);
        wdata = rdata;
        wdata[13:7] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(83 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_26_data_1
task read_FIELD_INSTRUCTION_1_REG_scan_in_inst_26_data_1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(84, 85, rdata);
        data = {{993{1'b0}}, rdata[12:6]};
    end
endtask
task write_FIELD_INSTRUCTION_1_REG_scan_in_inst_26_data_1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(84, 85, rdata);
        wdata = rdata;
        wdata[12:6] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(84 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_27_data_1
task read_FIELD_INSTRUCTION_1_REG_scan_in_inst_27_data_1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(85, 86, rdata);
        data = {{993{1'b0}}, rdata[11:5]};
    end
endtask
task write_FIELD_INSTRUCTION_1_REG_scan_in_inst_27_data_1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(85, 86, rdata);
        wdata = rdata;
        wdata[11:5] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(85 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_28_data_1
task read_FIELD_INSTRUCTION_1_REG_scan_in_inst_28_data_1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(86, 87, rdata);
        data = {{993{1'b0}}, rdata[10:4]};
    end
endtask
task write_FIELD_INSTRUCTION_1_REG_scan_in_inst_28_data_1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(86, 87, rdata);
        wdata = rdata;
        wdata[10:4] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(86 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_29_data_1
task read_FIELD_INSTRUCTION_1_REG_scan_in_inst_29_data_1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(87, 88, rdata);
        data = {{993{1'b0}}, rdata[9:3]};
    end
endtask
task write_FIELD_INSTRUCTION_1_REG_scan_in_inst_29_data_1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(87, 88, rdata);
        wdata = rdata;
        wdata[9:3] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(87 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_30_data_1
task read_FIELD_INSTRUCTION_1_REG_scan_in_inst_30_data_1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(88, 89, rdata);
        data = {{993{1'b0}}, rdata[8:2]};
    end
endtask
task write_FIELD_INSTRUCTION_1_REG_scan_in_inst_30_data_1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(88, 89, rdata);
        wdata = rdata;
        wdata[8:2] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(88 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_31_data_1
task read_FIELD_INSTRUCTION_1_REG_scan_in_inst_31_data_1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(89, 89, rdata);
        data = {{993{1'b0}}, rdata[7:1]};
    end
endtask
task write_FIELD_INSTRUCTION_1_REG_scan_in_inst_31_data_1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(89, 89, rdata);
        wdata = rdata;
        wdata[7:1] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(89 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_req_1
task read_FIELD_INSTRUCTION_1_REG_scan_in_inst_req_1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(90, 90, rdata);
        data = {{999{1'b0}}, rdata[0:0]};
    end
endtask
task write_FIELD_INSTRUCTION_1_REG_scan_in_inst_req_1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(90, 90, rdata);
        wdata = rdata;
        wdata[0:0] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(90 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_cmd_1
task read_FIELD_INSTRUCTION_1_REG_scan_in_inst_cmd_1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(90, 90, rdata);
        data = {{998{1'b0}}, rdata[2:1]};
    end
endtask
task write_FIELD_INSTRUCTION_1_REG_scan_in_inst_cmd_1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(90, 90, rdata);
        wdata = rdata;
        wdata[2:1] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(90 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_ack_1
task read_FIELD_INSTRUCTION_1_REG_scan_in_inst_ack_1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(90, 90, rdata);
        data = {{999{1'b0}}, rdata[3:3]};
    end
endtask
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Field: INSTRUCTION_2
//------------------------------------------------------------------------------
// Register: scan_in_inst_0_data_2
task read_FIELD_INSTRUCTION_2_REG_scan_in_inst_0_data_2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(91, 91, rdata);
        data = {{993{1'b0}}, rdata[6:0]};
    end
endtask
task write_FIELD_INSTRUCTION_2_REG_scan_in_inst_0_data_2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(91, 91, rdata);
        wdata = rdata;
        wdata[6:0] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(91 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_1_data_2
task read_FIELD_INSTRUCTION_2_REG_scan_in_inst_1_data_2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(91, 92, rdata);
        data = {{993{1'b0}}, rdata[13:7]};
    end
endtask
task write_FIELD_INSTRUCTION_2_REG_scan_in_inst_1_data_2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(91, 92, rdata);
        wdata = rdata;
        wdata[13:7] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(91 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_2_data_2
task read_FIELD_INSTRUCTION_2_REG_scan_in_inst_2_data_2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(92, 93, rdata);
        data = {{993{1'b0}}, rdata[12:6]};
    end
endtask
task write_FIELD_INSTRUCTION_2_REG_scan_in_inst_2_data_2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(92, 93, rdata);
        wdata = rdata;
        wdata[12:6] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(92 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_3_data_2
task read_FIELD_INSTRUCTION_2_REG_scan_in_inst_3_data_2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(93, 94, rdata);
        data = {{993{1'b0}}, rdata[11:5]};
    end
endtask
task write_FIELD_INSTRUCTION_2_REG_scan_in_inst_3_data_2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(93, 94, rdata);
        wdata = rdata;
        wdata[11:5] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(93 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_4_data_2
task read_FIELD_INSTRUCTION_2_REG_scan_in_inst_4_data_2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(94, 95, rdata);
        data = {{993{1'b0}}, rdata[10:4]};
    end
endtask
task write_FIELD_INSTRUCTION_2_REG_scan_in_inst_4_data_2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(94, 95, rdata);
        wdata = rdata;
        wdata[10:4] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(94 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_5_data_2
task read_FIELD_INSTRUCTION_2_REG_scan_in_inst_5_data_2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(95, 96, rdata);
        data = {{993{1'b0}}, rdata[9:3]};
    end
endtask
task write_FIELD_INSTRUCTION_2_REG_scan_in_inst_5_data_2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(95, 96, rdata);
        wdata = rdata;
        wdata[9:3] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(95 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_6_data_2
task read_FIELD_INSTRUCTION_2_REG_scan_in_inst_6_data_2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(96, 97, rdata);
        data = {{993{1'b0}}, rdata[8:2]};
    end
endtask
task write_FIELD_INSTRUCTION_2_REG_scan_in_inst_6_data_2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(96, 97, rdata);
        wdata = rdata;
        wdata[8:2] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(96 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_7_data_2
task read_FIELD_INSTRUCTION_2_REG_scan_in_inst_7_data_2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(97, 97, rdata);
        data = {{993{1'b0}}, rdata[7:1]};
    end
endtask
task write_FIELD_INSTRUCTION_2_REG_scan_in_inst_7_data_2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(97, 97, rdata);
        wdata = rdata;
        wdata[7:1] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(97 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_8_data_2
task read_FIELD_INSTRUCTION_2_REG_scan_in_inst_8_data_2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(98, 98, rdata);
        data = {{993{1'b0}}, rdata[6:0]};
    end
endtask
task write_FIELD_INSTRUCTION_2_REG_scan_in_inst_8_data_2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(98, 98, rdata);
        wdata = rdata;
        wdata[6:0] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(98 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_9_data_2
task read_FIELD_INSTRUCTION_2_REG_scan_in_inst_9_data_2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(98, 99, rdata);
        data = {{993{1'b0}}, rdata[13:7]};
    end
endtask
task write_FIELD_INSTRUCTION_2_REG_scan_in_inst_9_data_2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(98, 99, rdata);
        wdata = rdata;
        wdata[13:7] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(98 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_10_data_2
task read_FIELD_INSTRUCTION_2_REG_scan_in_inst_10_data_2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(99, 100, rdata);
        data = {{993{1'b0}}, rdata[12:6]};
    end
endtask
task write_FIELD_INSTRUCTION_2_REG_scan_in_inst_10_data_2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(99, 100, rdata);
        wdata = rdata;
        wdata[12:6] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(99 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_11_data_2
task read_FIELD_INSTRUCTION_2_REG_scan_in_inst_11_data_2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(100, 101, rdata);
        data = {{993{1'b0}}, rdata[11:5]};
    end
endtask
task write_FIELD_INSTRUCTION_2_REG_scan_in_inst_11_data_2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(100, 101, rdata);
        wdata = rdata;
        wdata[11:5] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(100 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_12_data_2
task read_FIELD_INSTRUCTION_2_REG_scan_in_inst_12_data_2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(101, 102, rdata);
        data = {{993{1'b0}}, rdata[10:4]};
    end
endtask
task write_FIELD_INSTRUCTION_2_REG_scan_in_inst_12_data_2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(101, 102, rdata);
        wdata = rdata;
        wdata[10:4] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(101 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_13_data_2
task read_FIELD_INSTRUCTION_2_REG_scan_in_inst_13_data_2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(102, 103, rdata);
        data = {{993{1'b0}}, rdata[9:3]};
    end
endtask
task write_FIELD_INSTRUCTION_2_REG_scan_in_inst_13_data_2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(102, 103, rdata);
        wdata = rdata;
        wdata[9:3] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(102 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_14_data_2
task read_FIELD_INSTRUCTION_2_REG_scan_in_inst_14_data_2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(103, 104, rdata);
        data = {{993{1'b0}}, rdata[8:2]};
    end
endtask
task write_FIELD_INSTRUCTION_2_REG_scan_in_inst_14_data_2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(103, 104, rdata);
        wdata = rdata;
        wdata[8:2] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(103 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_15_data_2
task read_FIELD_INSTRUCTION_2_REG_scan_in_inst_15_data_2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(104, 104, rdata);
        data = {{993{1'b0}}, rdata[7:1]};
    end
endtask
task write_FIELD_INSTRUCTION_2_REG_scan_in_inst_15_data_2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(104, 104, rdata);
        wdata = rdata;
        wdata[7:1] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(104 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_16_data_2
task read_FIELD_INSTRUCTION_2_REG_scan_in_inst_16_data_2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(105, 105, rdata);
        data = {{993{1'b0}}, rdata[6:0]};
    end
endtask
task write_FIELD_INSTRUCTION_2_REG_scan_in_inst_16_data_2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(105, 105, rdata);
        wdata = rdata;
        wdata[6:0] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(105 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_17_data_2
task read_FIELD_INSTRUCTION_2_REG_scan_in_inst_17_data_2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(105, 106, rdata);
        data = {{993{1'b0}}, rdata[13:7]};
    end
endtask
task write_FIELD_INSTRUCTION_2_REG_scan_in_inst_17_data_2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(105, 106, rdata);
        wdata = rdata;
        wdata[13:7] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(105 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_18_data_2
task read_FIELD_INSTRUCTION_2_REG_scan_in_inst_18_data_2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(106, 107, rdata);
        data = {{993{1'b0}}, rdata[12:6]};
    end
endtask
task write_FIELD_INSTRUCTION_2_REG_scan_in_inst_18_data_2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(106, 107, rdata);
        wdata = rdata;
        wdata[12:6] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(106 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_19_data_2
task read_FIELD_INSTRUCTION_2_REG_scan_in_inst_19_data_2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(107, 108, rdata);
        data = {{993{1'b0}}, rdata[11:5]};
    end
endtask
task write_FIELD_INSTRUCTION_2_REG_scan_in_inst_19_data_2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(107, 108, rdata);
        wdata = rdata;
        wdata[11:5] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(107 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_20_data_2
task read_FIELD_INSTRUCTION_2_REG_scan_in_inst_20_data_2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(108, 109, rdata);
        data = {{993{1'b0}}, rdata[10:4]};
    end
endtask
task write_FIELD_INSTRUCTION_2_REG_scan_in_inst_20_data_2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(108, 109, rdata);
        wdata = rdata;
        wdata[10:4] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(108 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_21_data_2
task read_FIELD_INSTRUCTION_2_REG_scan_in_inst_21_data_2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(109, 110, rdata);
        data = {{993{1'b0}}, rdata[9:3]};
    end
endtask
task write_FIELD_INSTRUCTION_2_REG_scan_in_inst_21_data_2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(109, 110, rdata);
        wdata = rdata;
        wdata[9:3] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(109 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_22_data_2
task read_FIELD_INSTRUCTION_2_REG_scan_in_inst_22_data_2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(110, 111, rdata);
        data = {{993{1'b0}}, rdata[8:2]};
    end
endtask
task write_FIELD_INSTRUCTION_2_REG_scan_in_inst_22_data_2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(110, 111, rdata);
        wdata = rdata;
        wdata[8:2] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(110 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_23_data_2
task read_FIELD_INSTRUCTION_2_REG_scan_in_inst_23_data_2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(111, 111, rdata);
        data = {{993{1'b0}}, rdata[7:1]};
    end
endtask
task write_FIELD_INSTRUCTION_2_REG_scan_in_inst_23_data_2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(111, 111, rdata);
        wdata = rdata;
        wdata[7:1] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(111 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_24_data_2
task read_FIELD_INSTRUCTION_2_REG_scan_in_inst_24_data_2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(112, 112, rdata);
        data = {{993{1'b0}}, rdata[6:0]};
    end
endtask
task write_FIELD_INSTRUCTION_2_REG_scan_in_inst_24_data_2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(112, 112, rdata);
        wdata = rdata;
        wdata[6:0] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(112 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_25_data_2
task read_FIELD_INSTRUCTION_2_REG_scan_in_inst_25_data_2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(112, 113, rdata);
        data = {{993{1'b0}}, rdata[13:7]};
    end
endtask
task write_FIELD_INSTRUCTION_2_REG_scan_in_inst_25_data_2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(112, 113, rdata);
        wdata = rdata;
        wdata[13:7] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(112 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_26_data_2
task read_FIELD_INSTRUCTION_2_REG_scan_in_inst_26_data_2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(113, 114, rdata);
        data = {{993{1'b0}}, rdata[12:6]};
    end
endtask
task write_FIELD_INSTRUCTION_2_REG_scan_in_inst_26_data_2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(113, 114, rdata);
        wdata = rdata;
        wdata[12:6] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(113 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_27_data_2
task read_FIELD_INSTRUCTION_2_REG_scan_in_inst_27_data_2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(114, 115, rdata);
        data = {{993{1'b0}}, rdata[11:5]};
    end
endtask
task write_FIELD_INSTRUCTION_2_REG_scan_in_inst_27_data_2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(114, 115, rdata);
        wdata = rdata;
        wdata[11:5] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(114 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_28_data_2
task read_FIELD_INSTRUCTION_2_REG_scan_in_inst_28_data_2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(115, 116, rdata);
        data = {{993{1'b0}}, rdata[10:4]};
    end
endtask
task write_FIELD_INSTRUCTION_2_REG_scan_in_inst_28_data_2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(115, 116, rdata);
        wdata = rdata;
        wdata[10:4] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(115 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_29_data_2
task read_FIELD_INSTRUCTION_2_REG_scan_in_inst_29_data_2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(116, 117, rdata);
        data = {{993{1'b0}}, rdata[9:3]};
    end
endtask
task write_FIELD_INSTRUCTION_2_REG_scan_in_inst_29_data_2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(116, 117, rdata);
        wdata = rdata;
        wdata[9:3] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(116 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_30_data_2
task read_FIELD_INSTRUCTION_2_REG_scan_in_inst_30_data_2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(117, 118, rdata);
        data = {{993{1'b0}}, rdata[8:2]};
    end
endtask
task write_FIELD_INSTRUCTION_2_REG_scan_in_inst_30_data_2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(117, 118, rdata);
        wdata = rdata;
        wdata[8:2] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(117 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_31_data_2
task read_FIELD_INSTRUCTION_2_REG_scan_in_inst_31_data_2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(118, 118, rdata);
        data = {{993{1'b0}}, rdata[7:1]};
    end
endtask
task write_FIELD_INSTRUCTION_2_REG_scan_in_inst_31_data_2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(118, 118, rdata);
        wdata = rdata;
        wdata[7:1] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(118 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_req_2
task read_FIELD_INSTRUCTION_2_REG_scan_in_inst_req_2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(119, 119, rdata);
        data = {{999{1'b0}}, rdata[0:0]};
    end
endtask
task write_FIELD_INSTRUCTION_2_REG_scan_in_inst_req_2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(119, 119, rdata);
        wdata = rdata;
        wdata[0:0] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(119 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_cmd_2
task read_FIELD_INSTRUCTION_2_REG_scan_in_inst_cmd_2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(119, 119, rdata);
        data = {{998{1'b0}}, rdata[2:1]};
    end
endtask
task write_FIELD_INSTRUCTION_2_REG_scan_in_inst_cmd_2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(119, 119, rdata);
        wdata = rdata;
        wdata[2:1] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(119 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_ack_2
task read_FIELD_INSTRUCTION_2_REG_scan_in_inst_ack_2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(119, 119, rdata);
        data = {{999{1'b0}}, rdata[3:3]};
    end
endtask
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Field: INSTRUCTION_3
//------------------------------------------------------------------------------
// Register: scan_in_inst_0_data_3
task read_FIELD_INSTRUCTION_3_REG_scan_in_inst_0_data_3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(120, 120, rdata);
        data = {{993{1'b0}}, rdata[6:0]};
    end
endtask
task write_FIELD_INSTRUCTION_3_REG_scan_in_inst_0_data_3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(120, 120, rdata);
        wdata = rdata;
        wdata[6:0] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(120 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_1_data_3
task read_FIELD_INSTRUCTION_3_REG_scan_in_inst_1_data_3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(120, 121, rdata);
        data = {{993{1'b0}}, rdata[13:7]};
    end
endtask
task write_FIELD_INSTRUCTION_3_REG_scan_in_inst_1_data_3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(120, 121, rdata);
        wdata = rdata;
        wdata[13:7] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(120 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_2_data_3
task read_FIELD_INSTRUCTION_3_REG_scan_in_inst_2_data_3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(121, 122, rdata);
        data = {{993{1'b0}}, rdata[12:6]};
    end
endtask
task write_FIELD_INSTRUCTION_3_REG_scan_in_inst_2_data_3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(121, 122, rdata);
        wdata = rdata;
        wdata[12:6] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(121 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_3_data_3
task read_FIELD_INSTRUCTION_3_REG_scan_in_inst_3_data_3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(122, 123, rdata);
        data = {{993{1'b0}}, rdata[11:5]};
    end
endtask
task write_FIELD_INSTRUCTION_3_REG_scan_in_inst_3_data_3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(122, 123, rdata);
        wdata = rdata;
        wdata[11:5] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(122 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_4_data_3
task read_FIELD_INSTRUCTION_3_REG_scan_in_inst_4_data_3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(123, 124, rdata);
        data = {{993{1'b0}}, rdata[10:4]};
    end
endtask
task write_FIELD_INSTRUCTION_3_REG_scan_in_inst_4_data_3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(123, 124, rdata);
        wdata = rdata;
        wdata[10:4] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(123 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_5_data_3
task read_FIELD_INSTRUCTION_3_REG_scan_in_inst_5_data_3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(124, 125, rdata);
        data = {{993{1'b0}}, rdata[9:3]};
    end
endtask
task write_FIELD_INSTRUCTION_3_REG_scan_in_inst_5_data_3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(124, 125, rdata);
        wdata = rdata;
        wdata[9:3] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(124 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_6_data_3
task read_FIELD_INSTRUCTION_3_REG_scan_in_inst_6_data_3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(125, 126, rdata);
        data = {{993{1'b0}}, rdata[8:2]};
    end
endtask
task write_FIELD_INSTRUCTION_3_REG_scan_in_inst_6_data_3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(125, 126, rdata);
        wdata = rdata;
        wdata[8:2] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(125 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_7_data_3
task read_FIELD_INSTRUCTION_3_REG_scan_in_inst_7_data_3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(126, 126, rdata);
        data = {{993{1'b0}}, rdata[7:1]};
    end
endtask
task write_FIELD_INSTRUCTION_3_REG_scan_in_inst_7_data_3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(126, 126, rdata);
        wdata = rdata;
        wdata[7:1] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(126 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_8_data_3
task read_FIELD_INSTRUCTION_3_REG_scan_in_inst_8_data_3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(127, 127, rdata);
        data = {{993{1'b0}}, rdata[6:0]};
    end
endtask
task write_FIELD_INSTRUCTION_3_REG_scan_in_inst_8_data_3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(127, 127, rdata);
        wdata = rdata;
        wdata[6:0] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(127 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_9_data_3
task read_FIELD_INSTRUCTION_3_REG_scan_in_inst_9_data_3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(127, 128, rdata);
        data = {{993{1'b0}}, rdata[13:7]};
    end
endtask
task write_FIELD_INSTRUCTION_3_REG_scan_in_inst_9_data_3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(127, 128, rdata);
        wdata = rdata;
        wdata[13:7] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(127 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_10_data_3
task read_FIELD_INSTRUCTION_3_REG_scan_in_inst_10_data_3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(128, 129, rdata);
        data = {{993{1'b0}}, rdata[12:6]};
    end
endtask
task write_FIELD_INSTRUCTION_3_REG_scan_in_inst_10_data_3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(128, 129, rdata);
        wdata = rdata;
        wdata[12:6] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(128 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_11_data_3
task read_FIELD_INSTRUCTION_3_REG_scan_in_inst_11_data_3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(129, 130, rdata);
        data = {{993{1'b0}}, rdata[11:5]};
    end
endtask
task write_FIELD_INSTRUCTION_3_REG_scan_in_inst_11_data_3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(129, 130, rdata);
        wdata = rdata;
        wdata[11:5] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(129 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_12_data_3
task read_FIELD_INSTRUCTION_3_REG_scan_in_inst_12_data_3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(130, 131, rdata);
        data = {{993{1'b0}}, rdata[10:4]};
    end
endtask
task write_FIELD_INSTRUCTION_3_REG_scan_in_inst_12_data_3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(130, 131, rdata);
        wdata = rdata;
        wdata[10:4] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(130 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_13_data_3
task read_FIELD_INSTRUCTION_3_REG_scan_in_inst_13_data_3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(131, 132, rdata);
        data = {{993{1'b0}}, rdata[9:3]};
    end
endtask
task write_FIELD_INSTRUCTION_3_REG_scan_in_inst_13_data_3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(131, 132, rdata);
        wdata = rdata;
        wdata[9:3] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(131 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_14_data_3
task read_FIELD_INSTRUCTION_3_REG_scan_in_inst_14_data_3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(132, 133, rdata);
        data = {{993{1'b0}}, rdata[8:2]};
    end
endtask
task write_FIELD_INSTRUCTION_3_REG_scan_in_inst_14_data_3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(132, 133, rdata);
        wdata = rdata;
        wdata[8:2] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(132 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_15_data_3
task read_FIELD_INSTRUCTION_3_REG_scan_in_inst_15_data_3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(133, 133, rdata);
        data = {{993{1'b0}}, rdata[7:1]};
    end
endtask
task write_FIELD_INSTRUCTION_3_REG_scan_in_inst_15_data_3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(133, 133, rdata);
        wdata = rdata;
        wdata[7:1] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(133 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_16_data_3
task read_FIELD_INSTRUCTION_3_REG_scan_in_inst_16_data_3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(134, 134, rdata);
        data = {{993{1'b0}}, rdata[6:0]};
    end
endtask
task write_FIELD_INSTRUCTION_3_REG_scan_in_inst_16_data_3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(134, 134, rdata);
        wdata = rdata;
        wdata[6:0] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(134 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_17_data_3
task read_FIELD_INSTRUCTION_3_REG_scan_in_inst_17_data_3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(134, 135, rdata);
        data = {{993{1'b0}}, rdata[13:7]};
    end
endtask
task write_FIELD_INSTRUCTION_3_REG_scan_in_inst_17_data_3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(134, 135, rdata);
        wdata = rdata;
        wdata[13:7] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(134 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_18_data_3
task read_FIELD_INSTRUCTION_3_REG_scan_in_inst_18_data_3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(135, 136, rdata);
        data = {{993{1'b0}}, rdata[12:6]};
    end
endtask
task write_FIELD_INSTRUCTION_3_REG_scan_in_inst_18_data_3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(135, 136, rdata);
        wdata = rdata;
        wdata[12:6] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(135 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_19_data_3
task read_FIELD_INSTRUCTION_3_REG_scan_in_inst_19_data_3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(136, 137, rdata);
        data = {{993{1'b0}}, rdata[11:5]};
    end
endtask
task write_FIELD_INSTRUCTION_3_REG_scan_in_inst_19_data_3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(136, 137, rdata);
        wdata = rdata;
        wdata[11:5] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(136 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_20_data_3
task read_FIELD_INSTRUCTION_3_REG_scan_in_inst_20_data_3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(137, 138, rdata);
        data = {{993{1'b0}}, rdata[10:4]};
    end
endtask
task write_FIELD_INSTRUCTION_3_REG_scan_in_inst_20_data_3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(137, 138, rdata);
        wdata = rdata;
        wdata[10:4] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(137 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_21_data_3
task read_FIELD_INSTRUCTION_3_REG_scan_in_inst_21_data_3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(138, 139, rdata);
        data = {{993{1'b0}}, rdata[9:3]};
    end
endtask
task write_FIELD_INSTRUCTION_3_REG_scan_in_inst_21_data_3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(138, 139, rdata);
        wdata = rdata;
        wdata[9:3] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(138 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_22_data_3
task read_FIELD_INSTRUCTION_3_REG_scan_in_inst_22_data_3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(139, 140, rdata);
        data = {{993{1'b0}}, rdata[8:2]};
    end
endtask
task write_FIELD_INSTRUCTION_3_REG_scan_in_inst_22_data_3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(139, 140, rdata);
        wdata = rdata;
        wdata[8:2] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(139 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_23_data_3
task read_FIELD_INSTRUCTION_3_REG_scan_in_inst_23_data_3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(140, 140, rdata);
        data = {{993{1'b0}}, rdata[7:1]};
    end
endtask
task write_FIELD_INSTRUCTION_3_REG_scan_in_inst_23_data_3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(140, 140, rdata);
        wdata = rdata;
        wdata[7:1] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(140 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_24_data_3
task read_FIELD_INSTRUCTION_3_REG_scan_in_inst_24_data_3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(141, 141, rdata);
        data = {{993{1'b0}}, rdata[6:0]};
    end
endtask
task write_FIELD_INSTRUCTION_3_REG_scan_in_inst_24_data_3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(141, 141, rdata);
        wdata = rdata;
        wdata[6:0] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(141 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_25_data_3
task read_FIELD_INSTRUCTION_3_REG_scan_in_inst_25_data_3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(141, 142, rdata);
        data = {{993{1'b0}}, rdata[13:7]};
    end
endtask
task write_FIELD_INSTRUCTION_3_REG_scan_in_inst_25_data_3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(141, 142, rdata);
        wdata = rdata;
        wdata[13:7] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(141 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_26_data_3
task read_FIELD_INSTRUCTION_3_REG_scan_in_inst_26_data_3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(142, 143, rdata);
        data = {{993{1'b0}}, rdata[12:6]};
    end
endtask
task write_FIELD_INSTRUCTION_3_REG_scan_in_inst_26_data_3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(142, 143, rdata);
        wdata = rdata;
        wdata[12:6] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(142 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_27_data_3
task read_FIELD_INSTRUCTION_3_REG_scan_in_inst_27_data_3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(143, 144, rdata);
        data = {{993{1'b0}}, rdata[11:5]};
    end
endtask
task write_FIELD_INSTRUCTION_3_REG_scan_in_inst_27_data_3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(143, 144, rdata);
        wdata = rdata;
        wdata[11:5] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(143 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_28_data_3
task read_FIELD_INSTRUCTION_3_REG_scan_in_inst_28_data_3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(144, 145, rdata);
        data = {{993{1'b0}}, rdata[10:4]};
    end
endtask
task write_FIELD_INSTRUCTION_3_REG_scan_in_inst_28_data_3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(144, 145, rdata);
        wdata = rdata;
        wdata[10:4] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(144 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_29_data_3
task read_FIELD_INSTRUCTION_3_REG_scan_in_inst_29_data_3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(145, 146, rdata);
        data = {{993{1'b0}}, rdata[9:3]};
    end
endtask
task write_FIELD_INSTRUCTION_3_REG_scan_in_inst_29_data_3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(145, 146, rdata);
        wdata = rdata;
        wdata[9:3] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(145 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_30_data_3
task read_FIELD_INSTRUCTION_3_REG_scan_in_inst_30_data_3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(146, 147, rdata);
        data = {{993{1'b0}}, rdata[8:2]};
    end
endtask
task write_FIELD_INSTRUCTION_3_REG_scan_in_inst_30_data_3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(146, 147, rdata);
        wdata = rdata;
        wdata[8:2] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(146 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_31_data_3
task read_FIELD_INSTRUCTION_3_REG_scan_in_inst_31_data_3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(147, 147, rdata);
        data = {{993{1'b0}}, rdata[7:1]};
    end
endtask
task write_FIELD_INSTRUCTION_3_REG_scan_in_inst_31_data_3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(147, 147, rdata);
        wdata = rdata;
        wdata[7:1] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(147 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_req_3
task read_FIELD_INSTRUCTION_3_REG_scan_in_inst_req_3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(148, 148, rdata);
        data = {{999{1'b0}}, rdata[0:0]};
    end
endtask
task write_FIELD_INSTRUCTION_3_REG_scan_in_inst_req_3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(148, 148, rdata);
        wdata = rdata;
        wdata[0:0] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(148 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_cmd_3
task read_FIELD_INSTRUCTION_3_REG_scan_in_inst_cmd_3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(148, 148, rdata);
        data = {{998{1'b0}}, rdata[2:1]};
    end
endtask
task write_FIELD_INSTRUCTION_3_REG_scan_in_inst_cmd_3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(148, 148, rdata);
        wdata = rdata;
        wdata[2:1] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(148 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: scan_in_inst_ack_3
task read_FIELD_INSTRUCTION_3_REG_scan_in_inst_ack_3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(148, 148, rdata);
        data = {{999{1'b0}}, rdata[3:3]};
    end
endtask
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Field: I2C
//------------------------------------------------------------------------------
// Register: i2c_req
task read_FIELD_I2C_REG_i2c_req(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(149, 149, rdata);
        data = {{999{1'b0}}, rdata[0:0]};
    end
endtask
task write_FIELD_I2C_REG_i2c_req(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(149, 149, rdata);
        wdata = rdata;
        wdata[0:0] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(149 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: i2c_slave_address
task read_FIELD_I2C_REG_i2c_slave_address(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(149, 149, rdata);
        data = {{993{1'b0}}, rdata[7:1]};
    end
endtask
task write_FIELD_I2C_REG_i2c_slave_address(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(149, 149, rdata);
        wdata = rdata;
        wdata[7:1] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(149 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: i2c_burst_count_wr
task read_FIELD_I2C_REG_i2c_burst_count_wr(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(150, 150, rdata);
        data = {{998{1'b0}}, rdata[1:0]};
    end
endtask
task write_FIELD_I2C_REG_i2c_burst_count_wr(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(150, 150, rdata);
        wdata = rdata;
        wdata[1:0] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(150 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: i2c_burst_count_rd
task read_FIELD_I2C_REG_i2c_burst_count_rd(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(150, 150, rdata);
        data = {{998{1'b0}}, rdata[3:2]};
    end
endtask
task write_FIELD_I2C_REG_i2c_burst_count_rd(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(150, 150, rdata);
        wdata = rdata;
        wdata[3:2] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(150 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: i2c_wdata0
task read_FIELD_I2C_REG_i2c_wdata0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(150, 151, rdata);
        data = {{992{1'b0}}, rdata[11:4]};
    end
endtask
task write_FIELD_I2C_REG_i2c_wdata0(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(150, 151, rdata);
        wdata = rdata;
        wdata[11:4] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(150 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: i2c_wdata1
task read_FIELD_I2C_REG_i2c_wdata1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(151, 152, rdata);
        data = {{992{1'b0}}, rdata[11:4]};
    end
endtask
task write_FIELD_I2C_REG_i2c_wdata1(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(151, 152, rdata);
        wdata = rdata;
        wdata[11:4] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(151 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: i2c_wdata2
task read_FIELD_I2C_REG_i2c_wdata2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(152, 153, rdata);
        data = {{992{1'b0}}, rdata[11:4]};
    end
endtask
task write_FIELD_I2C_REG_i2c_wdata2(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(152, 153, rdata);
        wdata = rdata;
        wdata[11:4] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(152 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: i2c_wdata3
task read_FIELD_I2C_REG_i2c_wdata3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(153, 154, rdata);
        data = {{992{1'b0}}, rdata[11:4]};
    end
endtask
task write_FIELD_I2C_REG_i2c_wdata3(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(153, 154, rdata);
        wdata = rdata;
        wdata[11:4] = data;
        for (i = 0; i <= 1; i = i + 1) begin
            write(153 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: i2c_rd_wrn
task read_FIELD_I2C_REG_i2c_rd_wrn(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(154, 154, rdata);
        data = {{999{1'b0}}, rdata[4:4]};
    end
endtask
task write_FIELD_I2C_REG_i2c_rd_wrn(input [999:0] data);
    logic [999:0] rdata, wdata;
    begin
        read_all_bytes(154, 154, rdata);
        wdata = rdata;
        wdata[4:4] = data;
        for (i = 0; i <= 0; i = i + 1) begin
            write(154 + i, wdata[8*i +: 8]);
        end 
    end 
endtask

// Register: i2c_ack
task read_FIELD_I2C_REG_i2c_ack(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(154, 154, rdata);
        data = {{999{1'b0}}, rdata[5:5]};
    end
endtask

// Register: i2c_nack
task read_FIELD_I2C_REG_i2c_nack(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(154, 154, rdata);
        data = {{999{1'b0}}, rdata[6:6]};
    end
endtask

// Register: i2c_rdata0
task read_FIELD_I2C_REG_i2c_rdata0(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(154, 155, rdata);
        data = {{992{1'b0}}, rdata[14:7]};
    end
endtask

// Register: i2c_rdata1
task read_FIELD_I2C_REG_i2c_rdata1(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(155, 156, rdata);
        data = {{992{1'b0}}, rdata[14:7]};
    end
endtask

// Register: i2c_rdata2
task read_FIELD_I2C_REG_i2c_rdata2(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(156, 157, rdata);
        data = {{992{1'b0}}, rdata[14:7]};
    end
endtask

// Register: i2c_rdata3
task read_FIELD_I2C_REG_i2c_rdata3(output [999:0] data);
    logic [999:0] rdata;
    begin
        read_all_bytes(157, 158, rdata);
        data = {{992{1'b0}}, rdata[14:7]};
    end
endtask
//------------------------------------------------------------------------------

