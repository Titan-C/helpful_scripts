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


with open('/home/oscar/keylog', 'r') as keyshom:
    data = keyshom.read()
sta = re.findall(r'KeyPress.*?\[(\w+)\]', data)
perstats = [(keystr, sta.count(keystr)) for keystr in set(sta)]
sorted_list = sorted(perstats, key=lambda x: x[1])

print(sorted_list)
