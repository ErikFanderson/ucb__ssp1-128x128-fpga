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
    chip = Chip()
    test_results = []
    hvss_list = np.linspace(65, 67, 21)
    hvss_list = [round(hvss * 1e10) / 1e10 for hvss in hvss_list] 
    for hvss in hvss_list:
        hvdd = round((70-hvss) * 1e10) / 1e10
        test = chip.full_test(vdd=1.8, vddpst=5.0, vddh=5.0, hvdd=hvdd, hvss=0, hvboost=hvss, vbb=0, address=3)
        test_results.append(test)
    for i, hvss in enumerate(hvss_list):
        if test_results[i]:
            print(f"[PASS] Full test w/ HVSS = {hvss}")
        else:
            print(f"[FAIL] Full test w/ HVSS = {hvss}")
