#!/bin/bash

cd /Users/brittanyhowell/Documents/University/Honours_2016/Project/Genomes/MouseUCSC



#wget --timestamping 'http://hgdownload.cse.ucsc.edu/goldenPath/hg38/bigZips/hg38.fa.gz'
#gunzip *.fa
#cd ..

#mkdir MouseUCSC

wget --timestamping 'http://hgdownload.cse.ucsc.edu/goldenPath/mm10/bigZips/chromFa.tar.gz'
gunzip *

