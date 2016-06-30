#!/bin/bash
## moveCoverageBED.sh moves all BEDs from a folder into the necessary place

# Data folders
BEDDIR=/mnt/project/Coverage/Mut-F2-Rep1_CGTACG_L007-TEMP/*
COVDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Project/ReadCoverage/Mut-F2-Rep1-TEMP
Param=/mnt/project/Data/Mouse/tempBAMS/someextendedAlignmentOutputData/Parameters/*
ParamDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Project/Genomes/alignToPlotScripts/ParameterTables


# Check OUTDIR exists 
if [ -d $COVDIR ]; then
	rm -r $COVDIR 
	mkdir $COVDIR
	echo "Coverage folder exists... replacing" 
else 
	echo "creating Coverage folder" 
	mkdir $COVDIR
fi


 echo "Moving coverage files"
 scp brittany\@130.220.211.67:${BEDDIR} ${COVDIR}

# Check OUTDIR exists 
# if [ -d $ParamDIR ]; then
# 	rm -r $ParamDIR 
# 	mkdir $ParamDIR
# 	echo "Parameter folder exists... replacing" 
# else 
# 	echo "creating Parameter folder" 
# 	mkdir $ParamDIR
# fi

#echo "Moving parameter files"
#scp brittany\@130.220.211.67:${Param} ${ParamDIR}

echo "Completed moving files"
