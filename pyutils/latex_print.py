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
    """Call sympy latex print over arguments

    Parameters
    ----------
    *args: as many sympy expressions as wanted is the same latex
       equation environment
    """

    print(r'\begin{equation}')

    new_arguments = [sympy.latex(arg) for arg in args]

    print(*new_arguments)
    print(r'\end{equation}')


def ket(base, names=[r"\uparrow", r"\downarrow"]):
    """Trasforms a binary number into its Ket form
    Parameters:
        base (int): number representing the state
        names (list): names of individual basis states
    Returns:
        str : latex string of ket
    """

    binary_base = "{{:0{}b}}".format(len(names)).format(base)
    ketstr = r"|"

    for state, name in zip(binary_base[::-1], names):
        if int(state):
            ketstr += name + " "
    if base == 0:
        ketstr += r"\emptyset"

    return ketstr + r"\rangle"
