#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Author: Erik Anderson
# Email: erik.francis.anderson@gmail.com
# Date: 02/11/2021
"""Docstring for module main"""

# Imports - standard library

# Imports - 3rd party packages
import serial
import time
import pyvisa
import matplotlib.pyplot as plt

# Imports - local source
from common.UARTDriver import *
from equipment.agilent3631a import Agilent3631A
from equipment.keithley2230 import Keithley2230
from equipment.keithley2400 import *

class SuperSwitchUARTDriver(UARTDriver):

    # Scan controller command mapping
    CMD_RST = "00"
    CMD_SI = "01"
    CMD_SO = "10"
    CMD_UPDATE = "11"

    def __init__(self):
        """Opens serial port and initializes supplies"""
        super(SuperSwitchUARTDriver, self).__init__(
            port="/dev/ttyUSB0",
            baudrate=256000,
            timeout=1,
            write_timeout=1,
            bytesize=serial.EIGHTBITS,
            rtscts=False,
            parity=serial.PARITY_NONE,
            stopbits=serial.STOPBITS_ONE)

    def str_invert_bit(self, bit):
        if bit == "1":
            return "0"
        else:
            return "1"

    #---------------------------------------------------------------------------
    # Inst basic methods
    #---------------------------------------------------------------------------

    def set_inst(self, chip_col: int, row: int, column: int, addr: int):
        """Writes to instruction register in FPGA.

        Parameters
        ----------
        chip_col: int
            The chiplet column you wish to write to (0 -> 3).
        row: int
            The row you wish to write to (0 -> 127)

        """
        # Check for valid input
        if column > 31 or column < 0:
            sys.exit("Invalid column number")
        if row > 31 or row < 0:
            sys.exit("Invalid column number")

        # Calculate instruction
        wdata = (row << 2) | addr
        self.write_register(f"INSTRUCTION_{chip_col}",
                            f"scan_in_inst_{column}_data_{chip_col}",
                            f"{wdata:b}")

    def scan_in_inst_chain(self, chip_col: int):
        """Just issues scan in cmd to instruction chain"""
        self.write_register(f"INSTRUCTION_{chip_col}",
                            f"scan_in_inst_cmd_{chip_col}",
                            self.CMD_SI)
        self.inst_request_transaction(chip_col)

    def scan_out_inst_chain(self, chip_col: int):
        """Just issues scan out cmd to instruction chain"""
        self.write_register(f"INSTRUCTION_{chip_col}",
                            f"scan_in_inst_cmd_{chip_col}",
                            self.CMD_SO)
        self.inst_request_transaction(chip_col)

    def inst_request_transaction(self, chip_col: int):
        req = self.str_invert_bit(self.read_register(f"INSTRUCTION_{chip_col}",
                                                     f"scan_in_inst_req_{chip_col}"))
        self.write_register(f"INSTRUCTION_{chip_col}",
                            f"scan_in_inst_req_{chip_col}",
                            req)
        ack = self.read_register(f"INSTRUCTION_{chip_col}",
                                 f"scan_in_inst_ack_{chip_col}")
        while(ack != req):
            time.sleep(0.1)
            ack = self.read_register(f"INSTRUCTION_{chip_col}", f"scan_in_inst_ack_{chip_col}")

    #---------------------------------------------------------------------------
    # Address basic methods
    #---------------------------------------------------------------------------

    def set_address(self, 
                    chip_row: int, 
                    chip_col: int, 
                    en: int = None, 
                    lb_sel: int = None, 
                    addr: int = None):
        """Sets address scan chain bits for specific chiplet.

        NOTE: This does not scan in the address bits. It simply sets the bits
        in the FPGA.  You will need to call 'scan_in_address_chain' on the
        appropraite chiplet column to get the bits actually written to the
        chip.

        Parameters
        ----------
        chip_row: int
            The chiplet row. Must be between 0 and 3.
        chip_col: int
            The chiplet column. Must be between 0 and 3.
        en: int, optional
            Single bit to enable the chiplet (i.e. enables HVNMOS chip wide).
            Must be either 0 or 1.
        lb_sel: int, optional
            Loopback select bits. This is 4 bits so must be between 0 and 15.
            Selects what signal is output on the scan out loopback IO.

            0       -> scan in inst 0
            1       -> scan in inst 1
            2       -> scan in inst 2
            3       -> scan in inst 3
            4       -> scan in inst 4
            5       -> scan in inst 5
            6       -> scan in inst 6
            7       -> scan in inst 7
            8-15    -> scan in loopback
        addr: int, optional
            2 bits to set the address of the chiplet. Must be between 0 and 3.

        """
        # Check for valid row/col
        if chip_row < 0 or chip_row > 3:
            raise Exception(f'Chip row {chip_row} not between 0 and 3.')
        if chip_col < 0 or chip_col > 3:
            raise Exception(f'Chip col {chip_col} not between 0 and 3.')

        # Check for valid enable
        if enable and (enable != 0 or enable != 1):
            raise Exception('Enable must be 1 or 0.')

        # Check for valid lb_sel
        if lb_sel and (lb_sel < 0 or lb_sel > 15):
            raise Exception('Loopback select must be between 0 and 15.')

        # Check for valid address
        if addr and (addr < 0 or addr > 3):
            raise Exception('Address must be between 0 and 3.')

        # Set address scan chain bits for chiplet (does not scan in)
        if en is not None:
            self.write_register(f"ADDRESS_{chip_col}",
                                f"scan_in_addr_enable_{chip_col}_r{chip_row}",
                                f"{en:01b}")
        if lb_sel is not None:
            self.write_register(f"ADDRESS_{chip_col}",
                                f"scan_in_addr_lb_sel_{chip_col}_r{chip_row}",
                                f"{lb_sel:04b}")
        if addr is not None:
            self.write_register(f"ADDRESS_{chip_col}",
                                f"scan_in_addr_address_{chip_col}_r{chip_row}",
                                f"{addr:02b}")

    def scan_in_address_chain(self, chip_col: int):
        """Just issues scan in cmd to address chain"""
        self.write_register(f"ADDRESS_{chip_col}",
                            f"scan_in_addr_cmd_{chip_col}",
                            self.CMD_SI)
        self.address_request_transaction(chip_col)

    def scan_out_address_chain(self, chip_col: int):
        """Just issues scan out cmd to address chain"""
        self.write_register(f"ADDRESS_{chip_col}",
                            f"scan_in_addr_cmd_{chip_col}",
                            self.CMD_SO)
        self.address_request_transaction(chip_col)

    def address_request_transaction(self, chip_col: int):
        req = self.str_invert_bit(self.read_register(f"ADDRESS_{chip_col}",
                                                     f"scan_in_addr_req_{chip_col}"))
        self.write_register(f"ADDRESS_{chip_col}",
                            f"scan_in_addr_req_{chip_col}",
                            req)
        ack = self.read_register(f"ADDRESS_{chip_col}",
                                 f"scan_in_addr_ack_{chip_col}")
        while(ack != req):
            time.sleep(0.1)
            ack = self.read_register(f"ADDRESS_{chip_col}",
                                     f"scan_in_addr_ack_{chip_col}")

    #---------------------------------------------------------------------------
    # Misc basic methods
    #---------------------------------------------------------------------------

    def reset_scan_chains(self, chip_col: int):
        """Uses address scan chain controller to reset chip scan chains"""
        self.write_register(f"ADDRESS_{chip_col}", f"scan_in_addr_cmd_{chip_col}", self.CMD_RST)
        self.address_request_transaction(chip_col) # Place in reset
        self.address_request_transaction(chip_col) # Take out of reset

    #---------------------------------------------------------------------------
    # Driver tests and more complicated routines
    #---------------------------------------------------------------------------

    def initialize_uart_memory(self):
        """Place design in reset and initialize all memory addresses"""
        print("# BEGIN INIT MEMORY #")
        self.write_register("RESET", "reset", "1")
        print(f"Field: Reset, Reg: reset, Read: {self.read_register('RESET', 'reset')}")
        for field_name, field in self._fields.items():
            for reg_name, reg in field["registers"].items():
                if field_name != "RESET" or reg_name != "reset":
                    if reg["write"]:
                        self.write_register(field_name, reg_name, "0")
                        rdata = self.read_register(field_name, reg_name)
                        print(f"Field: {field_name}, Reg: {reg_name}, Written: 0, Read: {rdata}")
                    else:
                        rdata = self.read_register(field_name, reg_name)
                        print(f"Field: {field_name}, Reg: {reg_name}, Read: {rdata}")
        self.write_register("RESET", "reset", "0")
        print(f"Field: Reset, Reg: reset, Read: {self.read_register('RESET', 'reset')}")
        print("# FINISH INIT MEMORY #")

    def initialize_keepers(self, chip_col: int, address: int):
        """Turns on all keepers by row then turns them off.

        Assumes that all chips in column have same address so that
        initialization is done faster (only have to loop through 32 rows
        instead of 128)
        """
        # Log start of keeper init
        print("# BEGIN INIT KEEPERS #")

        # Cycle through all rows
        for row in range(32):
            for column in range(32):
                self.write_inst(chip_col=chip_col, row=row, column=column, addr=address)
            print(f"Chiplet Column: {chip_col}, All columns actuate row: {row}")
            self.scan_in_inst_chain(chip_col=chip_col)

        # Get last row initialized (i.e. row 0 is "ON" after method completes)
        for column in range(32):
            self.write_inst(chip_col=chip_col, row=0, column=column, addr=address)
        print(f"Actuate row: 0")
        self.scan_in_inst_chain(chip_col=chip_col)

        # Log end of keeper init
        print("# FINISH INIT KEEPERS #")

if __name__ == '__main__':
    pass
