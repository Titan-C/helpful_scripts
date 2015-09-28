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


with open('/home/oscar/keylog', 'r') as keyshom:
    data = keyshom.read()
sta = re.findall(r'KeyPress.*?\[(\w+)\]', data)
collstat = collections.Counter(sta)

print(collstat.most_common())
