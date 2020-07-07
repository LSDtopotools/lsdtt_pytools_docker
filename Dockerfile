# This is the LSDTopoTools visualisation container
# It includes all the python packages needed to run LSDTopPyTools

# Pull base image. We start from the miniconda imade
FROM conda/miniconda3
MAINTAINER Simon Mudd (simon.m.mudd@ed.ac.uk) and Boris Gailleton (b.gailleton@sms.ed.ac.uk)

# Need this to shortcut the stupid tzdata noninteractive thing
ARG DEBIAN_FRONTEND=noninteractive


# Update conda
RUN conda install -y -c conda-forge conda

# Add the conda forge
RUN conda config --add channels conda-forge


# Set the channel
RUN conda config --set channel_priority strict

# Add git so you can clone the lsdmappingtools repo
RUN conda install -y git python=3

# Now add some conda packages
RUN conda install -y gdal rasterio geopandas matplotlib=3.1 numpy scipy pytables numba feather-format pandas pip pybind11 xtensor xtensor-python

# Some of the plotting tools use ffmpeg
RUN conda install -y ffmpeg

# Some tools for fetching data
RUN conda install -y lsdtopotools

# Now add more to the geospatial stack
RUN conda install -y fiona utm pyproj cartopy

# Now the ipython stack for creating local ipython servers
RUN conda install -y ipython ipykernel

# Now an environment for building conda
RUN conda install -y conda-build

# Some tools for fetching data
RUN conda install -y wget unzip

# Now install the final bits for you jupyterhub functionality
# and some web mapping
RUN conda install -y jupyter folium

# Now we need some stuff to get lsdtopytools to install
RUN apt-get update && apt-get install -y \
    build-essential \
    libfftw3-dev \
&& rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /LSDTopoTools

# Get hdf5
RUN conda install -y h5py

# Copy the startup script to install python stack
COPY install_lsdtt_python_packages.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/install_lsdtt_python_packages.sh

# Copy the script for fetching example data 
COPY Get_LSDTT_example_data.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/Get_LSDTT_example_data.sh
