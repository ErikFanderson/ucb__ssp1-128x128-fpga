
/****************************************************/
/* Instantiate Module: ssp1_controller_uart_mem_map */
/****************************************************/
ssp1_controller_uart_mem_map ssp1_controller_uart_instance
(
.ssp1_controller_uart_write_mem(ssp1_controller_uart_write_mem),
.ssp1_controller_uart_read_mem(ssp1_controller_uart_read_mem),
.reset(reset),
.leds(leds),
.shifter_oe_n(shifter_oe_n),
.scan_cg_en(scan_cg_en),
.loopback_so_data_0(loopback_so_data_0),
.loopback_so_data_1(loopback_so_data_1),
.loopback_so_data_2(loopback_so_data_2),
.loopback_so_data_3(loopback_so_data_3),
.scan_in_addr_address_0_r0(scan_in_addr_address_0_r0),
.scan_in_addr_lb_sel_0_r0(scan_in_addr_lb_sel_0_r0),
.scan_in_addr_enable_0_r0(scan_in_addr_enable_0_r0),
.scan_in_addr_address_0_r1(scan_in_addr_address_0_r1),
.scan_in_addr_lb_sel_0_r1(scan_in_addr_lb_sel_0_r1),
.scan_in_addr_enable_0_r1(scan_in_addr_enable_0_r1),
.scan_in_addr_address_0_r2(scan_in_addr_address_0_r2),
.scan_in_addr_lb_sel_0_r2(scan_in_addr_lb_sel_0_r2),
.scan_in_addr_enable_0_r2(scan_in_addr_enable_0_r2),
.scan_in_addr_address_0_r3(scan_in_addr_address_0_r3),
.scan_in_addr_lb_sel_0_r3(scan_in_addr_lb_sel_0_r3),
.scan_in_addr_enable_0_r3(scan_in_addr_enable_0_r3),
.scan_in_addr_req_0(scan_in_addr_req_0),
.scan_in_addr_ack_0(scan_in_addr_ack_0),
.scan_in_addr_cmd_0(scan_in_addr_cmd_0),
.scan_in_addr_address_1_r0(scan_in_addr_address_1_r0),
.scan_in_addr_lb_sel_1_r0(scan_in_addr_lb_sel_1_r0),
.scan_in_addr_enable_1_r0(scan_in_addr_enable_1_r0),
.scan_in_addr_address_1_r1(scan_in_addr_address_1_r1),
.scan_in_addr_lb_sel_1_r1(scan_in_addr_lb_sel_1_r1),
.scan_in_addr_enable_1_r1(scan_in_addr_enable_1_r1),
.scan_in_addr_address_1_r2(scan_in_addr_address_1_r2),
.scan_in_addr_lb_sel_1_r2(scan_in_addr_lb_sel_1_r2),
.scan_in_addr_enable_1_r2(scan_in_addr_enable_1_r2),
.scan_in_addr_address_1_r3(scan_in_addr_address_1_r3),
.scan_in_addr_lb_sel_1_r3(scan_in_addr_lb_sel_1_r3),
.scan_in_addr_enable_1_r3(scan_in_addr_enable_1_r3),
.scan_in_addr_req_1(scan_in_addr_req_1),
.scan_in_addr_ack_1(scan_in_addr_ack_1),
.scan_in_addr_cmd_1(scan_in_addr_cmd_1),
.scan_in_addr_address_2_r0(scan_in_addr_address_2_r0),
.scan_in_addr_lb_sel_2_r0(scan_in_addr_lb_sel_2_r0),
.scan_in_addr_enable_2_r0(scan_in_addr_enable_2_r0),
.scan_in_addr_address_2_r1(scan_in_addr_address_2_r1),
.scan_in_addr_lb_sel_2_r1(scan_in_addr_lb_sel_2_r1),
.scan_in_addr_enable_2_r1(scan_in_addr_enable_2_r1),
.scan_in_addr_address_2_r2(scan_in_addr_address_2_r2),
.scan_in_addr_lb_sel_2_r2(scan_in_addr_lb_sel_2_r2),
.scan_in_addr_enable_2_r2(scan_in_addr_enable_2_r2),
.scan_in_addr_address_2_r3(scan_in_addr_address_2_r3),
.scan_in_addr_lb_sel_2_r3(scan_in_addr_lb_sel_2_r3),
.scan_in_addr_enable_2_r3(scan_in_addr_enable_2_r3),
.scan_in_addr_req_2(scan_in_addr_req_2),
.scan_in_addr_ack_2(scan_in_addr_ack_2),
.scan_in_addr_cmd_2(scan_in_addr_cmd_2),
.scan_in_addr_address_3_r0(scan_in_addr_address_3_r0),
.scan_in_addr_lb_sel_3_r0(scan_in_addr_lb_sel_3_r0),
.scan_in_addr_enable_3_r0(scan_in_addr_enable_3_r0),
.scan_in_addr_address_3_r1(scan_in_addr_address_3_r1),
.scan_in_addr_lb_sel_3_r1(scan_in_addr_lb_sel_3_r1),
.scan_in_addr_enable_3_r1(scan_in_addr_enable_3_r1),
.scan_in_addr_address_3_r2(scan_in_addr_address_3_r2),
.scan_in_addr_lb_sel_3_r2(scan_in_addr_lb_sel_3_r2),
.scan_in_addr_enable_3_r2(scan_in_addr_enable_3_r2),
.scan_in_addr_address_3_r3(scan_in_addr_address_3_r3),
.scan_in_addr_lb_sel_3_r3(scan_in_addr_lb_sel_3_r3),
.scan_in_addr_enable_3_r3(scan_in_addr_enable_3_r3),
.scan_in_addr_req_3(scan_in_addr_req_3),
.scan_in_addr_ack_3(scan_in_addr_ack_3),
.scan_in_addr_cmd_3(scan_in_addr_cmd_3),
.scan_in_inst_0_data_0(scan_in_inst_0_data_0),
.scan_in_inst_1_data_0(scan_in_inst_1_data_0),
.scan_in_inst_2_data_0(scan_in_inst_2_data_0),
.scan_in_inst_3_data_0(scan_in_inst_3_data_0),
.scan_in_inst_4_data_0(scan_in_inst_4_data_0),
.scan_in_inst_5_data_0(scan_in_inst_5_data_0),
.scan_in_inst_6_data_0(scan_in_inst_6_data_0),
.scan_in_inst_7_data_0(scan_in_inst_7_data_0),
.scan_in_inst_8_data_0(scan_in_inst_8_data_0),
.scan_in_inst_9_data_0(scan_in_inst_9_data_0),
.scan_in_inst_10_data_0(scan_in_inst_10_data_0),
.scan_in_inst_11_data_0(scan_in_inst_11_data_0),
.scan_in_inst_12_data_0(scan_in_inst_12_data_0),
.scan_in_inst_13_data_0(scan_in_inst_13_data_0),
.scan_in_inst_14_data_0(scan_in_inst_14_data_0),
.scan_in_inst_15_data_0(scan_in_inst_15_data_0),
.scan_in_inst_16_data_0(scan_in_inst_16_data_0),
.scan_in_inst_17_data_0(scan_in_inst_17_data_0),
.scan_in_inst_18_data_0(scan_in_inst_18_data_0),
.scan_in_inst_19_data_0(scan_in_inst_19_data_0),
.scan_in_inst_20_data_0(scan_in_inst_20_data_0),
.scan_in_inst_21_data_0(scan_in_inst_21_data_0),
.scan_in_inst_22_data_0(scan_in_inst_22_data_0),
.scan_in_inst_23_data_0(scan_in_inst_23_data_0),
.scan_in_inst_24_data_0(scan_in_inst_24_data_0),
.scan_in_inst_25_data_0(scan_in_inst_25_data_0),
.scan_in_inst_26_data_0(scan_in_inst_26_data_0),
.scan_in_inst_27_data_0(scan_in_inst_27_data_0),
.scan_in_inst_28_data_0(scan_in_inst_28_data_0),
.scan_in_inst_29_data_0(scan_in_inst_29_data_0),
.scan_in_inst_30_data_0(scan_in_inst_30_data_0),
.scan_in_inst_31_data_0(scan_in_inst_31_data_0),
.scan_in_inst_req_0(scan_in_inst_req_0),
.scan_in_inst_ack_0(scan_in_inst_ack_0),
.scan_in_inst_cmd_0(scan_in_inst_cmd_0),
.scan_in_inst_0_data_1(scan_in_inst_0_data_1),
.scan_in_inst_1_data_1(scan_in_inst_1_data_1),
.scan_in_inst_2_data_1(scan_in_inst_2_data_1),
.scan_in_inst_3_data_1(scan_in_inst_3_data_1),
.scan_in_inst_4_data_1(scan_in_inst_4_data_1),
.scan_in_inst_5_data_1(scan_in_inst_5_data_1),
.scan_in_inst_6_data_1(scan_in_inst_6_data_1),
.scan_in_inst_7_data_1(scan_in_inst_7_data_1),
.scan_in_inst_8_data_1(scan_in_inst_8_data_1),
.scan_in_inst_9_data_1(scan_in_inst_9_data_1),
.scan_in_inst_10_data_1(scan_in_inst_10_data_1),
.scan_in_inst_11_data_1(scan_in_inst_11_data_1),
.scan_in_inst_12_data_1(scan_in_inst_12_data_1),
.scan_in_inst_13_data_1(scan_in_inst_13_data_1),
.scan_in_inst_14_data_1(scan_in_inst_14_data_1),
.scan_in_inst_15_data_1(scan_in_inst_15_data_1),
.scan_in_inst_16_data_1(scan_in_inst_16_data_1),
.scan_in_inst_17_data_1(scan_in_inst_17_data_1),
.scan_in_inst_18_data_1(scan_in_inst_18_data_1),
.scan_in_inst_19_data_1(scan_in_inst_19_data_1),
.scan_in_inst_20_data_1(scan_in_inst_20_data_1),
.scan_in_inst_21_data_1(scan_in_inst_21_data_1),
.scan_in_inst_22_data_1(scan_in_inst_22_data_1),
.scan_in_inst_23_data_1(scan_in_inst_23_data_1),
.scan_in_inst_24_data_1(scan_in_inst_24_data_1),
.scan_in_inst_25_data_1(scan_in_inst_25_data_1),
.scan_in_inst_26_data_1(scan_in_inst_26_data_1),
.scan_in_inst_27_data_1(scan_in_inst_27_data_1),
.scan_in_inst_28_data_1(scan_in_inst_28_data_1),
.scan_in_inst_29_data_1(scan_in_inst_29_data_1),
.scan_in_inst_30_data_1(scan_in_inst_30_data_1),
.scan_in_inst_31_data_1(scan_in_inst_31_data_1),
.scan_in_inst_req_1(scan_in_inst_req_1),
.scan_in_inst_ack_1(scan_in_inst_ack_1),
.scan_in_inst_cmd_1(scan_in_inst_cmd_1),
.scan_in_inst_0_data_2(scan_in_inst_0_data_2),
.scan_in_inst_1_data_2(scan_in_inst_1_data_2),
.scan_in_inst_2_data_2(scan_in_inst_2_data_2),
.scan_in_inst_3_data_2(scan_in_inst_3_data_2),
.scan_in_inst_4_data_2(scan_in_inst_4_data_2),
.scan_in_inst_5_data_2(scan_in_inst_5_data_2),
.scan_in_inst_6_data_2(scan_in_inst_6_data_2),
.scan_in_inst_7_data_2(scan_in_inst_7_data_2),
.scan_in_inst_8_data_2(scan_in_inst_8_data_2),
.scan_in_inst_9_data_2(scan_in_inst_9_data_2),
.scan_in_inst_10_data_2(scan_in_inst_10_data_2),
.scan_in_inst_11_data_2(scan_in_inst_11_data_2),
.scan_in_inst_12_data_2(scan_in_inst_12_data_2),
.scan_in_inst_13_data_2(scan_in_inst_13_data_2),
.scan_in_inst_14_data_2(scan_in_inst_14_data_2),
.scan_in_inst_15_data_2(scan_in_inst_15_data_2),
.scan_in_inst_16_data_2(scan_in_inst_16_data_2),
.scan_in_inst_17_data_2(scan_in_inst_17_data_2),
.scan_in_inst_18_data_2(scan_in_inst_18_data_2),
.scan_in_inst_19_data_2(scan_in_inst_19_data_2),
.scan_in_inst_20_data_2(scan_in_inst_20_data_2),
.scan_in_inst_21_data_2(scan_in_inst_21_data_2),
.scan_in_inst_22_data_2(scan_in_inst_22_data_2),
.scan_in_inst_23_data_2(scan_in_inst_23_data_2),
.scan_in_inst_24_data_2(scan_in_inst_24_data_2),
.scan_in_inst_25_data_2(scan_in_inst_25_data_2),
.scan_in_inst_26_data_2(scan_in_inst_26_data_2),
.scan_in_inst_27_data_2(scan_in_inst_27_data_2),
.scan_in_inst_28_data_2(scan_in_inst_28_data_2),
.scan_in_inst_29_data_2(scan_in_inst_29_data_2),
.scan_in_inst_30_data_2(scan_in_inst_30_data_2),
.scan_in_inst_31_data_2(scan_in_inst_31_data_2),
.scan_in_inst_req_2(scan_in_inst_req_2),
.scan_in_inst_ack_2(scan_in_inst_ack_2),
.scan_in_inst_cmd_2(scan_in_inst_cmd_2),
.scan_in_inst_0_data_3(scan_in_inst_0_data_3),
.scan_in_inst_1_data_3(scan_in_inst_1_data_3),
.scan_in_inst_2_data_3(scan_in_inst_2_data_3),
.scan_in_inst_3_data_3(scan_in_inst_3_data_3),
.scan_in_inst_4_data_3(scan_in_inst_4_data_3),
.scan_in_inst_5_data_3(scan_in_inst_5_data_3),
.scan_in_inst_6_data_3(scan_in_inst_6_data_3),
.scan_in_inst_7_data_3(scan_in_inst_7_data_3),
.scan_in_inst_8_data_3(scan_in_inst_8_data_3),
.scan_in_inst_9_data_3(scan_in_inst_9_data_3),
.scan_in_inst_10_data_3(scan_in_inst_10_data_3),
.scan_in_inst_11_data_3(scan_in_inst_11_data_3),
.scan_in_inst_12_data_3(scan_in_inst_12_data_3),
.scan_in_inst_13_data_3(scan_in_inst_13_data_3),
.scan_in_inst_14_data_3(scan_in_inst_14_data_3),
.scan_in_inst_15_data_3(scan_in_inst_15_data_3),
.scan_in_inst_16_data_3(scan_in_inst_16_data_3),
.scan_in_inst_17_data_3(scan_in_inst_17_data_3),
.scan_in_inst_18_data_3(scan_in_inst_18_data_3),
.scan_in_inst_19_data_3(scan_in_inst_19_data_3),
.scan_in_inst_20_data_3(scan_in_inst_20_data_3),
.scan_in_inst_21_data_3(scan_in_inst_21_data_3),
.scan_in_inst_22_data_3(scan_in_inst_22_data_3),
.scan_in_inst_23_data_3(scan_in_inst_23_data_3),
.scan_in_inst_24_data_3(scan_in_inst_24_data_3),
.scan_in_inst_25_data_3(scan_in_inst_25_data_3),
.scan_in_inst_26_data_3(scan_in_inst_26_data_3),
.scan_in_inst_27_data_3(scan_in_inst_27_data_3),
.scan_in_inst_28_data_3(scan_in_inst_28_data_3),
.scan_in_inst_29_data_3(scan_in_inst_29_data_3),
.scan_in_inst_30_data_3(scan_in_inst_30_data_3),
.scan_in_inst_31_data_3(scan_in_inst_31_data_3),
.scan_in_inst_req_3(scan_in_inst_req_3),
.scan_in_inst_ack_3(scan_in_inst_ack_3),
.scan_in_inst_cmd_3(scan_in_inst_cmd_3),
.i2c_req(i2c_req),
.i2c_ack(i2c_ack),
.i2c_slave_address(i2c_slave_address),
.i2c_burst_count_wr(i2c_burst_count_wr),
.i2c_burst_count_rd(i2c_burst_count_rd),
.i2c_wdata0(i2c_wdata0),
.i2c_wdata1(i2c_wdata1),
.i2c_wdata2(i2c_wdata2),
.i2c_wdata3(i2c_wdata3),
.i2c_rd_wrn(i2c_rd_wrn),
.i2c_nack(i2c_nack),
.i2c_rdata0(i2c_rdata0),
.i2c_rdata1(i2c_rdata1),
.i2c_rdata2(i2c_rdata2),
.i2c_rdata3(i2c_rdata3)
);

