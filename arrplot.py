#!/usr/bin/env python
# -*- coding: utf-8 -*-
r"""
Plots stored numpy arrays from the shell
"""
# Created Wed Jan 20 18:00:00 2016
# Author: Óscar Nájera

from __future__ import division, absolute_import, print_function
import argparse
import numpy as np
import matplotlib.pyplot as plt
import dmft.common as gf


parser = argparse.ArgumentParser(description='Plot npy files')
parser.add_argument('file', help='File containing the ndarray')
parser.add_argument('-T', '--transpose', action='store_true',
                    help='Transpose the shape of the array for plotting')
parser.add_argument('-b', '--beta', metavar='B', type=float,
                    help='The inverse temperature')


def main():
    args = parser.parse_args()
    array = np.load(args.file)
    if args.transpose:
        array = np.transpose(array)

    print('The inspected array has a shape: {}'.format(array.shape))
    x = np.arange(len(array))
    if args.beta:
        x = gf.matsubara_freq(args.beta, len(array))
    if 'complex' in str(array.dtype):
        plt.plot(x, array.real, '--')
        plt.plot(x, array.imag, '-')
        plt.title('-- is real, - is imaginary')
    else:
        plt.plot(x, array)

    plt.show()

if __name__ == '__main__':
    main()
