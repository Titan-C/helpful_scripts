#! /bin/bash

# I assume a conda env is already loaded to work on
# If not, make one and then re-source this file


export BUILD_DIR=$HOME/builds/$BD
mkdir -p $BUILD_DIR
cd $BUILD_DIR

export CC=gcc
export CXX=g++
export FC=gfortran
# export CC=icc
# export CXX=icpc
# export FC=ifort

MAKEFLAGS="-j8"

inst_dev() {
inst_anaconda
inst_new_pyenv hpc2_be 2
inst_binutils
inst_gmp
inst_mpfr
inst_mpc
inst_isl
inst_gcc 5.3.0
inst_cmake
inst_openmpi

inst_openblas
inst_hdf5
inst_fftw
inst_gsl
inst_boost
inst_alps
inst_triqs
inst_cthyb
}

## cmake
inst_cmake() {
cmakev=cmake-3.4.1
wget --no-check-certificate http://www.cmake.org/files/v3.4/${cmakev}.tar.gz || exit 1
tar -xf ${cmakev}.tar.gz
cd ${cmakev}
./bootstrap --parallel=4 --prefix=${CONDA_ENV_PATH}
make ${MAKEFLAGS}
make install
cd ${BUILD_DIR}
}

## binutils
inst_binutils () {
binutilsv=binutils-2.25.1
wget http://ftp.gnu.org/gnu/binutils/${binutilsv}.tar.gz
tar -xf ${binutilsv}.tar.gz
cd ${binutilsv}
./configure --prefix=${CONDA_ENV_PATH}
make
make install
cd ${BUILD_DIR}
}

## boost
inst_boost() {
boostv=boost_1_58_0
wget http://sourceforge.net/projects/boost/files/boost/1.58.0/${boostv}.tar.gz
tar -xf ${boostv}.tar.gz
cd ${boostv}
./bootstrap.sh --prefix=${CONDA_ENV_PATH} --with-toolset=gcc --with-icu
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
cd ${BUILD_DIR}
}

## hdf5
inst_hdf5() {
hdf5v=hdf5-1.8.16
wget ftp://ftp.hdfgroup.org/HDF5/current/src/${hdf5v}.tar.bz2
tar -xf ${hdf5v}.tar.bz2
cd ${hdf5v}
./configure --prefix=${CONDA_ENV_PATH} --disable-static \
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
cd ${BUILD_DIR}
}

## fftw
inst_fftw () {
fftwv=fftw-3.3.4
wget http://www.fftw.org/${fftwv}.tar.gz
tar -xf ${fftwv}.tar.gz
cd ${fftwv}
./configure --prefix=${CONDA_ENV_PATH} --enable-openmp --enable-mpi --enable-shared --enable-threads --enable-sse2 --enable-avx CFLAGS="-O2"
make ${MAKEFLAGS}
make install
cd ${BUILD_DIR}
}

## Openblas
inst_openblas() {
op_ver=0.2.15
wget http://github.com/xianyi/OpenBLAS/archive/v${op_ver}.tar.gz
tar -xf v${op_ver}.tar.gz
cd OpenBLAS-${op_ver}
make DYNAMIC_ARCH=1
make PREFIX=${CONDA_ENV_PATH} install
cd ${CONDA_ENV_PATH}/lib/
ln -sf libopenblas.so libblas.so
ln -sf libopenblas.so liblapack.so
cd ${BUILD_DIR}
}

## GSL
inst_gsl() {
gslv=gsl-2.1
wget http://mirror.ibcp.fr/pub/gnu/gsl/${gslv}.tar.gz
tar -xf ${gslv}.tar.gz
cd ${gslv}
./configure --prefix=${CONDA_ENV_PATH}
make ${MAKEFLAGS}
make install
cd ${BUILD_DIR}
}


## Anaconda
python_pack='matplotlib hdf5 h5py ipython
    jinja2 pep8 pillow pyflakes pytest cython numba
    sphinx spyder coverage nose rope tornado jsonschema numpydoc mistune
    joblib pylint flake8 jupyter line_profiler pandas sympy'
python_pip='mako pytest-cov mpi4py'

inst_anaconda() {
wget http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
chmod +x miniconda.sh
./miniconda.sh -b
export PATH=~/miniconda3/bin:$PATH
}

inst_new_pyenv() {
conda update --yes conda
conda create --yes -n $1 python=$2 pip
source activate $1
conda install ${python_pack}
pip install gnureadline
echo "remember to delete the venv openblas to use local one"
echo "then reinstall numpy & scipy from source with local blas"
}

