#!/bin/bash
## alignIndexSTAR.sh aligns mouse HENMT2 reads to mm10 using STAR,
## Date: 31-5-2016

# Raw folders
rawDIR=/mnt/project/Data/Mouse/rawReads
indexedDIR=/mnt/project/Data/Mouse/indexedMouse

#Output
alignDIR=/mnt/project/Data/Mouse/extendedAlignedReads
alignOutDIR=/mnt/project/Data/Mouse/extendedAlignmentOutputData

#record
record=/mnt/project/Data/Mouse/Scripts/record/recordAlignment2.txt 
recordDIR=/mnt/project/Data/Mouse/Scripts/record

#Parameter recording files
parameterDIR=${alignOutDIR}/Parameters
multimaps=${parameterDIR}/ParametersMaps.txt
mismatches=${parameterDIR}/ParametersMatch.txt

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

if [ -d $alignOutDIR ]; then
    echo "Folder $alignOutDIR exists ... replacing" >> ${record} 2>&1
    rm -r ${alignOutDIR}
    mkdir ${alignOutDIR}
else
    mkdir $alignOutDIR
    echo "Folder $alignOutDIR does not exist, making $alignOutDIR" >> ${record} 2>&1
fi

if [ -d $parameterDIR ]; then
    echo "Folder $parameterDIR exists ... replacing" >> ${record} 2>&1
    rm -r ${parameterDIR}
    mkdir ${parameterDIR}
else
    mkdir $parameterDIR
    echo "Folder $parameterDIR does not exist, making $parameterDIR" >> ${record} 2>&1
fi

if [ -f ${multimaps} ]; then
	rm ${multimaps}
	touch ${multimaps}
    echo "${multimaps} exists, replacing" >> ${record} 2>&1
else
    touch ${multimaps}
    echo "${multimaps} did not exist, now does" >> ${record} 2>&1
fi

if [ -f ${mismatches} ]; then
	rm ${mismatches}
	touch ${mismatches}
    echo "${mismatches} exists, replacing" >> ${record} 2>&1
else
    touch ${mismatches}
    echo "${mismatches} did not exist, now does" >> ${record} 2>&1
fi

#Alignment parameters 
MULTIMAP=( "25" "30" "35" "40" "45" "50" "60")
MISMATCH=("2" "5" "7" "10" "12" "15" "20")

echo "Commencing alignments" >> ${record} 2>&1
TZ=Australia/Adelaide date >> ${record} 2>&1

# Move into reads folder
cd ${rawDIR}
READ=$(ls *_R1.fastq)

for file in ${READ}; do

	for iMap in "${MULTIMAP[@]}"; do

		for iMatch in "${MISMATCH[@]}"; do

			readname=${file%_R1.fastq}

			echo "Running STAR for ${readname} with ${iMap} multimapping and ${iMatch} mismatches" >> ${record} 2>&1
			
			echo "${iMap}" >> ${multimaps}
			echo "${iMatch}" >> ${mismatches}

			#Run STAR
			STAR --genomeDir ${indexedDIR} --readFilesIn ${rawDIR}/${readname}_R1.fastq ${rawDIR}/${readname}_R2.fastq --outFilterMismatchNmax ${iMatch} --outFilterMultimapNmax ${iMap} --outFileNamePrefix ${alignDIR}/${readname}.STAR.${iMatch}.${iMap}. --outSAMstrandField intronMotif --outSAMattributes All --outSAMtype BAM SortedByCoordinate --alignSoftClipAtReferenceEnds No  2> align.err

	 		cd ${alignDIR}
			# Make bam index
			echo "Making bam index" >> ${record} 2>&1
			samtools index ${readname}.STAR.${iMatch}.${iMap}.Aligned.sortedByCoord.out.bam 

			# Move alignment information files into separate folder
			mv ${readname}.STAR.${iMatch}.${iMap}.Log.out ${alignOutDIR} 
			mv ${readname}.STAR.${iMatch}.${iMap}.Log.final.out ${alignOutDIR} 
			mv ${readname}.STAR.${iMatch}.${iMap}.Log.progress.out ${alignOutDIR} 

			echo "Completed alignment for ${readname} with ${iMap} multimapping and ${iMatch} mismatches" >> ${record} 2>&1
			TZ=Australia/Adelaide date >> ${record} 2>&1

			cd ${rawDIR}

			cat ${record} | mail -s "finished Alignment for map: ${iMap} and mismatch: ${iMatch}" brittany.howell1@gmail.com
		done

	done

	cd ${recordDIR}
	
	cat ${record} | mail -s "finished all Alignments" brittany.howell1@gmail.com 
	echo "Email sent"  >> ${record} 2>&1

done

echo "Exiting program" >> ${record} 2>&1
echo "Complete"
