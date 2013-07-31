#! /bin/bash

EXTENSIONS="*.tex~ *.tex.backup *.dvi *.log *.pdf"
for dir in $(ls -d */)
do
    cd $dir
    rm -vf $EXTENSIONS
done
rm -vf $EXTENSIONS
