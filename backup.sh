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

# Pull Backup from alina
echo "Creating Backups from alina ..."
pass=$(pass show alina/borgbackup)

REPOSITORY=ssh://me@localhost:10022//scratch/Backups/smal

ssh -R 10022:localhost:22 alina "sudo BORG_PASSPHRASE=$pass \
borg create --verbose --stats \
     --exclude '*.pyc' \
    $REPOSITORY::'{hostname}-{user}-{utcnow:%Y-%m-%dT%H:%M:%S}' \
     /decrypted /var/www /root /home /etc/letsencrypt"
