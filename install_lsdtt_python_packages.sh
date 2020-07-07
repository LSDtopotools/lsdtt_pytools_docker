#!/bin/bash

# This is a startup script to install local python implementations
# of the lsdtopotools stack
# It grabs and unpacks the example data
# it then builds the code from there. 
# Author: SMM
# Date: 07/07/2020

# First check to see if we have a python packages directory
if [ -d /LSDTopoTools/python_packages/ ]
  then
    echo "You have a python packages directory"
  else
    mkdir /LSDTopoTools/python_packages/ 
fi

# Now check for the various repos
# clone or pull the repo, depending on what is in there
# check if the files have been cloned
if [ -d /LSDTopoTools/python_packages/lsdtopytools/ ]
  then
    echo "The lsdtopytools repository exists, updating to the latest version."
    git --work-tree=/LSDTopoTools/python_packages/lsdtopytools --git-dir=/LSDTopoTools/python_packages/lsdtopytools/.git  pull origin master
  else
    echo "Cloning the LSDTopoTools2 repository"
    git clone https://github.com/LSDtopotools/lsdtopytools.git /LSDTopoTools/python_packages/lsdtopytools
fi

# Now install the wheel
BASE_DIR="/LSDTopoTools/"
LSDTT_XTSR_DIR="/LSDTopoTools/python_packages/lsdtopytools/wheels/lsdtt-xtensor-python"
LSDTT_LTPT_DIR="/LSDTopoTools/python_packages/lsdtopytools/wheels/lsdtopytools"

cd $LSDTT_XTSR_DIR
echo "The current directory is:"
echo $PWD
echo "Installing lsdtt-xtensor-python."
pip install lsdtt_xtensor_python-0.0.4-cp38-cp38-linux_x86_64.whl
echo "Installing lsdtopytools wrappers"
cd $LSDTT_LTPT_DIR
pip install lsdtopytools-0.0.4.1-py2.py3-none-any.whl
cd $BASE_DIR

# clone or pull the repo, depending on what is in there
# check if the files have been cloned
if [ -d /LSDTopoTools/python_packages/lsdviztools/ ]
  then
    echo "The lsdviztools repository exists, updating to the latest version."
    git --work-tree=/LSDTopoTools/python_packages/lsdviztools --git-dir=/LSDTopoTools/python_packages/lsdviztools/.git  pull origin master
  else
    echo "Cloning the LSDTopoTools2 repository"
    git clone https://github.com/LSDtopotools/lsdviztools.git /LSDTopoTools/python_packages/lsdviztools
fi

# Now install the package
echo "Installing lsdviztools."
BASE_DIR="/LSDTopoTools/"
LSDTT_VIZ_DIR="/LSDTopoTools/python_packages/lsdviztools"
cd $LSDTT_VIZ_DIR
pip install ./
cd $BASE_DIR


## clone or pull the repo, depending on what is in there
## check if the files have been cloned
#if [ -d /LSDTopoTools/python_packages/lsdtopyscraper/ ]
#  then
#    echo "The lsdtopyscraper repository exists, updating to the latest version."
#    git --work-tree=/LSDTopoTools/python_packages/lsdtopyscraper --git-dir=/LSDTopoTools/python_packages/lsdtopyscraper/.git  pull #origin master
#  else
#    echo "Cloning the lsdtopyscraper repository"
#    git clone https://github.com/LSDtopotools/lsdtopyscraper.git /LSDTopoTools/python_packages/lsdtopyscraper
#fi
#
## Now install the package
#echo "Installing lsdtopyscraper."
#BASE_DIR="/LSDTopoTools/"
#LSDTT_TPS_DIR="/LSDTopoTools/python_packages/lsdtopyscraper"
#cd $LSDTT_TPS_DIR
#pip install ./
#cd $BASE_DIR
