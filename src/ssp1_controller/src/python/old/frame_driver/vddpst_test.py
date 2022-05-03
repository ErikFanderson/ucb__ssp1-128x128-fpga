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
    vddpst_list = np.linspace(1.8, 6.0, 22)
    vddpst_list = [round(vddpst * 1e10) / 1e10 for vddpst in vddpst_list] 
    for vddpst in vddpst_list:
        test = chip.full_test(vdd=1.8, vddpst=vddpst, vddh=5.0, hvdd=3, hvss=0, hvboost=67, vbb=0, address=3)
        test_results.append(test)
    for i, vddpst in enumerate(vddpst_list):
        if test_results[i]:
            print(f"[PASS] Full test w/ VDDPST = {vddpst}")
        else:
            print(f"[FAIL] Full test w/ VDDPST = {vddpst}")
