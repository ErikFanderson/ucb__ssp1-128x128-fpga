#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Author: Erik Anderson
# Email: erik.francis.anderson@gmail.com
# Date: 03/03/2021
"""Docstring for module data"""

# Imports - standard library
import csv

# Imports - 3rd party packages
import matplotlib.pyplot as plt
import numpy as np

# Imports - local source

def read_scope_csv(fname):
    """Function for parsing csv from keysight dso-x 2024a oscilloscope"""
    with open(fname, 'r') as fp:
        rdr = csv.reader(fp)
        next(rdr)
        next(rdr)
        x = []
        y = []
        for i, row in enumerate(rdr):
            x.append(row[0])
            y.append(row[1])
        x_adj = float(x[0])
        x = x[0:-2]
        y = y[0:-2]
        x = [float(dat) - x_adj for dat in x] 
        y = [float(dat) for dat in y] 
    return (x, y)

def index_closest_to(array, value):
    """Returns the index in the array corresponding to element that is 
    closest in value to value"""
    array_diff = np.abs(array - value)
    return array_diff.argmin()

if __name__ == '__main__':
    #--------------------------------------------------------------------------
    # Plot rise time vs. hvdd - chip 1, row 1, column 1 
    #--------------------------------------------------------------------------
    # Row 1 column 1 driver output voltage
    # NOTE row 0 in same column was toggled to get rise and fall (only 1 device switching)
    voltages = [(10, 7), (15, 12), (20, 17), (25, 22), (30, 27)]
    fig, ax = plt.subplots()
    volt_list = []
    rt_list = []
    for v in voltages:
        # Rise
        fname = f"data/03_03_2021_1249am/chip1_r1_c1_hvdd{v[0]}_hvss{v[1]}_rise.csv"
        x, y = read_scope_csv(fname)
        x = [1e6 * dat for dat in x]
        start_index = index_closest_to(np.asarray(y), v[0] * 0.1)
        end_index = index_closest_to(np.asarray(y), v[0] * 0.9)
        rise_time = x[end_index] - x[start_index]
        volt_list.append(v[0])
        rt_list.append(rise_time)
    ax.plot(volt_list, rt_list, ".-", label="Chip 1, row 1, column 1")
    ax.set_xlabel("HVDD [V]")
    ax.set_ylabel("Rise Time [us]")
    
    # Row 1 column 2 driver output voltage
    # NOTE row 0 in same column was toggled to get rise and fall (only 1 device switching)
    voltages = [(10, 7), (15, 12), (20, 17), (25, 22), (30, 27)]
    #fig, ax = plt.subplots()
    volt_list = []
    rt_list = []
    for v in voltages:
        # Rise
        fname = f"data/03_04_2021_446pm/chip1_r1_c2_hvdd{v[0]}_hvss{v[1]}_rise_single.csv"
        x, y = read_scope_csv(fname)
        x = [1e6 * dat for dat in x]
        start_index = index_closest_to(np.asarray(y), v[0] * 0.1)
        end_index = index_closest_to(np.asarray(y), v[0] * 0.9)
        rise_time = x[end_index] - x[start_index]
        volt_list.append(v[0])
        rt_list.append(rise_time)
    ax.plot(volt_list, rt_list, ".-", label="Chip 1, row 1, column 2")
    ax.set_xlabel("HVDD [V]")
    ax.set_ylabel("Rise Time [us]")
    ax.set_title("Measured Rise Time (HVDD = 30V, HVSS = 27V)")
    ax.grid()
    ax.legend()
    
    #--------------------------------------------------------------------------
    # Plot fall time vs. hvdd - chip 1, row 1, column 1 
    #--------------------------------------------------------------------------
    # Row 1 column 1 driver output voltage
    # NOTE row 0 in same column was toggled to get rise and fall (only 1 device switching)
    voltages = [(10, 7), (15, 12), (20, 17), (25, 22), (30, 27)]
    fig, ax = plt.subplots()
    volt_list = []
    rt_list = []
    for v in voltages:
        # Rise
        fname = f"data/03_03_2021_1249am/chip1_r1_c1_hvdd{v[0]}_hvss{v[1]}_fall.csv"
        x, y = read_scope_csv(fname)
        x = [1e6 * dat for dat in x]
        start_index = index_closest_to(np.asarray(y), v[0] * 0.1)
        end_index = index_closest_to(np.asarray(y), v[0] * 0.9)
        rise_time = x[start_index] - x[end_index]
        volt_list.append(v[0])
        rt_list.append(rise_time)
    ax.plot(volt_list, rt_list, ".-", label="Chip 1, row 1, column 1")
    ax.set_xlabel("HVDD [V]")
    ax.set_ylabel("Fall Time [us]")
    
    # Row 1 column 2 driver output voltage
    # NOTE row 0 in same column was toggled to get rise and fall (only 1 device switching)
    voltages = [(10, 7), (15, 12), (20, 17), (25, 22), (30, 27)]
    #fig, ax = plt.subplots()
    volt_list = []
    rt_list = []
    for v in voltages:
        # Rise
        fname = f"data/03_04_2021_446pm/chip1_r1_c2_hvdd{v[0]}_hvss{v[1]}_fall_single.csv"
        x, y = read_scope_csv(fname)
        x = [1e6 * dat for dat in x]
        start_index = index_closest_to(np.asarray(y), v[0] * 0.1)
        end_index = index_closest_to(np.asarray(y), v[0] * 0.9)
        rise_time = x[start_index] - x[end_index]
        volt_list.append(v[0])
        rt_list.append(rise_time)
    ax.plot(volt_list, rt_list, ".-", label="Chip 1, row 1, column 2")
    ax.set_xlabel("HVDD [V]")
    ax.set_ylabel("Fall Time [us]")
    ax.set_title("Measured Fall Time (HVDD = 30V, HVSS = 27V)")
    ax.grid()
    ax.legend()
    
    #--------------------------------------------------------------------------
    # Plot individual w/ rise time
    #--------------------------------------------------------------------------
    #fname = "data/03_03_2021_1249am/chip1_r1_c1_hvdd30_hvss27_rise.csv"
    #max_voltage = 30 
    #time, voltage = read_scope_csv(fname)
    #fig, ax = plt.subplots()
    #start_index = index_closest_to(np.asarray(voltage), 0.1*max_voltage)
    #end_index = index_closest_to(np.asarray(voltage), 0.9*max_voltage)
    #ax.plot(time, voltage)
    #ax.set_xlim([0, 5e-6])
    #ax.set_ylim([0, 40])
    #ax.plot(ax.get_xlim(), [voltage[start_index], voltage[start_index]], "k--")
    #ax.plot(ax.get_xlim(), [voltage[end_index], voltage[end_index]], "k--")
    #ax.plot([time[start_index], time[start_index]], ax.get_ylim(), "k--")
    #ax.plot([time[end_index], time[end_index]], ax.get_ylim(), "k--")
    #ax.set_xlabel("Time [sec]")
    #ax.set_ylabel("Voltage [V]")
    #ax.grid()

    #--------------------------------------------------------------------------
    # Plot raw data
    #--------------------------------------------------------------------------
    ## Row 1 column 1 driver output voltage
    ## NOTE row 0 in same column was toggled to get rise and fall (only 1 device switching)
    #voltages = [(10, 7), (15, 12), (20, 17), (25, 22), (30, 27)]
    #fig_rise, ax_rise = plt.subplots()
    #fig_fall, ax_fall = plt.subplots()
    #ax_rise.set_title("Rise Time - Row 1 Column 1 Driver")
    #ax_rise.set_xlabel("Time [us]")
    #ax_rise.set_ylabel("Voltage [V]")
    #ax_rise.grid()
    #ax_fall.set_title("Fall Time - Row 1 Column 1 Driver")
    #ax_fall.set_xlabel("Time [us]")
    #ax_fall.set_ylabel("Voltage [V]")
    #ax_fall.grid()
    #for v in voltages:
    #    # Rise
    #    fname = f"data/03_03_2021_1249am/chip1_r1_c1_hvdd{v[0]}_hvss{v[1]}_rise.csv"
    #    x, y = read_scope_csv(fname)
    #    x = [1e6 * dat for dat in x]
    #    ax_rise.plot(x, y, label=f"HVDD = {v[0]}, HVSS = {v[1]}")
    #    # Fall 
    #    fname = f"data/03_03_2021_1249am/chip1_r1_c1_hvdd{v[0]}_hvss{v[1]}_fall.csv"
    #    x, y = read_scope_csv(fname)
    #    x = [1e6 * dat for dat in x]
    #    ax_fall.plot(x, y, label=f"HVDD = {v[0]}, HVSS = {v[1]}")
    #ax_rise.legend()
    #ax_fall.legend()
    ##plt.show()
    #
    ## Row 1 column 2 driver output voltage
    ## NOTE row 0 in same column was toggled to get rise and fall (only 1 device switching)
    ##voltages = [(5, 2), (10, 7), (15, 12), (20, 17), (25, 22), (30, 27)]
    #voltages = [(10, 7), (15, 12), (20, 17), (25, 22), (30, 27)]
    #fig_rise, ax_rise = plt.subplots()
    #fig_fall, ax_fall = plt.subplots()
    #ax_rise.set_title("Rise Time - Row 1 Column 2 Driver")
    #ax_rise.set_xlabel("Time [us]")
    #ax_rise.set_ylabel("Voltage [V]")
    #ax_rise.grid()
    #ax_fall.set_title("Fall Time - Row 1 Column 2 Driver")
    #ax_fall.set_xlabel("Time [us]")
    #ax_fall.set_ylabel("Voltage [V]")
    #ax_fall.grid()
    #for v in voltages:
    #    # Rise
    #    fname = f"data/03_04_2021_446pm/chip1_r1_c2_hvdd{v[0]}_hvss{v[1]}_rise_single.csv"
    #    x, y = read_scope_csv(fname)
    #    x = [1e6 * dat for dat in x]
    #    ax_rise.plot(x, y, label=f"HVDD = {v[0]}, HVSS = {v[1]}")
    #    # Fall 
    #    fname = f"data/03_04_2021_446pm/chip1_r1_c2_hvdd{v[0]}_hvss{v[1]}_fall_single.csv"
    #    x, y = read_scope_csv(fname)
    #    x = [1e6 * dat for dat in x]
    #    ax_fall.plot(x, y, label=f"HVDD = {v[0]}, HVSS = {v[1]}")
    #ax_rise.legend()
    #ax_fall.legend()
    #
    ### Row 1 column 2 driver output voltage (all drivers on same row actuated at same time)
    ### NOTE row 0 in ALL columns was toggled to get rise and fall (32 devices switching)
    ###voltages = [(5, 2), (10, 7), (15, 12), (20, 17), (25, 22), (30, 27)]
    ##voltages = [(5, 2), (15, 12), (20, 17), (25, 22), (30, 27)]
    ##fig_rise, ax_rise = plt.subplots()
    ##fig_fall, ax_fall = plt.subplots()
    ##ax_rise.set_title("Rise Time - Row 1 Column 2 Driver - Full Row")
    ##ax_rise.set_xlabel("Time [us]")
    ##ax_rise.set_ylabel("Voltage [V]")
    ##ax_rise.grid()
    ##ax_fall.set_title("Fall Time - Row 1 Column 2 Driver - Full Row")
    ##ax_fall.set_xlabel("Time [us]")
    ##ax_fall.set_ylabel("Voltage [V]")
    ##ax_fall.grid()
    ##for v in voltages:
    ##    # Rise
    ##    fname = f"data/03_04_2021_446pm/chip1_r1_c2_hvdd{v[0]}_hvss{v[1]}_rise_full.csv"
    ##    x, y = read_scope_csv(fname)
    ##    x = [1e6 * dat for dat in x]
    ##    ax_rise.plot(x, y, label=f"HVDD = {v[0]}, HVSS = {v[1]}")
    ##    # Fall 
    ##    fname = f"data/03_04_2021_446pm/chip1_r1_c2_hvdd{v[0]}_hvss{v[1]}_fall_full.csv"
    ##    x, y = read_scope_csv(fname)
    ##    x = [1e6 * dat for dat in x]
    ##    ax_fall.plot(x, y, label=f"HVDD = {v[0]}, HVSS = {v[1]}")
    ##ax_rise.legend()
    ##ax_fall.legend()
    
    # Plot all plots
    plt.show()
