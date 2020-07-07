# This is the full lsdtopytools container
# It includes all the python packages needed to run lsdtopytools
# As well as visualising the data

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

# Add git so you can clone the lsdmappingtools repo
RUN conda install -y git python=3

# Now the ipython stack for creating local ipython servers
RUN conda install -y ipython ipykernel jupyter

# Now an environment for building conda
RUN conda install -y conda-build

# Now add some conda packages
RUN conda install -y gdal rasterio geopandas matplotlib numpy scipy pytables numba feather-format pandas pip pybind11 xtensor xtensor-python fiona utm pyproj cartopy folium h5py

# Set the working directory
WORKDIR /LSDTopoTools

# Copy the startup script to install python stack
COPY install_lsdtt_python_packages.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/install_lsdtt_python_packages.sh

# Copy the script for fetching example data 
COPY Get_LSDTT_example_data.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/Get_LSDTT_example_data.sh
