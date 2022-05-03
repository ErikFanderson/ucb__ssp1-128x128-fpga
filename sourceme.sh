#!/usr/bin/env bash

# Set PYTHONPATH accordingly
if [ -z "$PYTHONPATH" ]
then
    export PYTHONPATH=$PWD
else
    export PYTHONPATH=$PWD:$PYTHONPATH
fi

# Source other sourcemes
cd toolbox; source sourceme.sh; cd ..
cd toolbox-xilinx-tools; source sourceme.sh; cd ..
cd equipment; source sourceme.sh; cd ..

# Set SSP1_FPGA_HOME variable
export SSP1_FPGA_HOME=$PWD

# Vivado setup (adds stuff to path)
source /tools/Xilinx/Vivado/2020.2/settings64.sh

# Setup license file stuff
export LM_PROJECT=bwrc_users
export XILINXD_LICENSE_FILE=2200@bwrcflex-1.eecs.berkeley.edu:2200@bwrcflex-2.eecs.berkeley.edu
