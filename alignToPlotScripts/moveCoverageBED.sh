#!/bin/bash
## moveCoverageBED.sh moves all BEDs from a folder into the necessary place

# Data folders
BEDDIR=/mnt/project/Coverage/Mut-F2-Rep1_CGTACG_L007-TEMP/*
COVDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Project/ReadCoverage/Mut-F2-Rep1-ext
Param=/mnt/project/Data/Mouse/tempBAMS/someextendedAlignmentOutputData/Parameters/*
ParamDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Project/Genomes/alignToPlotScripts/ParameterTables

 echo "Moving coverage files"
 scp brittany\@130.220.211.67:${BEDDIR} ${COVDIR}

echo "Moving parameter files"
scp brittany\@130.220.211.67:${Param} ${ParamDIR}

echo "Completed moving files"
