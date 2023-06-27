# minerva_analysis-docker
A docker project to run Gating, Scope2Screen, and Visinity in a Joint Environment.

![image](https://github.com/labsyspharm/minerva_analysis-docker/assets/31503434/f826b11d-7fcf-4ec9-a856-fa77a6d3ddc0)



## build the docker image (execute in shell):
From the folder containing the dockerfile run `docker build -t minerva_analysis .`

## run docker container
`docker run --rm -v [path where your data lies]:minerva_analysis/data a -p 8001:8001 -p 8002:8002 -p 8003:8003 -p 8000:8000 minerva_analysis`

This command runs a docker container from the built image and forwards inner ports to outerports for importing, gater, scope2screen, and visinity.
It also mounts your data folder  (here in []) to the inner container folder minerva_analysis/data, so that your data becomes available for imports (rw).

## accessing the tool and importing data
Open your browser (Chrome recommended) and navigate to `localhost:8000`. Click on import. You will find the mounted folder under minerva_analysis/data/. 
Example for importing channel file: `minerva_analysis/data/sardana_crop/crop-crc01-097-096.ome.tif`.
After the import go back to localhost:8000 and select one of the tools (e.g. Gater). In Gater you will find the imported project under Data Sources.

## example data
(https://www.synapse.org/#!Synapse:syn30919374/wiki/617796)
