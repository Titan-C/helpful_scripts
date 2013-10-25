#! /bin/bash

rsync -av --del ~/ /run/media/oscar/BackUP/oscar/ --exclude={Downloads,Videos,Archiver,Music,.*}

rsync -av --remove-source-files ~/Archiver/ /run/media/oscar/BackUP/oscar/Archiver/
rm -r ~/Archiver/*
