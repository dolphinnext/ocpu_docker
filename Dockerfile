FROM opencpu/base:v2.2.8

LABEL author="alper.kucukural@umassmed.edu" description="Docker image containing all requirements for the dolphinnext/ocpu app"

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

RUN apt-get update --fix-missing && \
    apt-get install -y vim wget bzip2 ca-certificates curl git \
    libtbb-dev gcc g++ libcairo2-dev pandoc \
    libcurl4-openssl-dev libssl-dev libxml2-dev \              
    texlive-base texlive-latex-base texlive-fonts-recommended \
    libfontconfig1-dev libcairo2-dev libhdf5-dev cmake \
    libharfbuzz-dev libfribidi-dev libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev

RUN R -e "install.packages(c('knitr', 'rmarkdown', 'curl', 'httr', 'Seurat'), dependencies=TRUE)"
RUN R -e "install.packages(c('anndata', 'xml2', 'tidyverse', 'dplyr', 'Matrix'), dependencies=TRUE)" 
RUN R -e "install.packages(c('scales', 'RCurl', 'svglite', 'patchwork', 'readr', 'ggpubr', 'DT'), dependencies=TRUE)"
RUN R -e "install.packages(c('BiocManager', 'devtools'), dependencies=TRUE)"

RUN R -e "BiocManager::install(c('DEBrowser', 'SingleCellExperiment', 'zellkonverter', 'limma', 'UCell', 'scuttle', 'SingleR', 'celldex'))"
RUN R -e "devtools::install_github('umms-biocore/markdownapp', upgrade = 'always')"

