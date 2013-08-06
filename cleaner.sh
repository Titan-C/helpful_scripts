#! /bin/bash
# Various scripts to remove backup and unnecessary files
usage(){
    echo "Usage: $0 mode"
    echo "mode options:"
    echo "    latex      cleans latex temporary files"
}

#Cleaning modules
latex(){
EXTENSIONS="*.aux *.tex~ *.tex.backup *.dvi *.log *.pdf"
for dir in $(ls -d */ ./)
do
    cd $dir
    rm -vf $EXTENSIONS
done
}

#Run script
[[ $# -eq 0 ]] && usage
$1 
