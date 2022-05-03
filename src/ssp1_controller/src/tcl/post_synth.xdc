# Because I used a negative clock in diff pair clock capable pin... See https://www.xilinx.com/support/answers/67599.html
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets i_scan_clk_n_IBUF]

# Because dummy scan seg uses i_scan_update as a clock for the config latch and the assigned pin is not "Clock Capable"
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets i_scan_update_IBUF]
