#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Author: Erik Anderson
# Email: erik.francis.anderson@gmail.com
# Date: 02/11/2021
"""Docstring for module main"""

# Imports - standard library
import serial
import time

# Imports - 3rd party packages
import pyvisa

# Imports - local source
from equipment.agilent8153a import *
from equipment.jds_sc_switch import *
from equipment.agilent11896a import *
from equipment.santec_tsl_550 import *


class OpticalDriver:
    """
    This class builds various equipment drivers:
    - 1x Polarization controller (Agilent11896A)
    - 2x 1x64 optical circuit switches (JDSSCSwitch)
    - 1x lightwaves multimeter - 2 optical inputs (Agilent8153A)
    - 1x santec laser (SantecTSL550)

    """

    def __init__(self, resource_manager, agilent11896a_gpib_str,
                 jds_sc_gipb_str_0, jds_sc_gipb_str_1, agilent8153a_gpib_str,
                 santec_tsl_550_gpib_str):
        self._rm = resource_manager
        #self.pol_ctrl = Agilent11896A(agilent11896a_gpib_str, resource_manager)
        self.input_switch = JDSSCSwitch(jds_sc_gipb_str_0, resource_manager, 64)
        self.output_switch = JDSSCSwitch(jds_sc_gipb_str_1, resource_manager, 64)
        self.laser = SantecTSL550(santec_tsl_550_gpib_str, resource_manager)

        # TODO implement
        self.lw_mm = Agilent8153A(agilent8153a_gpib_str, resource_manager)

if __name__ == '__main__':
    opt_drv = OpticalDriver(resource_manager=pyvisa.ResourceManager("@py"),
                            agilent11896a_gpib_str="GPIB0::25::INSTR",
                            jds_sc_gipb_str_0="GPIB0::8::INSTR",
                            jds_sc_gipb_str_1="GPIB0::9::INSTR",
                            agilent8153a_gpib_str="GPIB0::22::INSTR",
                            santec_tsl_550_gpib_str="GPIB0::30::INSTR")
