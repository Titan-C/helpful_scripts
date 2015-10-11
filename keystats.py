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
parser.add_argument('-txt', action='store_true',
                    help='is it a text file?')

arguments = parser.parse_args()


with open(arguments.file, 'r') as keyshom:
    data = keyshom.read()

if not arguments.txt:
    data = re.findall(r'KeyPress.*?\[(\w+)\]', data)

collstat = collections.Counter(data)

print('Most typed characters')
for i, (char, count) in enumerate(collstat.most_common()):
    print(i, char, count)

if arguments.txt:
    pair_data = re.findall(r'(\w.)', data) + re.findall(r'(.\w)', data)
else:
    pair_data = list(zip(data[:-1], data[1:])) + list(zip(data[1:], data[:-1]))

pair_stat = collections.Counter(pair_data)
print('Most recurrent key successions')
for i, (pair, count) in enumerate(pair_stat.most_common(50)):
    print(i, pair, count)