inst_numpy_or_scipy() {
    python setup.py config_fc --fcompiler=gnu95 build ${MAKEFLAGS}
    python setup.py config_fc --fcompiler=gnu95 install --optimize=1
    python setup.py install
    }

## ALPS
inst_alps() {
alpsv=alps-2.2.b3-r7462-src
wget http://alps.comp-phys.org/static/software/releases/${alpsv}.tar.gz
tar -xf ${alpsv}.tar.gz
cd ${alpsv}
mkdir build
cd build
cmake ../alps/ -DCMAKE_INSTALL_PREFIX=${CONDA_ENV_PATH} \
          -DCMAKE_BUILD_TYPE=Release
make ${MAKEFLAGS}
make test
make install
cd ${BUILD_DIR}
}


# Triqs
inst_triqs() {
mkdir -p buildtriqs
cd buildtriqs
cmake -DCMAKE_INSTALL_PREFIX=${CONDA_ENV_PATH} -DUSE_CPP14=ON ~/dev/triqs/ || exit 1
make ${MAKEFLAGS} || exit 1
make test || exit 1
make install || exit 1
cd ${BUILD_DIR}
}

inst_cthyb() {
mkdir -p buildcthyb
cd buildcthyb
cmake -DTRIQS_PATH=${CONDA_ENV_PATH} ~/dev/cthyb || exit 1
make ${MAKEFLAGS} || exit 1
make test || exit 1
make install || exit 1
cd ${BUILD_DIR}
}

# local boost mpi python
inst_mpipy () {
DIR=~/miniconda/envs/dev/lib/python2.7/site-packages/boost
mkdir -vp ${DIR}
cp -v mpi_py_init.py ${DIR}/__init__.py
cp -v ${CONDA_ENV_PATH}lib/mpi.so ${DIR}/
}

# install gmp
inst_gmp () {
gmpv=gmp-6.1.0
wget https://gmplib.org/download/gmp/${gmpv}.tar.bz2
tar jxf ${gmpv}.tar.bz2
cd ${gmpv}
./configure --prefix=${CONDA_ENV_PATH} --enable-cxx
make ${MAKEFLAGS}
make check
make install
cd ${BUILD_DIR}
}

# install mpfr
inst_mpfr () {
mpfrv=mpfr-3.1.3
wget http://www.mpfr.org/mpfr-current/${mpfrv}.tar.bz2
tar -xf ${mpfrv}.tar.bz2
cd ${mpfrv}
./configure --prefix=${CONDA_ENV_PATH} --with-gmp=${CONDA_ENV_PATH}
make ${MAKEFLAGS} && make check && make install
cd ${BUILD_DIR}
}

# install mpc
inst_mpc () {
mpcv=mpc-1.0.3
wget ftp://ftp.gnu.org/gnu/mpc/${mpcv}.tar.gz
tar -xf ${mpcv}.tar.gz
cd ${mpcv}
./configure --prefix=${CONDA_ENV_PATH} --with-gmp=${CONDA_ENV_PATH}
make ${MAKEFLAGS} && make check && make install
cd ${BUILD_DIR}
}

# install isl
inst_isl () {
islv=isl-0.14
wget http://isl.gforge.inria.fr/${islv}.tar.bz2
tar -xf ${islv}.tar.bz2
cd ${islv}
./configure --prefix=${CONDA_ENV_PATH} --with-gmp-prefix=${CONDA_ENV_PATH}
make ${MAKEFLAGS} && make check && make install
cd ${BUILD_DIR}
}


# install gcc
inst_gcc () {
gccv=gcc-$1
wget ftp://gcc.gnu.org/pub/gcc/releases/${gccv}/${gccv}.tar.gz || exit 1
tar -xf ${gccv}.tar.gz
cd ${gccv}
patch ./contrib/download_prerequisites $HOME/dev/helpful_scripts/gcc_prereq.patch
./contrib/download_prerequisites
cd ..
mkdir build_${gccv} && cd build_${gccv}
../${gccv}/configure --prefix=${CONDA_ENV_PATH} --enable-checking=release --disable-multilib \
   --enable-languages=c,c++,fortran
make ${MAKEFLAGS} && make install
cd ${BUILD_DIR}
}

#install openmpi
inst_openmpi () {
ompiv=openmpi-1.10.1
wget http://www.open-mpi.org/software/ompi/v1.10/downloads/${ompiv}.tar.bz2
tar -xf ${ompiv}.tar.bz2
cd ${ompiv}
./configure --prefix=${CONDA_ENV_PATH}
make ${MAKEFLAGS} && make all install
cd ${BUILD_DIR}
}
