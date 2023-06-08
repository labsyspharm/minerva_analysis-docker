# minerva_analysis-docker
A docker project to run Gating, Scope2Screen, and Visinity in a Joint Environment.

## build the docker image (execute in shell):
docker build -t minerva_analysis .

## run docker container
docker run --rm -v [path where your data lies] a -p 8001:8001 -p 8002:8002 -p 8003:8003 -p 8000:8000 minerva_analysis

## accessing the tool and importing data
Open your browser (Chrome recommended) and navigate to localhost:8000. Click on import. You will find the mounted folder under minerva_analysis/data/. 
Example for importing  channel file: minerva_analysis/data/sardana_crop/crop-crc01-097-096.ome.tif.
After the import go back to localhost:8000 and select one of the tools (e.g. Gater). In Gater you will find the imported project under Data Sources.
