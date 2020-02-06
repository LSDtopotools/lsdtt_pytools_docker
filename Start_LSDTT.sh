#!/bin/bash

# This is a startup script for LSDTopoTools
# It clones the LSDTopoTools2 repository into the LSDTopoTools directory
# it then builds the code from there. 
# Author: SMM
# Date: 08/10/2018

# clone or pull the repo, depending on what is in there
# check if the files have been cloned
if [ -f /LSDTopoTools/LSDTopoTools2/src/LSDRaster.cpp ]
  then
    echo "The LSDTopoTools2 repository exists, updating to the latest version."
    git --work-tree=/LSDTopoTools/lsdtopytools --git-dir=/LSDTopoTools/lsdtopytools/.git  pull origin master
  else
    echo "Cloning the LSDTopoTools2 repository"
    git clone https://github.com/LSDtopotools/lsdtopytools.git /LSDTopoTools/lsdtopytools
fi

