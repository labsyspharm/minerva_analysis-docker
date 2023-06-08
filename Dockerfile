FROM continuumio/miniconda3
RUN apt-get update \
    && apt-get install libgl1-mesa-glx nginx git -y \
    && rm -rf /var/lib/apt/lists/* \

RUN \
 && git clone https://github.com/labsyspharm/visinity.git && git clone https://github.com/labsyspharm/scope2screen.git && git clone https://github.com/labsyspharm/gater.git && git clone https://github.com/labsyspharm/minerva_analysis.git -b import

COPY . /app

RUN conda init bash \
    && . ~/.bashrc \
    && conda update conda \
    && conda env create -f /app/requirements.yml \
    && conda activate minerva_analysis

COPY /img/gater.png /var/www/html/
COPY /img/scope2screen.png /var/www/html/
COPY /img/visinity.png /var/www/html/

#EXPOSE 8080
# ENTRYPOINT ["bash", "/app/entrypoint.sh"]
RUN chmod +x /app/entrypoint.sh
CMD ["conda", "run", "-n", "minerva_analysis", "/app/entrypoint.sh"]

# build the docker image (execute in shell):
# docker build -t minerva_analysis .
# run the docker container (execute in shell):
# docker run --rm -v C:/Users/Rkrueger/projects23/dock2/data:/minerva_analysis/data -p 8001:8001 -p 8002:8002 -p 8003:8003 minerva_analysis
# docker run --rm -v C:/Users/Rkrueger/projects23/dock2/data:/minerva_analysis/data -p 8001:8001 -p 8002:8002 -p 8003:8003 -p 8000:8000 minerva_analysis
