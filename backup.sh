#! /bin/bash

rsync -av --del ~/Documents ~/Dropbox ~/MEGA /scratch/oscar/

# external program to supply the passphrase:
export BORG_PASSCOMMAND='pass show borgbackup'

# Create Local Backups
echo $( date ) "Creating Local Backups ..."
REPOSITORY=/scratch/Backups/code_dev
borg create --verbose --stats --compression=lz4 \
     --exclude '*.pyc' \
    $REPOSITORY::'{hostname}-{user}-{utcnow:%Y-%m-%dT%H:%M:%S}' \
    ~/dev ~/.mail/ ~/Documents/ ~/Dropbox/ ~/ownCloud/ ~/MEGA/

# Prune Local Backups
echo $( date ) "Pruning local repository ..."

borg prune --verbose --stats --list \
     --keep-daily 7 \
     --keep-weekly 4 \
     --keep-monthly 6 $REPOSITORY

# Pull Backup from alina
echo $( date ) "Creating Backups from alina ..."
pass=$(pass show alina/borgbackup)

REPOSITORY=ssh://me@localhost:10022//scratch/Backups/smal

echo $( date ) "Opening connection ..."
ssh -R 10022:localhost:22 alina "echo 'starting borg ...'; \
sudo BORG_PASSPHRASE=$pass \
borg create --verbose --stats \
     --exclude '*.pyc' \
    $REPOSITORY::'{hostname}-{user}-{utcnow:%Y-%m-%dT%H:%M:%S}' \
     /decrypted /var/www /root /home /etc/letsencrypt"


# Prune alina Backups
REPOSITORY=/scratch/Backups/smal
export BORG_PASSCOMMAND='pass show alina/borgbackup'
echo $( date ) "Pruning alina repository ..."
borg prune --verbose --stats --list \
     --keep-daily 7 \
     --keep-weekly 4 \
     --keep-monthly 6 $REPOSITORY
