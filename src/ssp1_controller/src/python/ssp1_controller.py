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


class SSP1Controller(BaseChip):
    """This is the class for the full 128 x 128 SSP1 package."""

    def __init__(self,
                 uart_device: str,
                 uart_baudrate: int,
                 mm_gpib_str: str,
                 agilent3631a_gpib_str: str,
                 keithley2230_usb_str: str,
                 keithley2400_gpib_str: str,
                 scope_usb_str: str,
                 si570_ref_freq: float):
        super(SSP1Controller, self).__init__(uart_device=uart_device,
                                             uart_baudrate=uart_baudrate,
                                             mm_gpib_str=mm_gpib_str,
                                             scope_usb_str=scope_usb_str,
                                             si570_ref_freq=si570_ref_freq)

    def enable_chip(self):
        """Enables all 16 chips via address scan chains."""
        for col in range(4):
            for row in range(4):
                self.drv_uart.write_register(f"ADDRESS_{col}", f"scan_in_addr_enable_{col}_r{row}", "1")
            self.drv_uart.scan_in_address_chain(col)

    def disable_chip(self):
        """Disables all 16 chips via address scan chains."""
        for col in range(4):
            for row in range(4):
                self.drv_uart.write_register(f"ADDRESS_{col}", f"scan_in_addr_enable_{col}_r{row}", "0")
            self.drv_uart.scan_in_address_chain(col)
    
    def _initialize_keepers(self):
        """Initializes keeper cells for all 16 CMOS chiplets.

        This method is run after resetting scan chains and thus all addresses
        should be 0.
        """
        # Turn keepers on and then off
        for col in range(4):
            self.drv_uart.initialize_keepers(chip_col=col, address=0)

    def _initialize_addresses(self):
        """Programs in the initial addresses
        
        Sets the address of each chiplet to be equal to its row number. 4x4
        grid of chiplets shown below - row 0 col 0 is bottom left.
        
        3 3 3 3
        2 2 2 2
        1 1 1 1
        0 0 0 0

        """
        for col in range(4):
            for row in range(4):
                self.drv_uart.set_address(chip_row=row, 
                                          chip_col=col, 
                                          addr=row)
            self.drv_uart.scan_in_address_chain(col)

