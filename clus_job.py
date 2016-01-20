#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Created on Fri Jul 10 13:11:33 2015

@author: Óscar

Cluster job submission in Python
"""

from __future__ import division, absolute_import, print_function
import argparse
import subprocess

JOB_STRING = """
#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash

#$ -q {queue}
#$ -pe mpi {cpus}
#$ -N "{job_name}"
#$ -M oscar.najera-ocampo@u-psud.fr
#$ -m abe # (a = abort, b = begin, e = end)

export OPENBLAS_NUM_THREADS={blasth}

{mpi}{command}
"""

parser = argparse.ArgumentParser(description='Job submission script')
parser.add_argument('-l', '--loop', nargs='+', required=True,
                    help='Argument to loop over in the submission script')
parser.add_argument('-N', '--job_name', required=True,
                    help='Name for job.')
parser.add_argument('-bth', '--blasth', default=1, type=int)
parser.add_argument('-cp', '--cpus', default=12, type=int)
parser.add_argument('-q', '--queue', choices=['theo-ox.q', 'shared.q'],
                    default='theo-ox.q', help='(default: %(default)s)')
parser.add_argument('-mpi', action='store_const', default='',
                    const='mpirun -np $NSLOTS ', help='Use mpirun')
parser.add_argument('executable', nargs='+', help='executable instruction')
args = parser.parse_args()
dargs = vars(args)

# Loop over your jobs

command = ' '.join(args.executable) + ' '
if args.queue == 'shared.q':
    dargs['queue'] = 'shared.q\n#$ -l hostname=compute-0-19'
    dargs['cpus'] = 20

for loop in args.loop:
    # Open a pipe to the qsub command.
    job = subprocess.Popen('qsub',
                           stdin=subprocess.PIPE,
                           stdout=subprocess.PIPE,
                           stderr=subprocess.PIPE,
                          )
    # Customize your options here
    dargs['command'] = command + loop
    job_string = JOB_STRING.format(**dargs)


    # Send job_string to qsub
    stdout, stderr = job.communicate(job_string)
    print('qsub out: ', stdout, 'qsub err: ', stderr)
