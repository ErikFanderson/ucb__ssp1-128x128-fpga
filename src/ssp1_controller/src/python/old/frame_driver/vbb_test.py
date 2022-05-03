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
    vbb_list = np.linspace(-25, 0, 6)
    vbb_list = [round(vbb * 1e10) / 1e10 for vbb in vbb_list] 
    for vbb in vbb_list:
        test = chip.full_test(vdd=1.8, vddpst=5.0, vddh=5.0, hvdd=3, hvss=0, hvboost=67, vbb=vbb, address=3)
        test_results.append(test)
    for i, vbb in enumerate(vbb_list):
        if test_results[i]:
            print(f"[PASS] Full test w/ VBB = {vbb}")
        else:
            print(f"[FAIL] Full test w/ VBB = {vbb}")
