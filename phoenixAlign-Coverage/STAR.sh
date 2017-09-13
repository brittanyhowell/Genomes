#!/bin/bash
## alignIndexSTAR.sh aligns mouse HENMT2 reads to mm10 using STAR,
## Date: 31-5-2016
# Invoked by:
#
# 	rawDIR=/data/rc003/Brittany/Data/TranscriptomeData/spliceMutant/reads indexedDIR=/data/rc003/Brittany/genomes/indexedHuman  alignDIR=/data/rc003/Brittany/Alignment/spliceMutant alignOutDIR=/data/rc003/Brittany/Alignment/spliceMutant/output sbatch STAR.sh

#SBATCH -p batch
#SBATCH -N 1 
#SBATCH -n 8  				
#SBATCH --time=0-04:00
#SBATCH --mem=40GB 			

# Notification configuration 
#SBATCH --mail-type=END                                         
#SBATCH --mail-type=FAIL           
#SBATCH --mail-user=brittany.howell@student.adelaide.edu.au      


# Load the necessary modules
module load BEDTools/2.25.0-foss-2015b
module load STAR/2.5.1a-foss-2015b
module load SAMtools/1.2-foss-2015b


readname=${1}


        echo "Running STAR for ${readname}" 
          

        #Run STAR
  STAR --runThreadN 8 --genomeDir ${indexedDIR} --readFilesIn ${rawDIR}/${readname}R1.fastq ${rawDIR}/${readname}R2.fastq --outFilterMismatchNmax 10 --outFilterMultimapNmax 45 --outFileNamePrefix ${alignDIR}/${readname}.STAR. --outSAMstrandField intronMotif --outSAMattributes All  --outSAMtype BAM SortedByCoordinate --alignSoftClipAtReferenceEnds No 

                cd ${alignDIR}

        # Make bam index
        echo "Making bam index" 
    samtools index ${readname}.STAR.Aligned.sortedByCoord.out.bam 

     echo "Making sam from bam"
     samtools view -h ${readname}.STAR.Aligned.sortedByCoord.out.bam > ${readname}.STAR.Aligned.sortedByCoord.out.sam

echo "moving files"
        # Move alignment information files into separate folder
        mv ${readname}.STAR.Log.out ${alignOutDIR} 
        mv ${readname}.STAR.Log.final.out ${alignOutDIR} 
        mv ${readname}.STAR.Log.progress.out ${alignOutDIR} 

echo "Changing names"
    # Changing names
    # mv ${readname}.STAR.Aligned.sortedByCoord.out.sam ${readname}.STAR.10.45.sam    
    mv ${readname}.STAR.Aligned.sortedByCoord.out.bam ${readname}.STAR.10.45.bam
    mv ${readname}.STAR.Aligned.sortedByCoord.out.bam.bai ${readname}.STAR.10.45.bam.bai    


echo "finished with ${readname}"