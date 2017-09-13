#!/bin/bash
## Script submits multiple STAR scripts
## Date: 13-8-2016

# variables need to be here because the script checks if the folders exist
# Remember to add them to line 60.
rawDIR=/data/rc003/Brittany/Data/TranscriptomeData/CKI_MCF7_mRNAseq_human/raw_data/Aggregate
indexedDIR=/fast/users/a1646948/data/genomes/indexed/hg19
alignDIR=/fast/users/a1646948/data/bam/humanALL1045
alignOutDIR=/fast/users/a1646948/data/bam/humanALL1045/outFiles
scriptDIR=/fast/users/a1646948/scripts


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

cd ${scriptDIR}
cp STAR.sh ${rawDIR}
# Move into reads folder
cd ${rawDIR}
READ=$(ls *R1.fastq)

for file in ${READ}; do 


        readname=${file%R1.fastq}


    echo "aligning for ${readname}"


rawDIR=/data/rc003/Brittany/Data/TranscriptomeData/CKI_MCF7_mRNAseq_human/raw_data/Aggregate indexedDIR=/fast/users/a1646948/data/genomes/indexed/hg19 alignDIR=/fast/users/a1646948/data/bam/humanALL1045 alignOutDIR=/fast/users/a1646948/data/bam/humanALL1045/outFiles sbatch STAR.sh ${readname}


done

echo "Complete"