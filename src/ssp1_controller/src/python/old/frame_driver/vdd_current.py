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
from chip import Chip 

if __name__ == '__main__':
    # Setup
    dirname = "data/power/chip6/lid_off"
    prefix = "vdd"
    vdd = 1.8
    vddpst = 5.0
    vddh = 5.0
    hvdd = 3
    hvss = 0
    hvboost = 67
    vbb = 0
    address = 3

    # Run measure current funcs
    chip = Chip()

    # Idle
    chip.current_characterize_idle(dirname=dirname,
                                   prefix=prefix,
                                   vdd=vdd,
                                   vddpst=vddpst,
                                   vddh=vddh,
                                   hvdd=hvdd,
                                   hvss=hvss,
                                   hvboost=hvboost,
                                   vbb=vbb,
                                   address=address)
    
    chip.current_characterize_full(dirname=dirname,
                                   prefix=prefix,
                                   vdd=vdd,
                                   vddpst=vddpst,
                                   vddh=vddh,
                                   hvdd=hvdd,
                                   hvss=hvss,
                                   hvboost=hvboost,
                                   vbb=vbb,
                                   address=address)
    
    chip.current_characterize_update_every_4(dirname=dirname,
                                   prefix=prefix,
                                   vdd=vdd,
                                   vddpst=vddpst,
                                   vddh=vddh,
                                   hvdd=hvdd,
                                   hvss=hvss,
                                   hvboost=hvboost,
                                   vbb=vbb,
                                   address=address)
    
    chip.current_characterize_update_every_8(dirname=dirname,
                                   prefix=prefix,
                                   vdd=vdd,
                                   vddpst=vddpst,
                                   vddh=vddh,
                                   hvdd=hvdd,
                                   hvss=hvss,
                                   hvboost=hvboost,
                                   vbb=vbb,
                                   address=address)
    
    chip.current_characterize_update_every_16(dirname=dirname,
                                   prefix=prefix,
                                   vdd=vdd,
                                   vddpst=vddpst,
                                   vddh=vddh,
                                   hvdd=hvdd,
                                   hvss=hvss,
                                   hvboost=hvboost,
                                   vbb=vbb,
                                   address=address)
    
    chip.close()
