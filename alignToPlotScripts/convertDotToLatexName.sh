#!/bin/bash

wkDIR=$1
cd ${wkDIR}
for file in *.pdf ; do

	filename="${file%.fasta.pdf}.pdf" 

	mv $file $filename

done
