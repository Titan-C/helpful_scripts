#! /bin/bash

LIB=~/libs/
MAKEFLAGS="-j8"

mkdir -p ${LIB}


## cmake
inst_cmake() {
cmakev=cmake-3.1.2
wget http://www.cmake.org/files/v3.1/${cmake}.tar.gz  -O cmake.tar.gz
tar -xf cmake.tar.gz
cd ${cmakev}
./bootstrap --parallel=4 --prefix=${LIB}
make
make install
cd
}
## boost
inst_boost() {
boostv=boost_1_57_0
wget http://sourceforge.net/projects/boost/files/boost/1.57.0/boost_1_57_0.tar.gz
tar -xf ${boostv}.tar.gz
cd ${boostv}
./bootstrap.sh --prefix=${LIB} --with-toolset=gcc --with-icu
echo "using mpi ;" >> project-config.jam
./b2 \
      variant=release \
      debug-symbols=off \
      threading=multi \
      runtime-link=shared \
      link=shared,static \
      toolset=gcc \
      cflags="-O3 -pipe" \
      ${MAKEFLAGS} \
      install
cd
}

## hdf5
inst_hdf5() {
hdf5v=hdf5-1.8.14
wget http://www.hdfgroup.org/ftp/HDF5/current/src/hdf5-1.8.14.tar
tar -xf ${hdf5v}.tar
cd ${hdf5v}
./configure --prefix=${LIB} --disable-static \
    --enable-hl \
    --enable-threadsafe \
    --enable-linux-lfs \
    --enable-production \
    --with-pic \
    --disable-sharedlib-rpath
make
cd
}

## fftw
inst_fftw () {
fftwv=fftw-3.3.4
wget http://www.fftw.org/${fftwv}.tar.gz
tar -xf ${fftwv}.tar.gz
cd ${fftwv}
./configure --prefix=${LIB} --enable-openmp --enable-mpi --enable-sse --enable-sse2 --enable-avx CFLAGS="-O2"
make ${MAKEFLAGS}
make install
cd
}

## lapack
inst_lapack() {
lapackv=lapack-3.5.0
wget http://www.netlib.org/lapack/lapack-3.5.0.tgz
tar -xf ${lapackv}.tgz
cd ${lapackv}
install -d build
cd build
cmake ../ -DCMAKE_INSTALL_PREFIX=${LIB} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_SKIP_RPATH=ON \
    -DBUILD_SHARED_LIBS=ON \
    -DCMAKE_Fortran_COMPILER=gfortran \
    -DLAPACKE=ON
make ${MAKEFLAGS}
cd
}

## Anaconda
inst_anaconda() {
wget http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh -O miniconda.sh
chmod +x miniconda.sh
./miniconda.sh -b
export PATH=~/miniconda/bin:$PATH
conda update --yes conda
conda create --yes -n alps pip scipy numpy matplotlib hdf5
}

## local env
work_env() {
anacondainit
export LD_LIBRARY_PATH=${LIB}/lib:$LD_LIBRARY_PATH
source activate alps
}


## ALPS
inst_alps() {
alpsv=alps-2.2.b3-r7462-src
#wget http://alps.comp-phys.org/static/software/releases/${alpsv}.tar.gz
#tar -xf ${alpsv}.tar.gz
#cd ${alpsv}
mkdir build
cd build
export LD_LIBRARY_PATH=/home/oscar/libs/lib:$LD_LIBRARY_PATH
cmake ../alps/ -DCMAKE_INSTALL_PREFIX=${LIB} \
#         -DCMAKE_BINARY_DIR=./build \
          -DCMAKE_BUILD_TYPE=Release
make ${MAKEFLAGS}
make test
make install
}

inst_alps

# local boost mpi python
inst_mpipy () {
DIR=~/miniconda/envs/alps/lib/python2.7/site-packages/boost
mkdir -vp ${DIR}
cp -v mpi_py_init.py ${DIR}/__init__.py
cp -v /home/oscar/libs/lib/mpi.so ${DIR}/
}
inst_mpipy

