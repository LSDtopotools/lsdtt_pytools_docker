# This is the full lsdtopytools container
# It includes all the python packages needed to run both lsdtopytools and lsdviztools
# lsdtopytools and lsdviztools are installed
# lsdtt command line tools are also installed
# As is the jupyter notebook which you can start with 
# jupyter notebook --ip 0.0.0.0 --port 8888 --no-browser --allow-root

# Pull base image. We start from the mambaforge image
FROM condaforge/mambaforge
MAINTAINER Simon Mudd (simon.m.mudd@ed.ac.uk) and Boris Gailleton (b.gailleton@sms.ed.ac.uk)

# Need this to shortcut the stupid tzdata noninteractive thing
ARG DEBIAN_FRONTEND=noninteractive

# We need to change the python version
RUN mamba install -y python=3.8

# We need some stuff to get lsdtopytools to install
RUN apt-get update && apt-get install -y \
    build-essential \
    libfftw3-dev \
&& rm -rf /var/lib/apt/lists/*




# Some tools for fetching data
RUN conda install -y wget unzip

# Some of the plotting tools use ffmpeg
RUN conda install -y ffmpeg

# Install topotools command line interface
RUN conda install -y lsdtopotools

# Now an environment for building conda
RUN conda install -y conda-build

# Now mamba since it is faster than conda
RUN conda install -y mamba

# Add git 
RUN mamba install -y git

# Now the correct version of python
RUN mamba install -y python=3.8

# Now the ipython stack for creating local ipython servers
RUN mamba install -y ipython ipykernel jupyter jupyter-book

# Now add some conda packages
RUN mamba install -y gdal rasterio geopandas matplotlib numpy scipy pytables numba feather-format pandas pip pybind11 xtensor xtensor-python fiona utm pyproj cartopy folium h5py descartes

# Add viztools and paramselector
RUN pip install lsdviztools lsdttparamselector

# Add lsdtopytools
RUN mamba install -y lsdtt-xtensor-python

# Add lsdtopytools
RUN mamba install -y lsdtopytools

# Set the working directory
WORKDIR /LSDTopoTools

# Copy the script for fetching example data
COPY Get_LSDTT_example_data.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/Get_LSDTT_example_data.sh
