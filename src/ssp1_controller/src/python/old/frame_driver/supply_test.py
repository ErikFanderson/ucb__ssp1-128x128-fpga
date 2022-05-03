#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Author: Erik Anderson
# Email: erik.francis.anderson@gmail.com
# Date: 02/11/2021
"""Docstring for module main"""

# Imports - standard library
import atexit
import sys
import random

# Imports - 3rd party packages
import pyvisa
import serial
import time
import numpy as np

# Imports - local source
from chip import *

if __name__ == '__main__':
    try:
        chip_name = sys.argv[1]
    except IndexError:
        print("Usage is supply_test.py <chip-name>")
        sys.exit()
    
    chip = Chip()
    
    # FREQUENCY
    freq_list = [40e6, 60e6, 80e6, 100e6, 120e6, 140e6]
    
    # VDD
    print("Run VDD test...")
    vdd_list = np.linspace(1.2, 2.4, 13)
    vdd_list = [round(vdd * 1e10) / 1e10 for vdd in vdd_list] 
    chip.vdd_test(f"data/supply_vs_frequency/{chip_name}/vdd", vdd_list=vdd_list, freq_list=freq_list)
    
    ## VDDPST
    #print("Run VDDPST test...")
    #vdd_list = np.linspace(1.2, 2.4, 13)
    #vdd_list = [round(vdd * 1e10) / 1e10 for vdd in vdd_list] 
    #chip.vddpst_test("fdata/supply_vs_frequency/{chip_name}vddpst", vddpst_list=[4.0, 5.0], freq_list=[80e6, 100e6])
