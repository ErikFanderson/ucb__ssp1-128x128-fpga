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
from si570_vc707_uart import *


class Chip:
    def __init__(self):
        # Create resource manager
        self.rm = pyvisa.ResourceManager("@py")
        # Open driver
        self.drv_uart = SuperSwitchUARTDriver()
        self.drv_pwr = SuperSwitchSupplyDriver(self.rm)
        # Multimeter (MUST BE PLUGGED INTO HVDD FOR CURRENT MEASUREMENT)
        self.drv_mm = HP3478A("GPIB0::23::INSTR", self.rm)
        self.drv_mm.set_mode(MFunc.DC_CURRENT, verbose=True)
        # Saved state
        self._is_enabled = False
        self._address = None
        self.clock = Si570_VC707_UART(114284672.05569899, self.drv_uart)

    def full_test(self, freq, vdd, vddpst, vddh, hvdd, hvss, hvboost, vbb,
                  address):
        """Turns on chip, runs all tests, turns off chip and returns result of all tests"""
        test = False
        print(
            f"Full test: (Frequency: {freq}, VDD: {vdd}, VDDPST: {vddpst}, VDDH: {vddh}, HVDD: {hvdd}, HVSS: {hvss}, HVBOOST: {hvboost}, VBB: {vbb}, Address: {address})"
        )
        # Run test
        init_test = self.initialize(freq=freq,
                                    vdd=vdd,
                                    vddpst=vddpst,
                                    vddh=vddh,
                                    hvdd=hvdd,
                                    hvss=hvss,
                                    hvboost=hvboost,
                                    vbb=vbb,
                                    address=address)
        if init_test:
            dummy_test = self.dummy_scan_segment_test()
            loopback_test = self.loopback_test()
            test = init_test & dummy_test & loopback_test
        self.turn_off()
        return test

    def turn_off(self):
        """Turns off chip"""
        self.drv_uart.write_register("SCAN_IN_INST_CTRL", "scan_in_inst_valid",
                                     "0")
        self.drv_uart.write_register("SCAN_IN_ADDRESS_DATA",
                                     "scan_in_addr_enable", "0")
        self.drv_uart.scan_in_address_chain()
        self.drv_pwr.disable_supplies()

    def close(self):
        """Closes all drivers and turns off chip"""
        self.turn_off()
        self.drv_uart.close()

    def program_and_verify_address(self, address):
        """Scans in address and then scans out to verify that it was successful"""
        # Scan in address
        self.drv_uart.write_register("SCAN_IN_ADDRESS_DATA",
                                     "scan_in_addr_address", f"{address:02b}")
        self.drv_uart.scan_in_address_chain()
        # Scan out address
        self.drv_uart.scan_out_address_chain()
        # Read scan out mem
        en = self.drv_uart.read_register("SCAN_OUT_ADDRESS_DATA",
                                         "scan_out_addr_enable")
        sel = self.drv_uart.read_register("SCAN_OUT_ADDRESS_DATA",
                                          "scan_out_addr_lb_sel")
        addr = self.drv_uart.read_register("SCAN_OUT_ADDRESS_DATA",
                                           "scan_out_addr_address")
        print(
            f"[scan out data] Enable: {en}, LB Select: {int(sel, 2)}, Address: {int(addr, 2)}"
        )
        if int(addr, 2) != address:
            return False
        self._address = address
        return True

    def dummy_scan_segment_test(self):
        """Runs a loopback test"""
        print("# BEGIN DUMMY SCAN TEST #")
        test = True
        for scan in range(8):
            print(f"Dummy scan test: {scan}")
            # Write frame memory
            unique_column = scan * 4
            self.drv_uart.write_frame_memory_column_unique(
                col=unique_column,
                unique_row=0,
                other_row=31,
                address=self._address)
            # Set dummy scan in
            self.drv_uart.write_register("DUMMY_SCAN_SEG_SEL",
                                         "dummy_scan_seg_sel", f"{scan:03b}")
            # Enable scan in instruction
            self.drv_uart.write_register("SCAN_IN_INST_CTRL",
                                         "scan_in_inst_valid", "1")
            time.sleep(1)
            # Disable scan in instruction
            self.drv_uart.write_register("SCAN_IN_INST_CTRL",
                                         "scan_in_inst_valid", "0")
            # Check dummy scan data
            data0 = self.drv_uart.read_register("DUMMY_SCAN_SEG_OUT",
                                                "dummy_scan_seg_out_0")
            data1 = self.drv_uart.read_register("DUMMY_SCAN_SEG_OUT",
                                                "dummy_scan_seg_out_1")
            data2 = self.drv_uart.read_register("DUMMY_SCAN_SEG_OUT",
                                                "dummy_scan_seg_out_2")
            data3 = self.drv_uart.read_register("DUMMY_SCAN_SEG_OUT",
                                                "dummy_scan_seg_out_3")
            data = data3 + data2 + data1 + data0
            expected_other_data = f"{31:05b}{self._address:02b}"
            expected_unique_data = f"{0:05b}{self._address:02b}"
            expected_data = 3 * expected_other_data + expected_unique_data
            test &= (expected_data == data)
            print("Data:\t\t0b" + data)
            print("Expected Data:\t0b" + expected_data)
        if test:
            print("[PASS] Dummy Scan Test")
        else:
            print("[FAIL] Dummy Scan Test")
        print("# FINISH DUMMY SCAN TEST #")
        return test

    def loopback_test(self):
        """Performs loopback test for all scan in chains
        Currently does not test the Scan in loopback path
        """
        print("# BEGIN LOOPBACK SCAN TEST #")
        test = True
        for sel in range(8):
            print(f"Loopback scan test: {sel}")
            # Set loopback select
            self.drv_uart.write_register("SCAN_IN_ADDRESS_DATA",
                                         "scan_in_addr_lb_sel", f"{sel:04b}")
            self.drv_uart.scan_in_address_chain()
            # Write frame memory
            unique_column = sel * 4
            self.drv_uart.write_frame_memory_column_unique(
                col=unique_column,
                unique_row=0,
                other_row=31,
                address=self._address)
            # Enable scan in instruction
            self.drv_uart.write_register("SCAN_IN_INST_CTRL",
                                         "scan_in_inst_valid", "1")
            time.sleep(1)
            # Disable scan in instruction
            self.drv_uart.write_register("SCAN_IN_INST_CTRL",
                                         "scan_in_inst_valid", "0")
            # Check dummy scan data
            data0 = self.drv_uart.read_register("SCAN_LOOPBACK_DATA",
                                                "scan_loopback_data_0")
            data1 = self.drv_uart.read_register("SCAN_LOOPBACK_DATA",
                                                "scan_loopback_data_1")
            data2 = self.drv_uart.read_register("SCAN_LOOPBACK_DATA",
                                                "scan_loopback_data_2")
            data3 = self.drv_uart.read_register("SCAN_LOOPBACK_DATA",
                                                "scan_loopback_data_3")
            data = data3 + data2 + data1 + data0
            expected_other_data = f"{31:05b}{self._address:02b}"
            expected_unique_data = f"{0:05b}{self._address:02b}"
            expected_data = 3 * expected_other_data + expected_unique_data
            test &= (expected_data == data)
            print("Data:\t\t0b" + data)
            print("Expected Data:\t0b" + expected_data)
        if test:
            print("[PASS] Loopback Scan Test")
        else:
            print("[FAIL] Loopback Scan Test")
        print("# FINISH LOOPBACK SCAN TEST #")
        return test

    def initialize(self, freq, vdd, vddpst, vddh, hvdd, hvss, hvboost, vbb,
                   address):
        """Initializes and enables the chip for use
        vddpst: Digital voltage (typical 1.8V) 
        vddpst: IO voltage (1.8V <-> 5.0V) 
        vddh: High VDD for low-voltage level shifter (typical 5.0V) 
        hvdd: HVDD is set to hvdd + hvboost
        hvss: HVSS is set to hvss + hvboost
        vbb: VBB voltage (must be <= 0V)
        hvboost: High voltage boost. Adds to both hvdd and hvss 
        """
        # Set frequency
        hs_div, n1, rfreq = self.clock.get_closest_settings(freq)
        if self.clock.set_output_frequency_raw(hs_div, n1, rfreq):
            print(self.clock.get_string_config())
        else:
            print("Invalid frequency setting")
            return False 
        time.sleep(1)

        # Ramp vdd, vddpst, vddh
        self.drv_pwr.set_voltage("vdd", vdd)
        self.drv_pwr.set_voltage("vddpst", vddpst)
        self.drv_pwr.set_voltage("vddh", vddh)
        self.drv_pwr.set_voltage("vbb", vbb)
        self.drv_pwr.enable_supplies()
        time.sleep(2)

        # Init uart memory and reset chip scan chains
        self.drv_uart.initialize_uart_memory()
        self.drv_uart.write_register("USER", "shifter_oe_n", "0")
        self.drv_uart.write_register("USER", "scan_cg_en", "1")
        # Write leds
        self.drv_uart.write_register("USER", "leds", "11001100")
        # Pulse reset for scan chains (addr_rst)
        self.drv_uart.reset_scan_chains()
        # Keep ready high for scan out controllers
        self.drv_uart.write_register("SCAN_OUT_ADDRESS_CTRL",
                                     "scan_out_addr_ready", "1")
        self.drv_uart.write_register("SCAN_LOOPBACK_CTRL",
                                     "scan_loopback_ready", "1")

        # PROGRAM ADDRESS before high voltage ramp
        pre_hvramp_address_test = self.program_and_verify_address(3)
        pre_hvramp_address_test &= self.program_and_verify_address(2)
        pre_hvramp_address_test &= self.program_and_verify_address(1)
        pre_hvramp_address_test &= self.program_and_verify_address(0)
        pre_hvramp_address_test &= self.program_and_verify_address(address)

        # Ramp high voltages
        self.drv_pwr.set_voltage("hvboost", hvboost)
        time.sleep(2)
        self.drv_pwr.set_voltage("hvss", hvss)
        self.drv_pwr.set_voltage("hvdd", hvdd)
        print(f"HVSS: {hvss + hvboost}")
        print(f"HVDD: {hvdd + hvboost}")

        # PROGRAM ADDRESS after high voltage ramp
        post_hvramp_address_test = self.program_and_verify_address(3)
        post_hvramp_address_test &= self.program_and_verify_address(2)
        post_hvramp_address_test &= self.program_and_verify_address(1)
        post_hvramp_address_test &= self.program_and_verify_address(0)
        post_hvramp_address_test &= self.program_and_verify_address(address)

        # Initialize the keeper cells and enable chip
        # Write to frame memory and scan in to initialize keepers
        self.drv_uart.write_frame_memory_init_pattern(address=address)
        print("Begin initializing...")
        self.drv_uart.write_register("SCAN_IN_INST_CTRL", "scan_in_inst_valid",
                                     "1")
        time.sleep(1)
        print("Finish initializing...")
        self.drv_uart.write_register("SCAN_IN_INST_CTRL", "scan_in_inst_valid",
                                     "0")
        self.drv_uart.write_register("SCAN_IN_ADDRESS_DATA",
                                     "scan_in_addr_enable", "1")
        self.drv_uart.scan_in_address_chain()
        print("# CHIP ENABLED #")
        self._is_enabled = True

        # HVDD short on enable test
        short_on_enable_test = True
        measurements = []
        for i in range(5):
            dpoint = self.drv_mm.get_measurement()
            print(dpoint)
            measurements.append(dpoint)
        if max(measurements) > 1e-3:
            short_on_enable_test = False

        # Test summary
        if pre_hvramp_address_test:
            print("[PASS] Pre-HVRamp Address Scan Test")
        else:
            print("[FAIL] Pre-HVRamp Address Scan Test")
        if post_hvramp_address_test:
            print("[PASS] Post-HVRamp Address Scan Test")
        else:
            print("[FAIL] Post-HVRamp Address Scan Test")
        if short_on_enable_test:
            print("[PASS] Short On Enable Test")
        else:
            print("[FAIL] Short On Enable Test")
        return pre_hvramp_address_test & post_hvramp_address_test & short_on_enable_test

    #--------------------------------------------------------------------------
    # Supply operational zone tests
    #--------------------------------------------------------------------------

    def vdd_test(self,
                 dirname,
                 vdd_list,
                 freq_list,
                 vddpst=5.0,
                 vddh=5.0,
                 hvdd=3.0,
                 hvss=0.0,
                 hvboost=67.0,
                 vbb=0.0,
                 address=3):
        """Outputs log for every individual test AND csv with summary"""
        # Create dir
        try:
            os.makedirs(dirname)
        except FileExistsError:
            print(f'Directory "{dirname}" already exists.')
        # Save stdout
        original_stdout = sys.stdout
        # run test
        test_results = {}
        for i, vdd in enumerate(vdd_list):
            test_results[str(i)] = {}
            for j, freq in enumerate(freq_list):
                with open(os.path.join(dirname, f"vdd_{i}_freq_{j}.txt"),
                          "w") as fp:
                    sys.stdout = original_stdout
                    print(
                        f"(VDD {i}/{len(vdd_list) - 1}: {vdd} [V], Frequency {j}/{len(freq_list) - 1}: {freq * 1e-6} [MHz]) Test in progress..."
                    )
                    sys.stdout = fp
                    test = self.full_test(freq=freq,
                                          vdd=vdd,
                                          vddpst=vddpst,
                                          vddh=vddh,
                                          hvdd=hvdd,
                                          hvss=hvss,
                                          hvboost=hvboost,
                                          vbb=vbb,
                                          address=address)
                    test_results[str(i)][str(j)] = test
        # Reset stdout
        sys.stdout = original_stdout
        # Write summary file
        self.supply_test_output_results(dirname, "vdd", vdd_list, freq_list,
                                        test_results)

    def vddpst_test(self,
                    dirname,
                    vddpst_list,
                    freq_list,
                    vdd=1.8,
                    vddh=5.0,
                    hvdd=3.0,
                    hvss=0.0,
                    hvboost=67.0,
                    vbb=0.0,
                    address=3):
        """Outputs log for every individual test AND csv with summary"""
        # Create dir
        try:
            os.makedirs(dirname)
        except FileExistsError:
            print(f'Directory "{dirname}" already exists.')
        # Save stdout
        original_stdout = sys.stdout
        # run test
        test_results = {}
        for i, vddpst in enumerate(vddpst_list):
            test_results[str(i)] = {}
            for j, freq in enumerate(freq_list):
                with open(os.path.join(dirname, f"vddpst_{i}_freq_{j}.txt"),
                          "w") as fp:
                    sys.stdout = original_stdout
                    print(
                        f"(VDDPST {i}/{len(vddpst_list) - 1}: {vddpst} [V], Frequency {j}/{len(freq_list) - 1}: {freq * 1e-6} [MHz]) Test in progress..."
                    )
                    sys.stdout = fp
                    test = self.full_test(freq=freq,
                                          vdd=vdd,
                                          vddpst=vddpst,
                                          vddh=vddh,
                                          hvdd=hvdd,
                                          hvss=hvss,
                                          hvboost=hvboost,
                                          vbb=vbb,
                                          address=address)
                    test_results[str(i)][str(j)] = test
        # Reset stdout
        sys.stdout = original_stdout
        # Write summary file
        self.supply_test_output_results(dirname, "vddpst", vddpst_list,
                                        freq_list, test_results)

    def supply_test_output_results(self, dirname, supply_name, vdd_list,
                                   freq_list, test_results):
        """Test results are indexed by [i][j] where i indexes vdd and j indexes frequency"""
        # Write summary file
        with open(os.path.join(dirname, f"summary.csv"), "w") as fp:
            fp.write(f"frequency,{supply_name},pass\n")
            for i, vdd in enumerate(vdd_list):
                for j, freq in enumerate(freq_list):
                    fp.write(f"{freq},{vdd},{test_results[str(i)][str(j)]}\n")
        # Print summary file
        for i, vdd in enumerate(vdd_list):
            for j, freq in enumerate(freq_list):
                if test_results[str(i)][str(j)]:
                    print(
                        f"[PASS] Full test w/ {supply_name.upper()} = {vdd} and Frequency = {freq*1e-6} [MHz]"
                    )
                else:
                    print(
                        f"[FAIL] Full test w/ {supply_name.upper()} = {vdd} and Frequency = {freq*1e-6} [MHz]"
                    )
    
    #--------------------------------------------------------------------------
    # Current measurment methods (TODO make these for any supply not just VDD)
    #--------------------------------------------------------------------------

    def current_test(self, pattern_func, ofname, freq, vdd, vddpst, vddh, hvdd,
                   hvss, hvboost, vbb, address):
        """records current of whatever supply is fed through the DMM"""
        # Initialize chip
        init_test = self.initialize(freq=freq,
                                    vdd=vdd,
                                    vddpst=vddpst,
                                    vddh=vddh,
                                    hvdd=hvdd,
                                    hvss=hvss,
                                    hvboost=hvboost,
                                    vbb=vbb,
                                    address=address)
        # Program frame memory
        pattern_func(address)
        # Enable scan in
        self.drv_uart.write_register("SCAN_IN_INST_CTRL", "scan_in_inst_valid", "1")
        # Measure power
        data = []
        for i in range(5):
            self.drv_mm.get_measurement()
        for i in range(100):
            print(f"Sample [{i+1}/100]")
            data.append(self.drv_mm.get_measurement())
        # Disable scan in
        self.drv_uart.write_register("SCAN_IN_INST_CTRL", "scan_in_inst_valid", "0")
        # Turn off chip
        self.turn_off()
        # Write data to file
        with open(ofname, "w") as fp:
            fp.write(f"Frequency: {freq}, VDD: {vdd}, VDDPST: {vddpst}, VDDH: {vddh}, HVDD: {hvdd}, HVSS: {hvss}, HVBOOSt: {hvboost}, VBB: {vbb}, Address: {address}\n")
            fp.write("sample,current\n")
            for i, dat in enumerate(data):
                fp.write(f"{i},{dat}\n")

    def current_test_full_pattern(self, ofname, freq, vdd, vddpst, vddh, hvdd,
                                hvss, hvboost, vbb, address):
        """records current of whatever supply is fed through the DMM. Uses pattern that updates row every frame"""
        self.current_test(self.drv_uart.write_frame_memory_offset_pattern,
                   ofname=ofname,
                   freq=freq,
                   vdd=vdd,
                   vddpst=vddpst,
                   vddh=vddh,
                   hvdd=hvdd,
                   hvss=hvss,
                   hvboost=hvboost,
                   vbb=vbb,
                   address=address)
    
    def current_test_update_every_4(self, ofname, freq, vdd, vddpst, vddh, hvdd,
                                hvss, hvboost, vbb, address):
        """records current of whatever supply is fed through the DMM. Uses phase 1 pattern"""
        self.current_test(self.drv_uart.write_frame_memory_update_every_4,
                   ofname=ofname,
                   freq=freq,
                   vdd=vdd,
                   vddpst=vddpst,
                   vddh=vddh,
                   hvdd=hvdd,
                   hvss=hvss,
                   hvboost=hvboost,
                   vbb=vbb,
                   address=address)
    
    def current_test_update_every_8(self, ofname, freq, vdd, vddpst, vddh, hvdd,
                                hvss, hvboost, vbb, address):
        """records current of whatever supply is fed through the DMM. Uses phase 2 pattern"""
        self.current_test(self.drv_uart.write_frame_memory_update_every_8,
                   ofname=ofname,
                   freq=freq,
                   vdd=vdd,
                   vddpst=vddpst,
                   vddh=vddh,
                   hvdd=hvdd,
                   hvss=hvss,
                   hvboost=hvboost,
                   vbb=vbb,
                   address=address)
    
    def current_test_update_every_16(self, ofname, freq, vdd, vddpst, vddh, hvdd,
                                hvss, hvboost, vbb, address):
        """records current of whatever supply is fed through the DMM"""
        self.current_test(self.drv_uart.write_frame_memory_update_every_16,
                   ofname=ofname,
                   freq=freq,
                   vdd=vdd,
                   vddpst=vddpst,
                   vddh=vddh,
                   hvdd=hvdd,
                   hvss=hvss,
                   hvboost=hvboost,
                   vbb=vbb,
                   address=address)

    def current_characterize_full(self, dirname, prefix, vdd, vddpst, vddh, hvdd,
                                hvss, hvboost, vbb, address):
        supply_values = [vdd, vddpst, vddh, hvdd, hvss, hvboost, vbb, address]
        freq_list = [10, 15, 20, 28]
        # VDD
        input("Connect VDD to DMM. Press enter when ready.")
        for freq in freq_list:
            self.current_test_full_pattern(os.path.join(dirname, f"{prefix}_full_pattern_{freq}MHz.csv"), freq*4*1e6, *supply_values)
    
    def current_characterize_update_every_4(self, dirname, prefix, vdd, vddpst, vddh, hvdd,
                                hvss, hvboost, vbb, address):
        supply_values = [vdd, vddpst, vddh, hvdd, hvss, hvboost, vbb, address]
        freq_list = [10, 15, 20, 28]
        # VDD
        input("Connect VDD to DMM. Press enter when ready.")
        for freq in freq_list:
            self.current_test_update_every_4(os.path.join(dirname, f"{prefix}_every_4_pattern_{freq}MHz.csv"), freq*4*1e6, *supply_values)
    
    def current_characterize_update_every_8(self, dirname, prefix, vdd, vddpst, vddh, hvdd,
                                hvss, hvboost, vbb, address):
        supply_values = [vdd, vddpst, vddh, hvdd, hvss, hvboost, vbb, address]
        freq_list = [10, 15, 20, 28]
        # VDD
        input("Connect VDD to DMM. Press enter when ready.")
        for freq in freq_list:
            self.current_test_update_every_8(os.path.join(dirname, f"{prefix}_every_8_pattern_{freq}MHz.csv"), freq*4*1e6, *supply_values)
    
    def current_characterize_update_every_16(self, dirname, prefix, vdd, vddpst, vddh, hvdd,
                                hvss, hvboost, vbb, address):
        supply_values = [vdd, vddpst, vddh, hvdd, hvss, hvboost, vbb, address]
        freq_list = [10, 15, 20, 28]
        # VDD
        input("Connect VDD to DMM. Press enter when ready.")
        for freq in freq_list:
            self.current_test_update_every_16(os.path.join(dirname, f"{prefix}_every_16_pattern_{freq}MHz.csv"), freq*4*1e6, *supply_values)

    def current_characterize_idle(self, dirname, prefix, vdd, vddpst, vddh, hvdd,
                                hvss, hvboost, vbb, address):
        freq_list = [10, 15, 20, 28]
        for freq in freq_list:
            data = []
            # Initialize chip
            init_test = self.initialize(freq=freq*4*1e6,
                                        vdd=vdd,
                                        vddpst=vddpst,
                                        vddh=vddh,
                                        hvdd=hvdd,
                                        hvss=hvss,
                                        hvboost=hvboost,
                                        vbb=vbb,
                                        address=address)
            # Disable scan in
            self.drv_uart.write_register("SCAN_IN_INST_CTRL", "scan_in_inst_valid", "0")
            # Disable FPGA-to-chip level shifters
            self.drv_uart.write_register("USER", "scan_cg_en", "0")
            # Take measurement
            for i in range(5):
                self.drv_mm.get_measurement()
            for i in range(100):
                print(f"Sample [{i+1}/100]")
                data.append(self.drv_mm.get_measurement())
            # Write data to file
            with open(os.path.join(dirname, f"{prefix}_idle_{freq}MHz.csv"), "w") as fp:
                fp.write(f"Frequency: {freq}, VDD: {vdd}, VDDPST: {vddpst}, VDDH: {vddh}, HVDD: {hvdd}, HVSS: {hvss}, HVBOOSt: {hvboost}, VBB: {vbb}, Address: {address}\n")
                fp.write("sample,current\n")
                for i, dat in enumerate(data):
                    fp.write(f"{i},{dat}\n")

if __name__ == '__main__':
    chip = Chip()

    #hs_div, n1, rfreq = chip.clock.get_closest_settings(200e6)
    #print(chip.clock.calc_output_frequency(hs_div, n1, rfreq) * 1e-6)

    ## Default (156.25 MHz)
    #if chip.clock.set_output_frequency_raw(4, 8, 43.750398982316256):
    #    print(chip.clock.get_string_config())
    #time.sleep(1)

    test = chip.full_test(freq=112e6,
                          vdd=1.8,
                          vddpst=5.0,
                          vddh=5.0,
                          hvdd=3,
                          hvss=0,
                          hvboost=67,
                          vbb=0,
                          address=3)
    
    #chip.vdd_test("supply_data", vdd_list=[1.8, 1.9], freq_list=[80e6, 100e6])
    #chip.vddpst_test("data/supply_vs_frequency/vddpst", vddpst_list=[4.0, 5.0], freq_list=[80e6, 100e6])
    
    chip.close()
