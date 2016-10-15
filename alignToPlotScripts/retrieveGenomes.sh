#!/bin/bash
# Script retrieves genome assembly from UCSC
wkDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Project/Data/


cd ${wkDIR}
mkdir hg38
wget --timestamping 'http://hgdownload.cse.ucsc.edu/goldenPath/hg38/bigZips/hg38.fa.gz'
gunzip *.fa


cd ${wkDIR}
mkdir mm10
wget --timestamping 'http://hgdownload.cse.ucsc.edu/goldenPath/mm10/bigZips/chromFa.tar.gz'
gunzip *
