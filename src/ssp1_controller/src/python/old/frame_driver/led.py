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

# Imports - local source
from ss_driver import *

if __name__ == '__main__':
    # Open driver 
    drv = SuperSwitchUARTDriver()
    
    # Initialize memory to 0 and take design out of reset
    drv.initialize_uart_memory()
    
    # Write leds
    print("LED test...")
    while(1):
        for i in range(8):
            drv.write_register("USER", "leds", f"{1 << i:08b}")
            print("LED Byte: 0b" + drv.read_register("USER", "leds"))
            time.sleep(0.25)
        for i in range(8):
            drv.write_register("USER", "leds", f"{1 << (7 - i):08b}")
            print("LED Byte: 0b" + drv.read_register("USER", "leds"))
            time.sleep(0.25)
    drv.close()
