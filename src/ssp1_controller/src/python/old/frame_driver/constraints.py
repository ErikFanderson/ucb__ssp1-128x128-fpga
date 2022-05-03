#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Author: Erik Anderson
# Email: v
# Date: 03/17/2021
"""Docstring for module constraints.py"""

# Imports - standard library

# Imports - 3rd party packages

# Imports - local source

def fp_round(num, mult = 1e8):
    return round(num * mult) / mult

def get_constraints(base_period: float, div_factor: int):
    div_period = fp_round(base_period * div_factor)
    one_quart_div = fp_round((1/4) * div_period)
    two_quart_div = fp_round((2/4) * div_period)
    three_quart_div = fp_round((3/4) * div_period)
    return f"""
# Any clock that is at the port level should be a primary clock! Port => top-level IO
implement.primary_clocks:
- name: "primary_clk_p"
  object: "i_clk_p"
  type: "port"
  period: {base_period} 
- name: "primary_clk_n"
  object: "i_clk_n"
  type: "port"
  period: {base_period} 
- name: "i_scan_clk_p"
  object: "i_scan_clk_p"
  type: "port"
  period: {div_period} 
  waveform: [0.0, {one_quart_div}]
- name: "i_scan_clk_n"
  object: "i_scan_clk_n"
  type: "port"
  period: {div_period} 
  waveform: [{two_quart_div}, {three_quart_div}]

# Uses hierarchical search on pins and nets... Do not include
# hierarchy! Hierarchichal search allows you to find pins in the 
# hierarchy but you specify just a single instance name and the pin name!
implement.generated_clocks:
- name: "clk_buffered"
  object: "IBUFGDS_inst/O"
  type: "pin"
  source: "i_clk_p"
  source_type: "port"
  divisor: 1
- name: "scan_clk_p"
  object: "sclk_gen_inst/o_scan_clk_p"
  type: "pin"
  source: "IBUFGDS_inst/O"
  source_type: "pin"
  edges: [1, {int((div_factor/2) + 1)}, {int(div_factor*2 + 1)}] # Pos edge is 1, neg edge is 2
  edge_shift: [0, 0, 0] # In ns
- name: "scan_clk_n"
  object: "sclk_gen_inst/o_scan_clk_n"
  type: "pin"
  source: "IBUFGDS_inst/O"
  source_type: "pin"
  edges: [1, {int((div_factor/2) + 1)}, {int(div_factor*2 + 1)}] # Pos edge is 1, neg edge is 2
  edge_shift: [{two_quart_div}, {two_quart_div}, {two_quart_div}] # In ns
- name: "i2c_clk"
  object: "i2c_clk_div/o_out_clk"
  type: "pin"
  source: "sclk_gen_inst/o_scan_clk_p"
  source_type: "pin"
  divisor: 40 

implement.input_delay_constraints:
- port: "i_scan_update"
  clock: "scan_clk_p"
  clock_edge: "rise"
  min_delay: {one_quart_div}
  max_delay: {one_quart_div}
- port: "i_scan_reset"
  clock: "scan_clk_p"
  clock_edge: "rise"
  min_delay: {one_quart_div}
  max_delay: {one_quart_div}
- port: "i_scan_en_inst"
  clock: "scan_clk_p"
  clock_edge: "rise"
  min_delay: {one_quart_div}
  max_delay: {one_quart_div}
- port: "i_scan_in_inst*"
  clock: "scan_clk_p"
  clock_edge: "rise"
  min_delay: {one_quart_div}
  max_delay: {one_quart_div}
- port: "i_scan_out_address*"
  clock: "scan_clk_p"
  clock_edge: "rise"
  min_delay: {one_quart_div}
  max_delay: {one_quart_div}
- port: "i_scan_en_address*"
  clock: "scan_clk_p"
  clock_edge: "rise"
  min_delay: {one_quart_div}
  max_delay: {one_quart_div}
- port: "i_scan_out_loopback*"
  clock: "scan_clk_p"
  clock_edge: "rise"
  min_delay: {one_quart_div}
  max_delay: {one_quart_div}
- port: "i_uart_*"
  clock: "scan_clk_p"
  clock_edge: "rise"
  min_delay: {one_quart_div}
  max_delay: {one_quart_div}

implement.output_delay_constraints:
- port: "o_scan_update"
  clock: "scan_clk_n"
  clock_edge: "rise"
  min_delay: {one_quart_div}
  max_delay: {one_quart_div}
- port: "o_scan_reset"
  clock: "scan_clk_p"
  clock_edge: "rise"
  min_delay: {one_quart_div}
  max_delay: {one_quart_div}
- port: "o_scan_en_inst"
  clock: "scan_clk_p"
  clock_edge: "fall"
  min_delay: {one_quart_div}
  max_delay: {one_quart_div}
- port: "o_scan_in_inst*"
  clock: "scan_clk_p"
  clock_edge: "fall"
  min_delay: {one_quart_div}
  max_delay: {one_quart_div}
- port: "o_scan_en_address"
  clock: "scan_clk_p"
  clock_edge: "fall"
  min_delay: {one_quart_div}
  max_delay: {one_quart_div}
- port: "o_scan_in_address"
  clock: "scan_clk_p"
  clock_edge: "fall"
  min_delay: {one_quart_div}
  max_delay: {one_quart_div}
- port: "o_scan_in_loopback"
  clock: "scan_clk_p"
  clock_edge: "fall"
  min_delay: {one_quart_div}
  max_delay: {one_quart_div}
- port: "o_uart_*"
  clock: "scan_clk_p"
  clock_edge: "rise"
  min_delay: {one_quart_div}
  max_delay: {one_quart_div}
- port: "o_led*"
  clock: "scan_clk_p"
  clock_edge: "rise"
  min_delay: {one_quart_div}
  max_delay: {one_quart_div}
"""

if __name__ == '__main__':
    # Basic generated
    for i in range(32):
        div_factor = (i + 1) * 4
        with open(f"../constraints_div{div_factor}.yml", "w") as fp:
            fp.write(get_constraints(5.0, div_factor))
    # With new I2C controlled clock 
