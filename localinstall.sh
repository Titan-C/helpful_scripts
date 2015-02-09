#! /bin/bash

LIB=~/libs/

mkdir $LIB


## cmake
cmakev=cmake-3.1.2
wget http://www.cmake.org/files/v3.1/$cmake.tar.gz  -O cmake.tar.gz
tar -xf cmake.tar.gz
cd $cmakev
./bootstrap --parallel=4 --prefix=$LIB
make
make install

## boost
## fftw
## Anaconda
wget http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh -O miniconda.sh
chmod +x miniconda.sh
./miniconda.sh -b
export PATH=~/miniconda/bin:$PATH
conda update --yes conda

