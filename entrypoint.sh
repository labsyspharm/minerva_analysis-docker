#!/bin/bash
python minerva_analysis/run.py 8000 1 &
python scope2screen/run.py 8001 1 &
python gater/run.py 8002 1 &
python visinity/run.py 8003 1 &
& wait