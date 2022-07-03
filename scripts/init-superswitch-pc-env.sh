#!/usr/bin/env bash

# Set PYTHONPATH accordingly
if [ -z "$PYTHONPATH" ]
then
    export PYTHONPATH=$PWD:$PWD/src/ssp1_controller/src/python
else
    export PYTHONPATH=$PWD:$PWD/src/ssp1_controller/src/python:$PYTHONPATH
fi


# Source other sourcemes
cd toolbox; source sourceme.sh; cd ..
cd toolbox-xilinx-tools; source sourceme.sh; cd ..
cd equipment; source sourceme.sh; cd ..

# Set SSP1_FPGA_HOME variable
export SSP1_FPGA_HOME=$PWD

# Xilinx hwserver setup (adds stuff to path)
export PATH=/home/ipl/tools/Xilinx/HWSRVR/2022.1/bin:$PATH

# Setup license file stuff
export LM_PROJECT=bwrc_users
export XILINXD_LICENSE_FILE=2200@bwrcflex-1.eecs.berkeley.edu:2200@bwrcflex-2.eecs.berkeley.edu
