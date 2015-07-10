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
#$ -M najera.oscar@gmail.com
#$ -m abe # (a = abort, b = begin, e = end)

export OPENBLAS_NUM_THREADS=1

#anacondainit

{executable}
"""

parser = argparse.ArgumentParser(description='Job submission script')
parser.add_argument('-l', '--loop', nargs='+', required=True,
                    help='Argument to loop over in the submission script')
parser.add_argument('-n', '--job_name', required=True,
                    help='Name for job. Accepts format braces, joins loop')
parser.add_argument('-cp', '--cpus', default=12, type=int)
parser.add_argument('-q', '--queue', choices=['theo-ox.q', 'shared.q'],
                    default='theo-ox.q', help='(default: %(default)s)')
parser.add_argument('-mpi', action='store_const', default='',
                    const='mpirun -np $NSLOTS ')
parser.add_argument('executable', nargs='+', help='executable instruction')
args = parser.parse_args()
dargs = vars(args)

# Loop over your jobs

job_name = dargs.pop('job_name')
for loop in args.loop:
#    # Open a pipe to the qsub command.
    job = subprocess.Popen('qsub',
                        stdin=subprocess.PIPE,
                        #stdout=subprocess.PIPE,
                        )
#
#    # Customize your options here
    dargs['job_name'] = job_name.format(loop)
    dargs['executable'] = args.mpi + ' '.join(args.executable) + ' ' + loop
    job_string = JOB_STRING.format(**dargs)

#    # Send job_string to qsub
    job.communicate(job_string)

