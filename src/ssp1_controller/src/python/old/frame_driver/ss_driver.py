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
from UARTDriver import * 
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

    #--------------------------------------------------------------------------
    # Inst methods
    #--------------------------------------------------------------------------
    
    def write_inst(self, row: int, column: int, addr: int = None):
        """Writes instruction for the specific row and column"""
        # Check for valid input
        if column > 31 or column < 0:
            sys.exit("Invalid column number")
        if row > 31 or row < 0:
            sys.exit("Invalid column number")
        # Calculate instruction
        my_addr = addr
        if my_addr is None:
            self.scan_out_address_chain()
            my_addr = int(self.read_register("SCAN_IN_ADDRESS_DATA", "scan_in_addr_address"), 2)
        wdata = (row << 2) | my_addr
        self.write_register(f"SCAN_IN_INST_DATA", f"scan_in_inst_{column}_data", f"{wdata:b}")
    
    def pulse_write_frame_valid(self):
        """Toggles instruction scan in valid pulse signal"""
        vpulse = self.read_register("SCAN_IN_INST_CTRL", "scan_in_write_frame_valid_pulse")
        self.write_register("SCAN_IN_INST_CTRL", "scan_in_write_frame_valid_pulse", f"{int(vpulse, 2) ^ 1:b}")
    
    #--------------------------------------------------------------------------
    # Address methods
    #--------------------------------------------------------------------------
    
    def reset_scan_chains(self):
        """Uses address scan chain controller to reset chip scan chains"""
        self.write_register("SCAN_IN_ADDRESS_CTRL", "scan_in_addr_cmd", self.CMD_RST)
        # Wait until ready
        while(self.read_register("SCAN_IN_ADDRESS_CTRL", "scan_in_addr_ready") != "1"):
            pass
        self.address_valid_pulse()
        # Wait until ready
        while(self.read_register("SCAN_IN_ADDRESS_CTRL", "scan_in_addr_ready") != "1"):
            pass
        self.address_valid_pulse()

    def scan_in_address_chain(self):
        """Just issues scan in cmd to address chain"""
        self.write_register("SCAN_IN_ADDRESS_CTRL", "scan_in_addr_cmd", self.CMD_SI)
        # Wait until ready
        while(self.read_register("SCAN_IN_ADDRESS_CTRL", "scan_in_addr_ready") != "1"):
            pass
        self.address_valid_pulse()
    
    def scan_out_address_chain(self):
        """Just issues scan out cmd to address chain"""
        self.write_register("SCAN_IN_ADDRESS_CTRL", "scan_in_addr_cmd", self.CMD_SO)
        # Wait until ready
        while(self.read_register("SCAN_IN_ADDRESS_CTRL", "scan_in_addr_ready") != "1"):
            pass
        self.address_valid_pulse()
    
    def address_valid_pulse(self):
        """Toggles address scan in valid pulse signal"""
        vpulse = self.read_register("SCAN_IN_ADDRESS_CTRL", "scan_in_addr_valid_pulse")
        self.write_register("SCAN_IN_ADDRESS_CTRL", "scan_in_addr_valid_pulse", f"{int(vpulse, 2) ^ 1:b}")
    
    #--------------------------------------------------------------------------
    # Driver tests and more complicated routines 
    #--------------------------------------------------------------------------
   
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
    
    #--------------------------------------------------------------------------
    # Frame patterns 
    #--------------------------------------------------------------------------

    def write_frame_memory_init_pattern(self, address: int):
        """Writes the init pattern for initializing keeper cells to the frame memory"""
        print("# BEGIN WRITE FRAME MEMORY #")
        # Cycle through all rows
        for row in range(32):
            for column in range(32):
                self.write_inst(row=row, column=column, addr=address)
            self.write_register("SCAN_IN_INST_CTRL", "scan_in_write_frame_address", f"{row:b}")
            self.pulse_write_frame_valid()
            print(f"Frame [{row}], All columns actuate row [{row}]")
        print("# FINISH WRITE FRAME MEMORY #")

    def write_frame_memory_single(self, row: int, address: int):
        """Write same row for all columns and all frames"""
        for frame in range(32):
            for column in range(32):
                self.write_inst(row=row, column=column, addr=address)
            self.write_register("SCAN_IN_INST_CTRL", "scan_in_write_frame_address", f"{frame:b}")
            self.pulse_write_frame_valid()

    def write_frame_memory_offset_pattern(self, address: int):
        """Offset pattern such that no column actuates same row AND 
        every column actuates a new row in each frame
        """
        for frame in range(32):
            for column in range(32):
                self.write_inst(row=(frame + column) % 32, column=column, addr=address)
            self.write_register("SCAN_IN_INST_CTRL", "scan_in_write_frame_address", f"{frame:b}")
            self.pulse_write_frame_valid()
    
    def write_frame_memory_update_every_4(self, address: int):
        """Phase 1 pattern (new row every 4 frames) for measuring VDD current/power"""
        # 8 unique frames
        for frame in range(8):
            for column in range(32):
                self.write_inst(row=frame, column=column, addr=address)
            for i in range(4):
                frame_addr = (frame * 4) + i
                self.write_register("SCAN_IN_INST_CTRL", "scan_in_write_frame_address", f"{frame_addr:b}")
                self.pulse_write_frame_valid()
    
    def write_frame_memory_update_every_8(self, address: int):
        """Phase 2 pattern (new row every 8 frames) for measuring VDD current/power"""
        # 4 unique frames
        for frame in range(4):
            for column in range(32):
                self.write_inst(row=frame, column=column, addr=address)
            for i in range(8):
                frame_addr = (frame * 4) + i
                self.write_register("SCAN_IN_INST_CTRL", "scan_in_write_frame_address", f"{frame_addr:b}")
                self.pulse_write_frame_valid()
    
    def write_frame_memory_update_every_16(self, address: int):
        """Phase 2 pattern (new row every 8 frames) for measuring VDD current/power"""
        # 4 unique frames
        for frame in range(2):
            for column in range(32):
                self.write_inst(row=frame, column=column, addr=address)
            for i in range(16):
                frame_addr = (frame * 4) + i
                self.write_register("SCAN_IN_INST_CTRL", "scan_in_write_frame_address", f"{frame_addr:b}")
                self.pulse_write_frame_valid()
    
    def write_frame_memory_column_unique(self, col: int, unique_row: int, other_row: int, address: int):
        """Writes fram memory such that one column has 1 unique row 
        and the other columns have other_row
        """
        for frame in range(32):
            for column in range(32):
                if column == col:
                    self.write_inst(row=unique_row, column=column, addr=address)
                else:
                    self.write_inst(row=other_row, column=column, addr=address)
            self.write_register("SCAN_IN_INST_CTRL", "scan_in_write_frame_address", f"{frame:b}")
            self.pulse_write_frame_valid()


if __name__ == '__main__':
    pass
