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
    hvdd_list = np.linspace(90, 100, 6)
    hvdd_list = [round(hvdd * 1e10) / 1e10 for hvdd in hvdd_list] 
    for hvdd in hvdd_list:
        hvboost = round((hvdd-3) * 1e10) / 1e10
        test = chip.full_test(vdd=1.8, vddpst=5.0, vddh=5.0, hvdd=3, hvss=0, hvboost=hvboost, vbb=0, address=3)
        test_results.append(test)
    for i, hvdd in enumerate(hvdd_list):
        if test_results[i]:
            print(f"[PASS] Full test w/ HVDD = {hvdd}")
        else:
            print(f"[FAIL] Full test w/ HVDD = {hvdd}")
