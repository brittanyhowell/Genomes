#!/bin/bash
## moveCoverageBED.sh moves all BEDs from a folder into the necessary place

# Data folders
BED=Mut-F2-Rep1_CGTACG_L007-ext/*.bed
COVDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Project/ReadCoverage/Mut-F2-Rep1-ext/*
ParamDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Project/Genomes/alignToPlotScripts/ParameterTables

# echo "Moving coverage files"
scp brittany\@130.220.211.67:/mnt/project/Coverage/${BED} ${COVDIR}

echo "Moving parameter files"
scp brittany\@130.220.211.67:/mnt/project/Data/Mouse/extendedAlignmentOutputData/Parameters/* ${ParamDIR}

echo "Completed moving files"
