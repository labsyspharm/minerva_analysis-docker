FROM mambaorg/micromamba

USER root

RUN <<APT-INSTALL
    set -e
    apt-get update
    apt-get install -y libgl1-mesa-glx curl unzip nginx
    rm -rf /var/lib/apt/lists/*
APT-INSTALL

RUN <<NGINX-SETUP
    set -e
    # Avoid errors from hard-coded paths.
    chown -R $MAMBA_USER /var/log/nginx /var/lib/nginx
    mkdir /tmp/nginx
    chown $MAMBA_USER /tmp/nginx
NGINX-SETUP

USER $MAMBA_USER

COPY requirements.yml entrypoint.sh nginx.conf /tmp

RUN <<PYTHON-INSTALL
    set -e
    micromamba install -n base -f requirements.yml
    micromamba clean --all --force-pkgs-dirs -y
    /opt/conda/bin/pip install --no-dependencies lightkit pycave
    /opt/conda/bin/pip cache purge
PYTHON-INSTALL

# These ADD lines are intended to invalidate the cache for all further layers if
# any of the repositories are updated.
ADD "https://api.github.com/repos/labsyspharm/visinity/commits?per_page=1" commits/head_visinity
ADD "https://api.github.com/repos/labsyspharm/scope2screen/commits?per_page=1" commits/head_scope2screen
ADD "https://api.github.com/repos/labsyspharm/gater/commits?per_page=1" commits/head_gater
ADD "https://api.github.com/repos/labsyspharm/minerva_analysis/commits/heads/import?per_page=1" commits/head_minerva_analysis
RUN <<CODE-INSTALL
    set -e
    curl -LOJ https://github.com/labsyspharm/visinity/archive/refs/heads/main.zip
    curl -LOJ https://github.com/labsyspharm/scope2screen/archive/refs/heads/master.zip
    curl -LOJ https://github.com/labsyspharm/gater/archive/refs/heads/main.zip
    curl -LOJ https://github.com/labsyspharm/minerva_analysis/archive/refs/heads/import.zip
    unzip visinity-main.zip
    unzip scope2screen-master.zip
    unzip gater-main.zip
    unzip minerva_analysis-import.zip
    mv visinity-main visinity
    mv scope2screen-master scope2screen
    mv gater-main gater
    mv minerva_analysis-import minerva_analysis
    rm visinity-main.zip scope2screen-master.zip gater-main.zip minerva_analysis-import.zip
    rm -r scope2screen/minerva_analysis/client/external/viaWebGL-webgl2/demo
    rm -r scope2screen/minerva_analysis/client/node_modules
CODE-INSTALL

EXPOSE 8080
CMD ["/bin/bash", "entrypoint.sh"]

# build the docker image (execute in shell):
# docker build -t labsyspharm/minerva_analysis:latest .

# run the docker container (execute in shell):
# docker run --rm -v C:/Users/Rkrueger/projects23/dock2/data:/tmp/minerva_analysis/data -p 127.0.0.1:8080:8080 labsyspharm/minerva_analysis:latest
