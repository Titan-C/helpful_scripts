#! /bin/bash

rsync -av --del ~/Documents ~/Dropbox ~/MEGA /scratch/oscar/

# external program to supply the passphrase:
export BORG_PASSCOMMAND='pass show borgbackup'

# Create Backups
echo "Creating Backups ..."
REPOSITORY=/scratch/Backups/code_dev
borg create --verbose --stats --compression=lz4 \
     --exclude '*.pyc' \
    $REPOSITORY::'{hostname}-{user}-{utcnow:%Y-%m-%dT%H:%M:%S}' \
    ~/dev ~/.mail/ ~/Documents/ ~/Dropbox/ ~/ownCloud/ ~/MEGA/
