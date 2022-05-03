#!/usr/bin/env bash 

# Set PYTHONPATH accordingly
if [ -z "$PYTHONPATH" ]
then
    export PYTHONPATH=$PWD/src/python
else
    export PYTHONPATH=$PWD/src/python:$PYTHONPATH
fi
