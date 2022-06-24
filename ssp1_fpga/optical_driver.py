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

# Imports - local source
from UARTDriver import *
from equipment.agilent3631a import Agilent3631A
from equipment.keithley2230 import Keithley2230
from equipment.keithley2400 import *

# TODO hvboost measure current and voltage

class OpticalDriver:
    """
    This class builds various equipment drivers:
    - 1x Polarization controller (Agilent11896A)
    - 2x 1x64 optical circuit switches (JDSSCSwitch)
    - 1x lightwaves multimeter - 2 optical inputs (SantecTSL550)
    - 1x santec laser (SantecTSL550)

    """

    def __init__(self, resource_manager, agilent3631a_gpib_str, keithley2230_usb_str, keithley2400_gpib_str):
        # Init supplies
        self._rm = resource_manager
        #self.supply0 = Agilent3631A("GPIB0::6::INSTR", self._rm)
        #self.supply1 = Keithley2230("USB0::1510::8752::9031983::0::INSTR", self._rm)
        #self.supply2 = Keithley2400("GPIB0::24::INSTR", self._rm)
        self.supply0 = Agilent3631A(agilent3631a_gpib_str, self._rm)
        self.supply1 = Keithley2230(keithley2230_usb_str, self._rm)
        self.supply2 = Keithley2400(keithley2400_gpib_str, self._rm)
        self.supply2.set_source_mode(SourceMode.FIXED_VOLTAGE)
        # Set starting current limits
        self.set_current_limit("vdd", 50e-3)
        self.set_current_limit("vddpst", 50e-3)
        self.set_current_limit("vbb", 50e-3)
        self.set_current_limit("hvdd", 50e-3)
        self.set_current_limit("hvss", 50e-3)
        self.set_current_limit("vddh", 50e-3)
        self.set_current_limit("hvboost", 50e-3)
        # Force all supplies to 0V
        self.set_voltage("vdd", 0)
        self.set_voltage("vddpst", 0)
        self.set_voltage("vbb", 0)
        self.set_voltage("hvdd", 0)
        self.set_voltage("hvss", 0)
        self.set_voltage("vddh", 0)
        self.set_voltage("hvboost", 0)
        # Measurement data
        self.data = {}
        for supply in ["vdd", "vddpst", "vbb", "hvdd", "hvss", "vddh"]:
            self.data[supply] = {"current": [], "voltage": []}

    #--------------------------------------------------------------------------
    # Power supply methods
    #--------------------------------------------------------------------------

    def disable_supplies(self):
        """Turns off all supplies"""
        self.supply0.set_output_state(0)
        self.supply1.set_output_state(Keithley2230.CHANNEL_1, 0)
        self.supply1.set_output_state(Keithley2230.CHANNEL_2, 0)
        self.supply1.set_output_state(Keithley2230.CHANNEL_3, 0)
        self.supply2.disable_source()

    def enable_supplies(self):
        """Turns on all supplies"""
        self.supply0.set_output_state(1)
        self.supply1.set_output_state(Keithley2230.CHANNEL_1, 1)
        self.supply1.set_output_state(Keithley2230.CHANNEL_2, 2)
        self.supply1.set_output_state(Keithley2230.CHANNEL_3, 3)
        self.supply2.enable_source()

    def measure_voltage(self, supply: str) -> float:
        """Maps supply names to physical supply channels
        Returns False if invalid supply name given
        """
        if supply == "vdd":
            v = self.supply0.measure_voltage(Agilent3631A.CHANNEL_P6V)
        elif supply == "vddpst":
            v = self.supply0.measure_voltage(Agilent3631A.CHANNEL_P25V)
        elif supply == "vbb":
            v = self.supply0.measure_voltage(Agilent3631A.CHANNEL_N25V)
        elif supply == "hvdd":
            v = self.supply1.measure_voltage(Keithley2230.CHANNEL_1)
        elif supply == "hvss":
            v = self.supply1.measure_voltage(Keithley2230.CHANNEL_2)
        elif supply == "vddh":
            v = self.supply1.measure_voltage(Keithley2230.CHANNEL_3)
        else:
            return None
        self.data[supply]["voltage"].append(v)
        return v

    def measure_current(self, supply: str) -> float:
        """Maps supply names to physical supply channels
        Returns False if invalid supply name given
        """
        if supply == "vdd":
            i = self.supply0.measure_current(Agilent3631A.CHANNEL_P6V)
        elif supply == "vddpst":
            i = self.supply0.measure_current(Agilent3631A.CHANNEL_P25V)
        elif supply == "vbb":
            i = self.supply0.measure_current(Agilent3631A.CHANNEL_N25V)
        elif supply == "hvdd":
            i = self.supply1.measure_current(Keithley2230.CHANNEL_1)
        elif supply == "hvss":
            i = self.supply1.measure_current(Keithley2230.CHANNEL_2)
        elif supply == "vddh":
            i = self.supply1.measure_current(Keithley2230.CHANNEL_3)
        else:
            return None
        self.data[supply]["current"].append(i)
        return i

    def set_voltage(self, supply: str, voltage: float) -> bool:
        """Maps supply names to physical supply channels
        Returns False if invalid supply name given
        """
        if supply == "vdd":
            self.supply0.set_voltage(Agilent3631A.CHANNEL_P6V, voltage)
        elif supply == "vddpst":
            self.supply0.set_voltage(Agilent3631A.CHANNEL_P25V, voltage)
        elif supply == "vbb":
            self.supply0.set_voltage(Agilent3631A.CHANNEL_N25V, voltage)
        elif supply == "hvdd":
            self.supply1.set_voltage(Keithley2230.CHANNEL_1, voltage)
        elif supply == "hvss":
            self.supply1.set_voltage(Keithley2230.CHANNEL_2, voltage)
        elif supply == "vddh":
            self.supply1.set_voltage(Keithley2230.CHANNEL_3, voltage)
        elif supply == "hvboost":
            self.supply2.set_voltage(voltage)
        else:
            return False
        return True

    def set_current_limit(self, supply: str, current: float) -> bool:
        """Maps supply names to physical supply channels
        Returns False if invalid supply name given
        """
        if supply == "vdd":
            self.supply0.set_current_limit(Agilent3631A.CHANNEL_P6V, current)
        elif supply == "vddpst":
            self.supply0.set_current_limit(Agilent3631A.CHANNEL_P25V, current)
        elif supply == "vbb":
            self.supply0.set_current_limit(Agilent3631A.CHANNEL_N25V, current)
        elif supply == "hvdd":
            self.supply1.set_current_limit(Keithley2230.CHANNEL_1, current)
        elif supply == "hvss":
            self.supply1.set_current_limit(Keithley2230.CHANNEL_2, current)
        elif supply == "vddh":
            self.supply1.set_current_limit(Keithley2230.CHANNEL_3, current)
        elif supply == "hvboost":
            self.supply2.set_current_limit(current)
            self.supply2.set_meas_current_range(current)
        else:
            return False
        return True

    def take_supply_measurement(self, verbose: bool = False):
        """
        Takes current and voltage measurement for each supply channel
        Returns csv line curr_vdd,curr_vddpst,curr_vbb,
        """
        print("# Supply Measurement #")
        for supply in ["vdd", "vddpst", 'vddh','hvdd', 'hvss', 'vbb']:
            self.measure_current(supply)
            self.measure_voltage(supply)
            if verbose:
                print(supply.upper())
                print(f"- Voltage: {self.data[supply]['voltage'][-1]} [V]")
                print(f"- Current: {self.data[supply]['current'][-1] * 1e3} [mA]")

    #def plot_supplies(self, subtitle=None):
    #    """Uses matplotlib to plot supplies"""
    #    fig, ax = plt.subplots(2)
    #    #fig_v, ax_v = plt.subplots()
    #    #fig_c, ax_c = plt.subplots()
    #    for supply in ["vdd", "vddpst", "vbb", "hvdd", "hvss", "vddh"]:
    #        data_v = self.data[supply]["voltage"]
    #        data_c = self.data[supply]["current"]
    #        ax[0].plot(list(range(len(data_v))), data_v, ".-", label=supply)
    #        ax[1].plot(list(range(len(data_c))), data_c, ".-", label=supply)
    #    if subtitle:
    #        ax[0].set_title(f"Supply Voltage and Current - {subtitle}")
    #    else:
    #        ax[0].set_title("Supply Voltage and Current")
    #    ax[0].set_ylabel("Voltage [V]")
    #    ax[0].legend()
    #    ax[1].set_xlabel("Sample Number")
    #    ax[1].set_ylabel("Current [A]")
    #    ax[1].set_ylim([0, 50e-3])
    #    ax[1].legend()
    #    plt.show()

if __name__ == '__main__':
    pass
