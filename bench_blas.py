#!/usr/bin/env ipython
# -*- coding: utf-8 -*-
r"""
Quick benckmark that OpenBlas is used for numpy
"""
# Created Sun Jan  3 14:54:50 2016
# Author: Óscar Nájera

from __future__ import division, absolute_import, print_function
from IPython import get_ipython
import numpy as np

np.__config__.show()

for N in [1000, 2000, 4000]:
    a = np.random.rand(N, N)
    print("Matrix multiplication N=" + str(N))
    get_ipython().run_cell('time c = np.dot(a, a)')
