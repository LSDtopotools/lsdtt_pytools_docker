# This is the full lsdtopytools container
# It includes all the python packages needed to run both lsdtopytools and lsdviztools
# lsdtopytools and lsdviztools are installed
# lsdtt command line tools are also installed
# As is the jupyter notebook which you can start with 
# jupyter notebook --ip 0.0.0.0 --port 8888 --no-browser --allow-root

# Pull base image. We start from the miniconda imade
FROM conda/miniconda3
MAINTAINER Simon Mudd (simon.m.mudd@ed.ac.uk) and Boris Gailleton (b.gailleton@sms.ed.ac.uk)

# Need this to shortcut the stupid tzdata noninteractive thing
ARG DEBIAN_FRONTEND=noninteractive

# We need some stuff to get lsdtopytools to install
RUN apt-get update && apt-get install -y \
    build-essential \
    libfftw3-dev \
&& rm -rf /var/lib/apt/lists/*

# Update conda
RUN conda install -y -c conda-forge conda

# Add the conda forge
RUN conda config --add channels conda-forge

# Set the channel
RUN conda config --set channel_priority strict

# Some tools for fetching data
RUN conda install -y wget unzip

# Some of the plotting tools use ffmpeg
RUN conda install -y ffmpeg

# Install topotools command line interface
RUN conda install -y lsdtopotools

# Add git and the right version of python
RUN conda install -y git python=3.8

# Now the ipython stack for creating local ipython servers
RUN conda install -y ipython ipykernel jupyter jupyter-book

# Now an environment for building conda
RUN conda install -y conda-build

# Now mamba since it is faster than conda
RUN conda install -y mamba

# Now add some conda packages
RUN mamba install -y gdal rasterio geopandas matplotlib numpy scipy pytables numba feather-format pandas pip pybind11 xtensor xtensor-python fiona utm pyproj cartopy folium h5py descartes

# Add viztools and paramselector
RUN pip install lsdviztools lsdttparamselector

# Add lsdtopytools
RUN mamba install -y lsdtopytools

# Set the working directory
WORKDIR /LSDTopoTools

# Copy the script for fetching example data
COPY Get_LSDTT_example_data.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/Get_LSDTT_example_data.sh
