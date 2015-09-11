#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Created on Fri Jul 10 13:11:33 2015

@author: Óscar

Cluster job submission in Python
"""

#
import argparse
import subprocess
import time


JOB_STRING = """
#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash

#$ -q {queue}
#$ -pe mpi {cpus}
#$ -N {job_name}
#$ -M oscar
#$ -m abe # (a = abort, b = begin, e = end)

anacondainit

export OPENBLAS_NUM_THREADS={blasth}

{executable}
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

job_name = dargs.pop('job_name')
command = ' '.join(args.executable) + ' '
if args.queue == 'shared.q':
    dargs['queue'] = 'shared.q\n#$ -l hostname=compute-0-19'
    dargs['cpus'] = 20

for loop in args.loop:
#    # Open a pipe to the qsub command.
    job = subprocess.Popen('qsub',
                        stdin=subprocess.PIPE,
                        #stdout=subprocess.PIPE,
                        )
#
#    # Customize your options here
    dargs['job_name'] = job_name + loop
    dargs['executable'] = args.mpi + command + loop
    job_string = JOB_STRING.format(**dargs)
    print(job_string)

#    # Send job_string to qsub
    job.communicate(job_string)

