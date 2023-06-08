#!/bin/bash
python minerva_analysis/run.py 8000 &
python scope2screen/run.py 8001 &
python gater/run.py 8002 &
python visinity/run.py 8003 &
nginx -g 'daemon off;' &
#python -m http.server -d /app 8080
& wait