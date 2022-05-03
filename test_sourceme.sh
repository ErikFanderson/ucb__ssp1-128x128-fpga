#!/usr/bin/env bash

# Set PROJECT_HOME variable
export SSP1_FPGA_HOME=$PWD

# Source toolbox
cd toolbox; source sourceme.sh; cd ..

# Simulator (Xcelium) setup
export XCELIUM_HOME=/tools/cadence/XCELIUM/XCELIUM1809
export PATH=${XCELIUM_HOME}/tools.lnx86/bin:$PATH
