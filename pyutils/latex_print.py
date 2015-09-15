# -*- coding: utf-8 -*-
r"""
Helper function to assist my orgmode editing
============================================
"""
# Created Tue Sep 15 18:46:42 2015
# Author: Óscar Nájera

from __future__ import division, absolute_import, print_function
import sympy


def platex(*args):
    """Call sympy latex print over arguments """

    print(r'\begin{equation}')

    new_arguments = [sympy.latex(arg) for arg in args]

    print(*new_arguments)
    print(r'\end{equation}')
