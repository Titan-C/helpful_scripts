#!/usr/bin/env ipython
# -*- coding: utf-8 -*-
r"""
Quick benckmark that OpenBlas is used for numpy
"""
# Created Sun Jan  3 14:54:50 2016
# Author: Óscar Nájera

from __future__ import division, absolute_import, print_function
import ctypes
import numpy as np
from IPython import get_ipython


def num_threads(cores):
    try:
        cdll = ctypes.CDLL('libmkl_rt.so')
        cdll.mkl_set_num_threads(ctypes.byref(ctypes.c_int(cores)))
        print(cdll.mkl_get_max_threads())
        return
    except OSError:
        pass

    try:
        cdll = ctypes.CDLL('libopenblas.so')
        cdll.openblas_set_num_threads(int(cores))
        print(cdll.openblas_get_num_threads())
        return
    except OSError:
        pass

    raise OSError('Unknow blas library')


def run_bench(threads=None):
    if threads is not None:
        num_threads(threads)
    for N in [1000, 2000, 4000]:
        a = np.random.rand(N, N)
        print("Matrix multiplication N=" + str(N))
        get_ipython().magic('time c = np.dot(a, a)')


def main():
    np.__config__.show()
    print('\n On system default thread numbers')
    run_bench()
    print('\n\n Forced to single thread')
    run_bench(1)
    print('\n\n Forced to two threads')
    run_bench(2)


if __name__ == '__main__':
    main()