/*********************/
/* Wire Declarations */
/*********************/
wire [7:0] ssp1_controller_uart_write_mem [255:0];
wire [7:0] ssp1_controller_uart_read_mem [255:0];
wire reset;
wire [7:0] leds;
wire shifter_oe_n;
wire scan_cg_en;
wire [27:0] loopback_so_data_0;
wire [27:0] loopback_so_data_1;
wire [27:0] loopback_so_data_2;
wire [27:0] loopback_so_data_3;
wire [1:0] scan_in_addr_address_0_r0;
wire [3:0] scan_in_addr_lb_sel_0_r0;
wire scan_in_addr_enable_0_r0;
wire [1:0] scan_in_addr_address_0_r1;
wire [3:0] scan_in_addr_lb_sel_0_r1;
wire scan_in_addr_enable_0_r1;
wire [1:0] scan_in_addr_address_0_r2;
wire [3:0] scan_in_addr_lb_sel_0_r2;
wire scan_in_addr_enable_0_r2;
wire [1:0] scan_in_addr_address_0_r3;
wire [3:0] scan_in_addr_lb_sel_0_r3;
wire scan_in_addr_enable_0_r3;
wire scan_in_addr_req_0;
wire [1:0] scan_in_addr_cmd_0;
wire scan_in_addr_ack_0;
wire [1:0] scan_in_addr_address_1_r0;
wire [3:0] scan_in_addr_lb_sel_1_r0;
wire scan_in_addr_enable_1_r0;
wire [1:0] scan_in_addr_address_1_r1;
wire [3:0] scan_in_addr_lb_sel_1_r1;
wire scan_in_addr_enable_1_r1;
wire [1:0] scan_in_addr_address_1_r2;
wire [3:0] scan_in_addr_lb_sel_1_r2;
wire scan_in_addr_enable_1_r2;
wire [1:0] scan_in_addr_address_1_r3;
wire [3:0] scan_in_addr_lb_sel_1_r3;
wire scan_in_addr_enable_1_r3;
wire scan_in_addr_req_1;
wire [1:0] scan_in_addr_cmd_1;
wire scan_in_addr_ack_1;
wire [1:0] scan_in_addr_address_2_r0;
wire [3:0] scan_in_addr_lb_sel_2_r0;
wire scan_in_addr_enable_2_r0;
wire [1:0] scan_in_addr_address_2_r1;
wire [3:0] scan_in_addr_lb_sel_2_r1;
wire scan_in_addr_enable_2_r1;
wire [1:0] scan_in_addr_address_2_r2;
wire [3:0] scan_in_addr_lb_sel_2_r2;
wire scan_in_addr_enable_2_r2;
wire [1:0] scan_in_addr_address_2_r3;
wire [3:0] scan_in_addr_lb_sel_2_r3;
wire scan_in_addr_enable_2_r3;
wire scan_in_addr_req_2;
wire [1:0] scan_in_addr_cmd_2;
wire scan_in_addr_ack_2;
wire [1:0] scan_in_addr_address_3_r0;
wire [3:0] scan_in_addr_lb_sel_3_r0;
wire scan_in_addr_enable_3_r0;
wire [1:0] scan_in_addr_address_3_r1;
wire [3:0] scan_in_addr_lb_sel_3_r1;
wire scan_in_addr_enable_3_r1;
wire [1:0] scan_in_addr_address_3_r2;
wire [3:0] scan_in_addr_lb_sel_3_r2;
wire scan_in_addr_enable_3_r2;
wire [1:0] scan_in_addr_address_3_r3;
wire [3:0] scan_in_addr_lb_sel_3_r3;
wire scan_in_addr_enable_3_r3;
wire scan_in_addr_req_3;
wire [1:0] scan_in_addr_cmd_3;
wire scan_in_addr_ack_3;
wire [6:0] scan_in_inst_0_data_0;
wire [6:0] scan_in_inst_1_data_0;
wire [6:0] scan_in_inst_2_data_0;
wire [6:0] scan_in_inst_3_data_0;
wire [6:0] scan_in_inst_4_data_0;
wire [6:0] scan_in_inst_5_data_0;
wire [6:0] scan_in_inst_6_data_0;
wire [6:0] scan_in_inst_7_data_0;
wire [6:0] scan_in_inst_8_data_0;
wire [6:0] scan_in_inst_9_data_0;
wire [6:0] scan_in_inst_10_data_0;
wire [6:0] scan_in_inst_11_data_0;
wire [6:0] scan_in_inst_12_data_0;
wire [6:0] scan_in_inst_13_data_0;
wire [6:0] scan_in_inst_14_data_0;
wire [6:0] scan_in_inst_15_data_0;
wire [6:0] scan_in_inst_16_data_0;
wire [6:0] scan_in_inst_17_data_0;
wire [6:0] scan_in_inst_18_data_0;
wire [6:0] scan_in_inst_19_data_0;
wire [6:0] scan_in_inst_20_data_0;
wire [6:0] scan_in_inst_21_data_0;
wire [6:0] scan_in_inst_22_data_0;
wire [6:0] scan_in_inst_23_data_0;
wire [6:0] scan_in_inst_24_data_0;
wire [6:0] scan_in_inst_25_data_0;
wire [6:0] scan_in_inst_26_data_0;
wire [6:0] scan_in_inst_27_data_0;
wire [6:0] scan_in_inst_28_data_0;
wire [6:0] scan_in_inst_29_data_0;
wire [6:0] scan_in_inst_30_data_0;
wire [6:0] scan_in_inst_31_data_0;
wire scan_in_inst_req_0;
wire [1:0] scan_in_inst_cmd_0;
wire scan_in_inst_ack_0;
wire [6:0] scan_in_inst_0_data_1;
wire [6:0] scan_in_inst_1_data_1;
wire [6:0] scan_in_inst_2_data_1;
wire [6:0] scan_in_inst_3_data_1;
wire [6:0] scan_in_inst_4_data_1;
wire [6:0] scan_in_inst_5_data_1;
wire [6:0] scan_in_inst_6_data_1;
wire [6:0] scan_in_inst_7_data_1;
wire [6:0] scan_in_inst_8_data_1;
wire [6:0] scan_in_inst_9_data_1;
wire [6:0] scan_in_inst_10_data_1;
wire [6:0] scan_in_inst_11_data_1;
wire [6:0] scan_in_inst_12_data_1;
wire [6:0] scan_in_inst_13_data_1;
wire [6:0] scan_in_inst_14_data_1;
wire [6:0] scan_in_inst_15_data_1;
wire [6:0] scan_in_inst_16_data_1;
wire [6:0] scan_in_inst_17_data_1;
wire [6:0] scan_in_inst_18_data_1;
wire [6:0] scan_in_inst_19_data_1;
wire [6:0] scan_in_inst_20_data_1;
wire [6:0] scan_in_inst_21_data_1;
wire [6:0] scan_in_inst_22_data_1;
wire [6:0] scan_in_inst_23_data_1;
wire [6:0] scan_in_inst_24_data_1;
wire [6:0] scan_in_inst_25_data_1;
wire [6:0] scan_in_inst_26_data_1;
wire [6:0] scan_in_inst_27_data_1;
wire [6:0] scan_in_inst_28_data_1;
wire [6:0] scan_in_inst_29_data_1;
wire [6:0] scan_in_inst_30_data_1;
wire [6:0] scan_in_inst_31_data_1;
wire scan_in_inst_req_1;
wire [1:0] scan_in_inst_cmd_1;
wire scan_in_inst_ack_1;
wire [6:0] scan_in_inst_0_data_2;
wire [6:0] scan_in_inst_1_data_2;
wire [6:0] scan_in_inst_2_data_2;
wire [6:0] scan_in_inst_3_data_2;
wire [6:0] scan_in_inst_4_data_2;
wire [6:0] scan_in_inst_5_data_2;
wire [6:0] scan_in_inst_6_data_2;
wire [6:0] scan_in_inst_7_data_2;
wire [6:0] scan_in_inst_8_data_2;
wire [6:0] scan_in_inst_9_data_2;
wire [6:0] scan_in_inst_10_data_2;
wire [6:0] scan_in_inst_11_data_2;
wire [6:0] scan_in_inst_12_data_2;
wire [6:0] scan_in_inst_13_data_2;
wire [6:0] scan_in_inst_14_data_2;
wire [6:0] scan_in_inst_15_data_2;
wire [6:0] scan_in_inst_16_data_2;
wire [6:0] scan_in_inst_17_data_2;
wire [6:0] scan_in_inst_18_data_2;
wire [6:0] scan_in_inst_19_data_2;
wire [6:0] scan_in_inst_20_data_2;
wire [6:0] scan_in_inst_21_data_2;
wire [6:0] scan_in_inst_22_data_2;
wire [6:0] scan_in_inst_23_data_2;
wire [6:0] scan_in_inst_24_data_2;
wire [6:0] scan_in_inst_25_data_2;
wire [6:0] scan_in_inst_26_data_2;
wire [6:0] scan_in_inst_27_data_2;
wire [6:0] scan_in_inst_28_data_2;
wire [6:0] scan_in_inst_29_data_2;
wire [6:0] scan_in_inst_30_data_2;
wire [6:0] scan_in_inst_31_data_2;
wire scan_in_inst_req_2;
wire [1:0] scan_in_inst_cmd_2;
wire scan_in_inst_ack_2;
wire [6:0] scan_in_inst_0_data_3;
wire [6:0] scan_in_inst_1_data_3;
wire [6:0] scan_in_inst_2_data_3;
wire [6:0] scan_in_inst_3_data_3;
wire [6:0] scan_in_inst_4_data_3;
wire [6:0] scan_in_inst_5_data_3;
wire [6:0] scan_in_inst_6_data_3;
wire [6:0] scan_in_inst_7_data_3;
wire [6:0] scan_in_inst_8_data_3;
wire [6:0] scan_in_inst_9_data_3;
wire [6:0] scan_in_inst_10_data_3;
wire [6:0] scan_in_inst_11_data_3;
wire [6:0] scan_in_inst_12_data_3;
wire [6:0] scan_in_inst_13_data_3;
wire [6:0] scan_in_inst_14_data_3;
wire [6:0] scan_in_inst_15_data_3;
wire [6:0] scan_in_inst_16_data_3;
wire [6:0] scan_in_inst_17_data_3;
wire [6:0] scan_in_inst_18_data_3;
wire [6:0] scan_in_inst_19_data_3;
wire [6:0] scan_in_inst_20_data_3;
wire [6:0] scan_in_inst_21_data_3;
wire [6:0] scan_in_inst_22_data_3;
wire [6:0] scan_in_inst_23_data_3;
wire [6:0] scan_in_inst_24_data_3;
wire [6:0] scan_in_inst_25_data_3;
wire [6:0] scan_in_inst_26_data_3;
wire [6:0] scan_in_inst_27_data_3;
wire [6:0] scan_in_inst_28_data_3;
wire [6:0] scan_in_inst_29_data_3;
wire [6:0] scan_in_inst_30_data_3;
wire [6:0] scan_in_inst_31_data_3;
wire scan_in_inst_req_3;
wire [1:0] scan_in_inst_cmd_3;
wire scan_in_inst_ack_3;
wire i2c_req;
wire [6:0] i2c_slave_address;
wire [1:0] i2c_burst_count_wr;
wire [1:0] i2c_burst_count_rd;
wire [7:0] i2c_wdata0;
wire [7:0] i2c_wdata1;
wire [7:0] i2c_wdata2;
wire [7:0] i2c_wdata3;
wire i2c_rd_wrn;
wire i2c_ack;
wire i2c_nack;
wire [7:0] i2c_rdata0;
wire [7:0] i2c_rdata1;
wire [7:0] i2c_rdata2;
wire [7:0] i2c_rdata3;
