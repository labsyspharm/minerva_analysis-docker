#!/bin/bash
cd $(dirname $0)
trap "echo 'shutting down'; exit" INT QUIT TERM
python minerva_analysis/run.py 8000 1 &
python scope2screen/run.py 8001 1 &
python gater/run.py 8002 1 &
python visinity/run.py 8003 1 &
wait
