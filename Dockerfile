FROM mambaorg/micromamba

USER root

RUN apt-get update \
    && apt-get install libgl1-mesa-glx nginx git -y \
    && rm -rf /var/lib/apt/lists/*

USER $MAMBA_USER

COPY requirements.yml entrypoint.sh /tmp

RUN micromamba install -n base -f requirements.yml \
    && micromamba clean --all --force-pkgs-dirs -y \
    && /opt/conda/bin/pip install --no-dependencies lightkit pycave \
    && /opt/conda/bin/pip cache purge

RUN git clone https://github.com/labsyspharm/visinity.git --depth 1 \
    && git clone https://github.com/labsyspharm/scope2screen.git --depth 1 \
    && git clone https://github.com/labsyspharm/gater.git --depth 1 \
    && git clone https://github.com/labsyspharm/minerva_analysis.git --depth 1 -b import

#EXPOSE 8080
# ENTRYPOINT ["bash", "/app/entrypoint.sh"]
CMD ["/bin/bash", "entrypoint.sh"]

# build the docker image (execute in shell):
# docker build --no-cache -t minerva_analysis .

# run the docker container (execute in shell):
# docker run --rm -v C:/Users/Rkrueger/projects23/dock2/data:/minerva_analysis/data -p 8001:8001 -p 8002:8002 -p 8003:8003 -p 8080:8000 minerva_analysis