#class Chip:
#    
#    def __init__(self,
#                 uart_device: str,
#                 uart_baudrate: int,
#                 mm_gpib_str: str,
#                 scope_usb_str: str,
#                 si570_ref_freq: float):
#        """Chip contains everything needed to control and monitor the chip/package
#        :param uart_device: Path to USB device for UART communication
#        :param uart_baudrate: Speed at which UART is communicating in b/s
#        :param mm_gpib_str: GPIB string for HP3478A multimeter
#        :param si570_ref_freq: Ref frequency unique to FPGA being used
#        """
#        # Save vars
#        self._uart_device = uart_device
#        self._uart_baudrate = uart_baudrate
#        self._mm_gpib_str = mm_gpib_str
#        self._scope_usb_str = scope_usb_str 
#        self._si570_ref_freq = si570_ref_freq
#
#        # Create resource manager
#        self.rm = pyvisa.ResourceManager("@py")
#
#        # Open driver
#        self.drv_uart = SuperSwitchUARTDriver(device=uart_device,
#                                              baudrate=uart_baudrate)
#        self.drv_pwr = SuperSwitchSupplyDriver(self.rm)
#        self.scope = KeysightDSOX4104A(scope_usb_str, self.rm)
#
#        # Multimeter (MUST BE PLUGGED INTO HVDD FOR CURRENT MEASUREMENT)
#        self.drv_mm = HP3478A(self._mm_gpib_str, self.rm)
#        self.drv_mm.set_mode(MFunc.DC_CURRENT, verbose=True)
#
#        # Saved state
#        self._is_enabled = False
#        self._address = None
#
#        # Create UART-to-I2C link to Si570
#        self.clock = Si570_VC707_UART(self._si570_ref_freq, self.drv_uart)
#    
#    def turn_off(self):
#        """Turns off chip"""
#        for col in range(4):
#            for row in range(4):
#                self.drv_uart.write_register(f"ADDRESS_{col}", f"scan_in_addr_enable_{col}_r{row}", "0")
#            self.drv_uart.scan_in_address_chain(col)
#        self.drv_pwr.disable_supplies()
#
#    def close(self):
#        """Closes all drivers and turns off chip"""
#        self.turn_off()
#        self.drv_uart.close()
#    
#    def initialize_digital(self,
#                           freq: float,
#                           vdd: float,
#                           vddpst: float,
#                           vddh: float):
#        """Performs the first stage of initialization as follows:
#        1. Set si570 clock to specified frequency
#        2. Set vbb, hvss, hvdd, and hvboost to 0V (need to do this?)
#        3. Set vdd, vddpst, and vddh to specified values
#        4. Place chip in reset and write 0s to all UART-mapped registers
#        5. Issue reset command to scan controller to reset chip's scan chains
#        6. Loop through all addresses and verify address scan functionality
#        7. Program address with specified address
#        """
#        # Set si570 clock to specified frequency
#        hs_div, n1, rfreq = self.clock.get_closest_settings(freq)
#        if self.clock.set_output_frequency_raw(hs_div, n1, rfreq):
#            print(self.clock.get_string_config())
#        else:
#            print("Invalid frequency setting")
#            return False
#        time.sleep(1)
#
#        # Set vbb, hvss, hvdd, and hvboost to 0V (need to do this?)
#        self.drv_pwr.set_voltage("vbb", 0)
#        self.drv_pwr.set_voltage("hvboost", 0)
#        self.drv_pwr.set_voltage("hvdd", 0)
#        self.drv_pwr.set_voltage("hvss", 0)
#
#        # Set vdd, vddpst, and vddh to specified values
#        self.drv_pwr.set_voltage("vdd", vdd)
#        self.drv_pwr.set_voltage("vddpst", vddpst)
#        self.drv_pwr.set_voltage("vddh", vddh)
#
#        # Enable all supplies and wait for voltages to settle
#        self.drv_pwr.enable_supplies()
#        time.sleep(2)
#
#        # Init uart memory and reset chip scan chains
#        self.drv_uart.initialize_uart_memory()
#        self.drv_uart.write_register("USER", "shifter_oe", "1")
#        self.drv_uart.write_register("USER", "scan_cg_en", "1")
#
#        # Write leds
#        self.drv_uart.write_register("USER", "leds", "11001100")
#
#        # Pulse reset for scan chains (addr_rst)
#        self.drv_uart.reset_scan_chains()
#
#        # Loop through all addresses and verify address scan functionality
#        #for i in [3, 2, 1, 0]:
#        #    self.drv_uart.program_and_verify_address(i)
#        #self.drv_uart.program_and_verify_address(address)
#
#
#    #def loopback_test(self):
#    #    """Performs loopback test for all scan in chains
#    #    Currently does not test the Scan in loopback path
#    #    """
#    #    print("# BEGIN LOOPBACK SCAN TEST #")
#    #    test = True
#    #    for sel in range(8):
#    #        print(f"Loopback scan test: {sel}")
#    #        # Set loopback select
#    #        self.drv_uart.write_register("SCAN_IN_ADDRESS_DATA",
#    #                                     "scan_in_addr_lb_sel", f"{sel:04b}")
#    #        self.drv_uart.scan_in_address_chain()
#    #        # Write frame memory
#    #        unique_column = sel * 4
#    #        self.drv_uart.write_frame_memory_column_unique(
#    #            col=unique_column,
#    #            unique_row=0,
#    #            other_row=31,
#    #            address=self._address)
#    #        # Enable scan in instruction
#    #        self.drv_uart.write_register("SCAN_IN_INST_CTRL",
#    #                                     "scan_in_inst_valid", "1")
#    #        time.sleep(1)
#    #        # Disable scan in instruction
#    #        self.drv_uart.write_register("SCAN_IN_INST_CTRL",
#    #                                     "scan_in_inst_valid", "0")
#    #        # Check dummy scan data
#    #        data0 = self.drv_uart.read_register("SCAN_LOOPBACK_DATA",
#    #                                            "scan_loopback_data_0")
#    #        data1 = self.drv_uart.read_register("SCAN_LOOPBACK_DATA",
#    #                                            "scan_loopback_data_1")
#    #        data2 = self.drv_uart.read_register("SCAN_LOOPBACK_DATA",
#    #                                            "scan_loopback_data_2")
#    #        data3 = self.drv_uart.read_register("SCAN_LOOPBACK_DATA",
#    #                                            "scan_loopback_data_3")
#    #        data = data3 + data2 + data1 + data0
#    #        expected_other_data = f"{31:05b}{self._address:02b}"
#    #        expected_unique_data = f"{0:05b}{self._address:02b}"
#    #        expected_data = 3 * expected_other_data + expected_unique_data
#    #        test &= (expected_data == data)
#    #        print("Data:\t\t0b" + data)
#    #        print("Expected Data:\t0b" + expected_data)
#    #    if test:
#    #        print("[PASS] Loopback Scan Test")
#    #    else:
#    #        print("[FAIL] Loopback Scan Test")
#    #    print("# FINISH LOOPBACK SCAN TEST #")
#    #    return test
#
#    def initialize(self, freq, vdd, vddpst, vddh, hvdd, hvss, hvboost, vbb, address):
#        """Initializes and enables the chip for use
#        vddpst: Digital voltage (typical 1.8V) 
#        vddpst: IO voltage (1.8V <-> 5.0V) 
#        vddh: High VDD for low-voltage level shifter (typical 5.0V) 
#        hvdd: HVDD is set to hvdd + hvboost
#        hvss: HVSS is set to hvss + hvboost
#        vbb: VBB voltage (must be <= 0V)
#        hvboost: High voltage boost. Adds to both hvdd and hvss 
#        """
#        # Set frequency
#        hs_div, n1, rfreq = self.clock.get_closest_settings(freq)
#        if self.clock.set_output_frequency_raw(hs_div, n1, rfreq):
#            print(self.clock.get_string_config())
#        else:
#            print("Invalid frequency setting")
#            return False 
#        time.sleep(1)
#
#        # Ramp vdd, vddpst, vddh
#        self.drv_pwr.set_voltage("vdd", vdd)
#        self.drv_pwr.set_voltage("vddpst", vddpst)
#        self.drv_pwr.set_voltage("vddh", vddh)
#        self.drv_pwr.set_voltage("vbb", vbb)
#        self.drv_pwr.enable_supplies()
#        time.sleep(2)
#
#        # Init uart memory and reset chip scan chains
#        self.drv_uart.initialize_uart_memory()
#        self.drv_uart.write_register("USER", "shifter_oe_n", "0")
#        self.drv_uart.write_register("USER", "scan_cg_en", "1")
#        # Write leds
#        self.drv_uart.write_register("USER", "leds", "11001100")
#        # Pulse reset for scan chains (addr_rst)
#        for c in range(4):
#            self.drv_uart.reset_scan_chains(c)
#
#        # PROGRAM ADDRESS before high voltage ramp
#        for column in range(4):
#            print(f"Scanning in addresses for chiplet column {column}...")
#            for row in range(4):
#                self.drv_uart.write_register(f"ADDRESS_{column}", f"scan_in_addr_address_{column}_r{row}", f"{address:02b}")
#            self.drv_uart.scan_in_address_chain(column)
#
#        # Ramp high voltages
#        self.drv_pwr.set_voltage("hvboost", hvboost)
#        time.sleep(2)
#        self.drv_pwr.set_voltage("hvss", hvss)
#        self.drv_pwr.set_voltage("hvdd", hvdd)
#        print(f"HVSS: {hvss + hvboost}")
#        print(f"HVDD: {hvdd + hvboost}")
#
#        ## Loopback test
#        #print("Starting scan in loopback test...")
#        #proceed = False
#        #cont = input("Continue? (Y/n): ")
#        #if cont.lower() == "y":
#        #    proceed = True 
#        #while(proceed):
#        #    for c in range(4):
#        #        print(f"Scan in inst chiplet column {c}...")
#        #        self.drv_uart.write_inst(chip_col=c, row=31, column=0, addr=address)
#        #        self.drv_uart.write_inst(chip_col=c, row=31, column=1, addr=address)
#        #        self.drv_uart.write_inst(chip_col=c, row=31, column=2, addr=address)
#        #        self.drv_uart.write_inst(chip_col=c, row=31, column=3, addr=address)
#        #        self.drv_uart.scan_in_inst_chain(c)
#        #        print(f'Loopback {c}: {self.drv_uart.read_register("LOOPBACK", f"loopback_so_data_{c}")}')
#        #    cont = input("Scan in complete. Continue? (Y/n): ")
#        #    if cont.lower() == "y":
#        #        proceed = True 
#        #    else:
#        #        proceed = False
#        
#        # Initialize keepers for all chiplet columns
#        for cc in range(4):
#            self.drv_uart.initialize_keepers(chip_col=cc, address=address)
#
#        # TODO get enable stuff working
#        ## Initialize the keeper cells and enable chip
#        #self.drv_uart.initialize_keepers(address)
#        #self.drv_uart.write_register("ADDRESS", "scan_in_addr_enable", "1")
#        #self.drv_uart.scan_in_address_chain()
#        #self.drv_uart.scan_out_address_chain()
#        #print(f"Enable: 0b{self.drv_uart.read_register('ADDRESS', 'scan_out_addr_enable')}")
#        #print("# CHIP ENABLED #")
#        #self._is_enabled = True
#        
#        # TODO get HVDD current measurment working 
#        ## HVDD short on enable test
#        #short_on_enable_test = True
#        #measurements = []
#        #for i in range(5):
#        #    dpoint = self.drv_mm.get_measurement()
#        #    print(dpoint)
#        #    measurements.append(dpoint)
#        #if max(measurements) > 1e-3:
#        #    short_on_enable_test = False
#
#    def single_device_loop(self):
#        """Turn on a specific row-column pair one at a time"""
#        print("Starting single device loop test...")
#        proceed = False
#        cont = input("Continue? (Y/n): ")
#        if cont.lower() == "y":
#            proceed = True 
#        while(proceed):
#            row = int(input("Row: "))
#            column = int(input("Column: "))
#            addr = int(input("Address: "))
#            self.drv_uart.write_inst(row, column, addr)
#            self.drv_uart.scan_in_inst_chain()
#            print(f"Actuated Row {row} Column {column} Address {addr}")
#            cont = input("Continue? (Y/n): ")
#            if cont.lower() == "y":
#                proceed = True 
#            else:
#                proceed = False

if __name__ == '__main__':
    chip = Chip()
    chip.initialize()
    chip.close()
