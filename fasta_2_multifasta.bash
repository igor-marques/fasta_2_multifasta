#!/bin/bash
echo Script name: $0
echo $# arguments 

if [[ $# -ne 1 ]]; then
    echo "Illegal number of parameters" >&2
    echo "Run as" $0 "YOURFILE.fasta"   >&2
    exit 2
fi


sed "s/#/___/g" ${1} > tmp_01
tr "\n" "#" < tmp_01 > tmp_02
sed "s/#>/\n>/g" tmp_02 | sed "s/ /@/g" > tmp_03 
CC=$(cat tmp_03 )
for i in $CC
do
FILENAME=$(echo $i | sed -e "s/@/ /g" -e "s/>//g" | awk '{ print $1 }')
FASTA=$(echo "$i" | tr "#" "\n" | sed -e "s/@/ /g")
echo "$FASTA" | sed "s/___/#/g" > $FILENAME.fasta
done

rm -rf tmp_0*
