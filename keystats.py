#!/usr/bin/env python
# -*- coding: utf-8 -*-
r"""
Follow statistics of my keystrokes
==================================
"""
# Created Wed Sep 16 18:40:15 2015
# Author: Óscar Nájera

from __future__ import division, absolute_import, print_function
import re
import collections
import argparse

parser = argparse.ArgumentParser(description='Key press statistics')
parser.add_argument('-file', default='/home/oscar/keylog',
                    help='Key pressing log file')
arguments = parser.parse_args()

with open(arguments.file, 'r') as keyshom:
    data = keyshom.read()
sta = re.findall(r'KeyPress.*?\[(\w+)\]', data)
collstat = collections.Counter(sta)

print(collstat.most_common())
