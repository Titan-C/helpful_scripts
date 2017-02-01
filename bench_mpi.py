#!/usr/bin/env python
# -*- coding: utf-8 -*-
r"""
Benchmark OpenMPI
=================

broadcast an array and scale with processor count?
"""
# Created Wed Feb  1 12:08:37 2017
# Author: Óscar Nájera

from __future__ import division, absolute_import, print_function

import numpy as np
from mpi4py import MPI

comm = MPI.COMM_WORLD
rank = comm.Get_rank()
N = 10000

if comm.rank == 0:
    data = np.arange(N, dtype='f')
else:
    data = np.empty(N, dtype='f')
comm.Bcast(data, root=0)

assert np.allclose(data, np.arange(N, dtype='f'))
print(rank)
