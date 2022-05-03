#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Author: Erik Anderson
# Email: erik.francis.anderson@gmail.com
# Date: 02/11/2021
"""Docstring for module main"""

# Imports - standard library
import atexit
import os
import sys
import random

# Imports - 3rd party packages
import pyvisa
import serial
import time

# Imports - local source
from ss_driver import *
from ssp1_fpga.power_driver import *
from equipment.agilent3631a import Agilent3631A
from equipment.keithley2230 import Keithley2230
from equipment.hp3478a import *
from equipment.si570 import *
from ssp1_fpga.si570_vc707_uart import *


class SSP1WB4x4(BaseChip):
    """This is the class for the full 4x4 wire bond SSP1 package.

    This package contains 1 CMOS chiplet connected to the chiplet column 0 scan
    interface. The 128x128 package does not connect any of the 'south' side
    connections to the CMOS chiplets. This means that by default these packages
    do not have connections to the scan out address. To allow for testing of
    the scan out address, this package connects the FPGA pin originally
    intended for chiplet column 0 scan out loopback to the CMOS chiplet's scan
    out address. The rest of the connections are made through chiplet column
    1's scan interface.

    Connections
    -----------
    Chiplet column 1 scan interface
    scan out address of CMOS connected to chiplet column 0 scan out loopback

    """

    def __init__(self,
                 uart_device: str,
                 uart_baudrate: int,
                 mm_gpib_str: str,
                 scope_usb_str: str,
                 si570_ref_freq: float):
        super(SSP1WB4x4, self).__init__(uart_device=uart_device,
                                        uart_baudrate=uart_baudrate,
                                        mm_gpib_str=mm_gpib_str,
                                        scope_usb_str=scope_usb_str,
                                        si570_ref_freq=si570_ref_freq)

    def enable_chip(self):
        """Enables single chip via address scan chain.

        Chip is located at chiplet column 1 row 3
        """
        self.drv_uart.write_register(f"ADDRESS_1", f"scan_in_addr_enable_1_r3", "1")
        self.drv_uart.scan_in_address_chain(1)

    def disable_chip(self):
        """Disables single chip via address scan chain.

        Chip is located at chiplet column 1 row 3
        """
        self.drv_uart.write_register(f"ADDRESS_1", f"scan_in_addr_enable_1_r3", "0")
        self.drv_uart.scan_in_address_chain(1)

    def _initialize_keepers(self):
        """Initializes keeper cells for single CMOS chiplet in package.

        This method is run after resetting scan chains and thus all addresses
        should be 0.
        """
        # Turn keepers on and then off
        self.drv_uart.initialize_keepers(chip_col=1, address=0)

    def _initialize_addresses(self):
        """Programs in the initial addresses.

        Sets the single address to be 3 (same as what it would be in full SSP1)

        """
        self.write_address_chain(addr=3)

    def write_address_chain(self, en = None, lb_sel = None, addr = None):
        self.drv_uart.set_address(chip_row=3, chip_col=1, en=en, lb_sel=lb_sel, addr=addr)
        self.drv_uart.scan_in_address_chain(1)

    # TODO Actually I think it's impossible to read address through address scan out...
    # We would have to modify the FPGA code so that scan out loopback is read while address
    # scan in happens...
    def read_address_chain(self, addr):
        """Need to use column 0 scan out loopback as scan address"""
        
        self.drv_uart.scan_out_address_chain(1)
        self.drv_uart.read_register('LOOPBACK', 'loopback_so_data_0')

    #def program_and_verify_address(self, address):
    #    """Scans in address and then scans out to verify that it was successful"""
    #    # Scan in address
    #    self.write_register("ADDRESS", "scan_in_addr_address", f"{address:02b}")
    #    self.scan_in_address_chain()
    #
    #    # Scan out address
    #    self.scan_out_address_chain()
    #
    #    # Read scan out mem
    #    en = self.read_register("ADDRESS", "scan_out_addr_enable")
    #    sel = self.read_register("ADDRESS", "scan_out_addr_lb_sel")
    #    addr = self.read_register("ADDRESS", "scan_out_addr_address")
    #    print(f"[scan out data] Enable: {en}, LB Select: {int(sel, 2)}, Address: {int(addr, 2)}")
    #    if int(addr, 2) != address:
    #        return False
    #    self._address = address
    #    return True

    #def write_mems_switch(self, row: int, column: int, on: bool):
    #    """Turns a switch cell on for the MEMS 4x4 switch
    #    :param row: Integer from [0, 1, 2, 3]
    #    :param column: Integer from [0, 1, 2, 3]
    #    :param on: True => Turn on, False => Turn off
    #    """
    #    cmos_columns = [0, 1, 3, 5, 7, 9, 11, 13, 18, 20, 22, 24, 26, 28, 29, 30]
    #    mems_id = (column * 4) + row
    #    cmos_column = cmos_columns[mems_id]
    #
    #    if on:
    #        self.write_inst(row=0, column=cmos_column)
    #    else:
    #        self.write_inst(row=0, column=cmos_column, addr=0)
    #    self.scan_in_inst_chain()
