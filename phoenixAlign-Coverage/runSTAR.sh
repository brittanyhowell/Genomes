#!/bin/bash
## Script submits multiple STAR scripts
## Date: 13-8-2016

WkDIR=/data/rc003/Brittany/Clusters
# CLUSTERS=("0" "1" "3" "4" "5" "13")
# BigClus="0"
CLUSTERS=("2")
BigClus="1"
# CLUSTERS=("2")
# BigClus="3"

rawDIR=/data/rc003/Brittany/Data/TranscriptomeData/Henmt1_mRNAseq_mouse/raw_data/ 
indexedDIR=/data/rc003/Brittany/genomes/indexedMouse 
alignDIR=/data/rc003/Brittany/Alignment/gapPlots 
alignOutDIR=/data/rc003/Brittany/Alignment/gapPlots/output 


# Check all folders exist

if [ -d $rawDIR ]; then
    echo "Folder $rawDIR exists ..." 
else
    mkdir $rawDIR
    echo "Folder $rawDIR does not exist"     
    exit
fi

if [ -d $indexedDIR ]; then
    echo "Folder $indexedDIR exists ..." 
else
    mkdir $indexedDIR
    echo "Folder $indexedDIR does not exist"     
    exit
fi

if [ -d $alignDIR ]; then
    echo "Folder $alignDIR exists ... replacing"     
    rm -r ${alignDIR}
    mkdir ${alignDIR}
else
    mkdir $alignDIR
    echo "Folder $alignDIR does not exist, making $alignDIR" 
fi

if [ -d $alignOutDIR ]; then
    echo "Folder $alignOutDIR exists ... replacing"     
    rm -r ${alignOutDIR}
    mkdir ${alignOutDIR}
else
    mkdir $alignOutDIR
    echo "Folder $alignOutDIR does not exist, making $alignOutDIR" 
fi


# Move into reads folder
cd ${rawDIR}
READ=$(ls *_R1*)

for file in ${READ}; do

	readname=${file%_R1.fastq}

rawDIR=/data/rc003/Brittany/Data/TranscriptomeData/Henmt1_mRNAseq_mouse/raw_data/ indexedDIR=/data/rc003/Brittany/genomes/indexedMouse alignDIR=/data/rc003/Brittany/Alignment/gapPlots alignOutDIR=/data/rc003/Brittany/Alignment/gapPlots/output sbatch STAR.sh ${readname}

done

echo "Complete"

