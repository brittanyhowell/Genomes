#!/bin/bash
## alignIndexSTAR.sh aligns mouse HENMT2 reads to mm10 using STAR,
## Date: 31-5-2016

# Raw folders
rawDIR=/mnt/project/Data/Mouse/rawReads/
indexedDIR=/mnt/project/Data/Mouse/indexedMouse

#Output
alignDIR=/mnt/project/Data/Mouse/AlignOutput/finaltwo
alignOutDIR=/mnt/project/Data/Mouse/AlignOutput/finaltwo

#record
record=/mnt/project/Data/Mouse/Scripts/record/recordAlignment2060.txt
recordDIR=/mnt/project/Data/Mouse/Scripts/record


if [ -f ${record} ]; then
	rm ${record}
	touch ${record}
    echo "${record} exists, replacing" >> ${record} 2>&1
else
    touch ${record}
    echo "${record} did not exist, now does" >> ${record} 2>&1
fi


echo "The program starts at:" >> ${record} 2>&1
TZ=Australia/Adelaide date >> ${record} 2>&1

# Check all folders exist

if [ -d $rawDIR ]; then
    echo "Folder $rawDIR exists ..." >> ${record} 2>&1
else
    mkdir $rawDIR
    echo "Folder $rawDIR does not exist" >> ${record} 2>&1
    exit
fi

if [ -d $indexedDIR ]; then
    echo "Folder $indexedDIR exists ..." >> ${record} 2>&1
else
    mkdir $indexedDIR
    echo "Folder $indexedDIR does not exist" >> ${record} 2>&1
    exit
fi

if [ -d $alignDIR ]; then
    echo "Folder $alignDIR exists ... replacing" >> ${record} 2>&1
    rm -r ${alignDIR}
    mkdir ${alignDIR}
else
    mkdir $alignDIR
    echo "Folder $alignDIR does not exist, making $alignDIR" >> ${record} 2>&1
fi



echo "Commencing alignments" >> ${record} 2>&1
TZ=Australia/Adelaide date >> ${record} 2>&1

# Move into reads folder
cd ${rawDIR}
READ=$(ls *_R1.fastq)

for file in ${READ}; do

	
			readname=${file%_R1.fastq}

			

			#Run STAR
			STAR --genomeDir ${indexedDIR} --readFilesIn ${rawDIR}/${readname}_R1.fastq ${rawDIR}/${readname}_R2.fastq --outFilterMismatchNmax 20 --outFilterMultimapNmax 60 --outFileNamePrefix ${alignDIR}/${readname}.STAR.20.60. --outSAMstrandField intronMotif --outSAMattributes All --outSAMtype BAM SortedByCoordinate --alignSoftClipAtReferenceEnds No  2> align.err

	 		cd ${alignDIR}
			# Make bam index
			echo "Making bam index" >> ${record} 2>&1
			samtools index ${readname}.STAR.20.60.Aligned.sortedByCoord.out.bam 



done

echo "Exiting program" >> ${record} 2>&1
echo "Complete"
