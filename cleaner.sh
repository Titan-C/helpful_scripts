#! /bin/bash
# Various scripts to remove backup and unnecessary files
usage(){
    echo "Usage: $0 mode"
    echo "mode options:"
    echo "    latex      cleans latex temporary files"
}

#Cleaning modules
latex(){
EXTENSIONS="*.aux *.tex.backup *.bbl *.bbl~ *.log *.log~ *.nav *.out *.snm *.toc "
rm -vf $EXTENSIONS
for dir in $(ls -d */)
do
    cd $dir
    rm -vf $EXTENSIONS
    cd ..
done
}

#Run script
[[ $# -eq 0 ]] && usage
$1
