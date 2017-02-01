# -*- coding: utf-8 -*-
r"""
study mpi data
"""
# Created Wed Feb  1 15:18:40 2017
# Author: Óscar Nájera

from __future__ import division, absolute_import, print_function
from glob import glob
import re
import numpy as np
import matplotlib.pyplot as plt


files = glob('test*.o*')
num = np.array([int(re.findall('mpib(\d+)\.o', fid)[0]) for fid in files])

print(files, num)
times = []
for fid in files:
    with open(fid, 'r') as fid:
        content = fid.read()
        times.append(re.findall('\w+\s+\dm([\d\.]+)s', content, re.M))
sorsi = np.argsort(num)
times = np.array(times, dtype=np.float)[sorsi]
num = num[sorsi]
plt.plot(num, times)
plt.show()
