#! /bin/bash

LIB=/home/oscar/libs/
MAKEFLAGS="-j8"

export CC=gcc
export CXX=g++
export FC=gfortran
# export CC=icc
# export CXX=icpc
# export FC=ifort
mkdir -p ${LIB}

inst_dev() {
inst_gcc
inst_gmp
inst_cmake
inst_binutils
inst_openmpi

inst_openblas
inst_hdf5
inst_fftw
inst_gsl
inst_boost
inst_alps
inst_triqs
}

## cmake
inst_cmake() {
cmakev=cmake-3.1.2
wget http://www.cmake.org/files/v3.1/${cmakev}.tar.gz
tar -xf ${cmakev}.tar.gz
cd ${cmakev}
./bootstrap --parallel=4 --prefix=${LIB}
make ${MAKEFLAGS}
make install
cd
}

## binutils
inst_binutils () {
binutilsv=binutils-2.25
wget http://ftp.gnu.org/gnu/binutils/${binutilsv}tar.gz
tar -xf ${binutilsv}tar.gz
cd ${binutilsv}
./configure --prefix=${LIB}
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
wget ftp://ftp.hdfgroup.org/HDF5/current/src/${hdf5v}.tar.bz2
tar -xf ${hdf5v}.tar.bz2
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
cd
}

## fftw
inst_fftw () {
fftwv=fftw-3.3.4
wget http://www.fftw.org/${fftwv}.tar.gz
tar -xf ${fftwv}.tar.gz
cd ${fftwv}
./configure --prefix=${LIB} --enable-openmp --enable-mpi --enable-shared --enable-threads --enable-sse2 --enable-avx CFLAGS="-O2"
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

## Openblas
inst_openblas() {
op_ver=0.2.14
wget http://github.com/xianyi/OpenBLAS/archive/v${op_ver}.tar.gz
tar -xf v${op_ver}.tar.gz
cd OpenBLAS-${op_ver}
make DYNAMIC_ARCH=1
make PREFIX=${LIB} install
cd ${LIB}/lib/
ln -sf libopenblas.so libblas.so
ln -sf libopenblas.so liblapack.so
cd
}

## GSL
inst_gsl() {
gslv=gsl-1.16
wget http://mirror.ibcp.fr/pub/gnu/gsl/${gslv}.tar.gz
tar -xf ${gslv}.tar.gz
cd ${gslv}
./configure --prefix=${LIB}
make ${MAKEFLAGS}
make install
cd
}


## Anaconda
inst_anaconda() {
wget http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh -O miniconda.sh
chmod +x miniconda.sh
./miniconda.sh -b
export PATH=~/miniconda/bin:$PATH
conda update --yes conda
conda create --yes -n dev pip scipy numpy matplotlib hdf5 h5py ipython \
    jinja2 numba pep8 pillow pyflakes pytest cython numba \
    sphinx spyder coverage nose rope tornado jsonschema numpydoc mistune
source activate dev
pip install mako
pip install mpi4py
}

## local env
work_env() {
anacondainit
export LD_LIBRARY_PATH=${LIB}/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=${LIB}/libs/lib64:$LD_LIBRARY_PATH

source activate dev
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
cd
}


# Triqs
inst_triqs() {
mkdir -p buildtriqs
cd buildtriqs
cmake -DCMAKE_INSTALL_PREFIX=${LIB} -DUSE_CPP14=ON -DBoost_INCLUDE_DIR=${LIB}/include/ ~/dev/triqs/
make ${MAKEFLAGS}
make test
make install
cd ..

mkdir -p buildcthyb
cd buildcthyb
cmake -DTRIQS_PATH=${LIB} ../cthyb
make ${MAKEFLAGS}
make test
make install
cd ..
}

# local boost mpi python
inst_mpipy () {
DIR=~/miniconda/envs/dev/lib/python2.7/site-packages/boost
mkdir -vp ${DIR}
cp -v mpi_py_init.py ${DIR}/__init__.py
cp -v ${LIB}lib/mpi.so ${DIR}/
}

# install gmp
inst_gmp () {
wget ftp://gcc.gnu.org/pub/gcc/infrastructure/gmp-4.3.2.tar.bz2
bunzip2 gmp-4.3.2.tar.bz2
tar xf gmp-4.3.2.tar
cd gmp-4.3.2
./configure --prefix=${LIB} --enable-cxx
make ${MAKEFLAGS}
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
cd ${gccv}
./contrib/download_prerequisites
cd ..
mkdir build_${gccv} && cd build_${gccv}
../${gccv}/configure --prefix=${LIB} --enable-checking=release --disable-multilib
make ${MAKEFLAGS} && make install
cd
}

#install openmpi
inst_openmpi () {
ompiv=openmpi-1.8.4
#wget http://www.open-mpi.org/software/ompi/v1.8/downloads/${ompiv}.tar.bz2
tar -xf ${ompiv}.tar.bz2
cd ${ompiv}
./configure --prefix=${LIB}
make ${MAKEFLAGS} && make all install
cd
}
