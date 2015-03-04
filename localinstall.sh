#! /bin/bash

LIB=/home/oscar/libns/
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
boostv=boost_1_55_0
wget http://sourceforge.net/projects/boost/files/boost/1.55.0/${boostv}.tar.gz
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
wget http://www.hdfgroup.org/ftp/HDF5/current/src/${hdf5v}.tar
tar -xf ${hdf5v}.tar
cd ${hdf5v}
./configure --prefix=${LIB} --disable-static \
    --enable-hl \
    --enable-threadsafe \
    --enable-linux-lfs \
    --enable-production \
    --with-pic \
    --disable-sharedlib-rpath
make ${MAKEFLAGS}
make check
make install
make check-install
cd ..
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
wget http://www.netlib.org/lapack/${lapackv}.tgz
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
conda create --yes -n triqs pip scipy numpy matplotlib hdf5 h5py ipython \
    jinja2 numba pep8 pillow pip pyflakes mpi4py pytest cython numba \
    sphinx spyder
source activate triqs
pip install mako
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
wget http://alps.comp-phys.org/static/software/releases/${alpsv}.tar.gz
tar -xf ${alpsv}.tar.gz
cd ${alpsv}
mkdir build
cd build
export LD_LIBRARY_PATH=/home/oscar/libs/lib:$LD_LIBRARY_PATH
cmake ../alps/ -DCMAKE_INSTALL_PREFIX=${LIB} \
          -DCMAKE_BUILD_TYPE=Release
make ${MAKEFLAGS}
make test
make install
}


# local boost mpi python
inst_mpipy () {
DIR=~/miniconda/envs/alps/lib/python2.7/site-packages/boost
mkdir -vp ${DIR}
cp -v mpi_py_init.py ${DIR}/__init__.py
cp -v /home/oscar/libs/lib/mpi.so ${DIR}/
}

# install gmp
inst_gmp () {
wget ftp://gcc.gnu.org/pub/gcc/infrastructure/gmp-4.3.2.tar.bz2
bunzip2 gmp-4.3.2.tar.bz2
tar xf gmp-4.3.2.tar
cd gmp-4.3.2
./configure --prefix=${LIB} --enable-cxx
make -j8
make check
make install
cd
}

# install mpfr
inst_mpfr () {
mpfrv=mpfr-2.4.2
wget ftp://gcc.gnu.org/pub/gcc/infrastructure/${mpfrv}.tar.bz2
tar -xf ${mpfrv}.tar.bz2
cd ${mpfrv}
./configure --prefix=${LIB} --with-gmp=${LIB}
make ${MAKEFLAGS} && make check && make install
cd
}

# install mpc
inst_mpc () {
mpcv=mpc-0.8.1
wget ftp://gcc.gnu.org/pub/gcc/infrastructure/${mpcv}.tar.gz
tar -xf ${mpcv}.tar.gz
cd ${mpcv}
./configure --prefix=${LIB} --with-gmp=${LIB}
make ${MAKEFLAGS} && make check && make install
cd
}

# install gcc
inst_gcc () {
gccv=gcc-4.9.2
wget ftp://gcc.gnu.org/pub/gcc/releases/${gccv}/${gccv}.tar.gz
tar -xf ${gccv}.tar.gz
mkdir build_${gccv} && cd build_${gccv}
../${gccv}/configure --prefix=${LIB} --enable-checking=release --with-gmp=${LIB} \
    --with-mpfr=${LIB} --with-mpc=${LIB} --disable-multilib
make ${MAKEFLAGS} && make install
cd
}
