#!/bin/bash
## Script submits multiple STAR scripts
## Date: 13-8-2016

# variables need to be here because the script checks if they exist
rawDIR=/data/rc003/Brittany/Data/TranscriptomeData/CKI_MCF7_mRNAseq_human/raw_data
indexedDIR=/data/rc003/Brittany/genomes/indexedHuman
alignDIR=/data/rc003/Brittany/humanAlignment
alignOutDIR=/data/rc003/Brittany/humanAlignment/output

# variables need to be here so the sbatch can call all of them. (trust me it's easier changing them up here than down there on line 63)
variables=""


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
READ=$(ls *_R1.fastq)

for file in ${READ}; do

	readname=${file%_R1.fastq}
    echo "aligning for ${readname}"

rawDIR=/data/rc003/Brittany/Data/TranscriptomeData/CKI_MCF7_mRNAseq_human/raw_data indexedDIR=/data/rc003/Brittany/genomes/indexedHuman alignDIR=/data/rc003/Brittany/humanAlignment alignOutDIR=/data/rc003/Brittany/humanAlignment/output    sbatch STAR.sh ${readname}


done

echo "Complete"


