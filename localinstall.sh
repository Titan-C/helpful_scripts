#! /bin/bash

LIB=~/libs/
mkdir ${LIB}


## cmake
cmakev=cmake-3.1.2
wget http://www.cmake.org/files/v3.1/${cmake}.tar.gz  -O cmake.tar.gz
tar -xf cmake.tar.gz
cd ${cmakev}
./bootstrap --parallel=4 --prefix=${LIB}
make
make install
cd

## boost
## fftw
fftwv=fftw-3.3.4
wget http://www.fftw.org/${fftwv}.tar.gz
tar -xf ${fftwv}.tar.gz
cd ${fftwv}
./configure --prefix=${LIB} --enable-openmp --enable-mpi --enable-sse --enable-sse2 --enable-avx CFLAGS="-O2"
make -j8
make install
cd


## Anaconda
wget http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh -O miniconda.sh
chmod +x miniconda.sh
./miniconda.sh -b
export PATH=~/miniconda/bin:$PATH
conda update --yes conda

