#!/bin/bash
phonopy --qe -d --dim="2 2 1" -c ../scf1.in

header="../header.in"

for file in supercell-*.in
do
    newfile="scf_${file}"
    cat $header $file > $newfile
    echo "Created $newfile"
    rm $file
done
