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
    git --work-tree=/LSDTopoTools/LSDTopoTools2 --git-dir=/LSDTopoTools/LSDTopoTools2/.git  pull origin master
  else
    echo "Cloning the LSDTopoTools2 repository"
    git clone https://github.com/LSDtopotools/LSDTopoTools2.git /LSDTopoTools/LSDTopoTools2
fi

# Change the working directory to that of LSDTopoTools2/src
echo "I am going to try to build LSDTopoTools2."
cd /LSDTopoTools/LSDTopoTools2/src
#echo "The current directory is:"
#echo $PWD
echo "Calling the build script."
sh build.sh

# Now update the path
echo "Now I'll add the LSDTopoTools command line programs to your path."
export PATH=/LSDTopoTools/LSDTopoTools2/bin:$PATH
echo "Your path is now:"
echo $PATH
exec /bin/bash

