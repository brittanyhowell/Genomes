#!/bin/bash
## Script intersects Bams with L1 locations (BED)
## Date: 29-8-2016

# Invoked by: # FileADIR=/data/rc003/Brittany/Coverage/Active_Clus FileA=AllMut.STAR.Active.Clus.cov_1.9.bed FileBDIR=/data/rc003/Brittany/Coverage/AllL1s_Clus FileB=AllMut.STAR.AllL1s.Clus.cov_1.9.bed OUTDIR=/data/rc003/Brittany/Coverage/Intersects sbatch intersect-cov.sh

#SBATCH -p batch
#SBATCH -N 1 
#SBATCH -n 8 
#SBATCH --time=0-04:00
#SBATCH --mem=20GB 

# Notification configuration 
#SBATCH --mail-type=END                                         
#SBATCH --mail-type=FAIL           
#SBATCH --mail-user=brittany.howell@student.adelaide.edu.au      


# Load the necessary modules
module load BEDTools/2.25.0-foss-2015b

# Working folders
# FileADIR=/data/rc003/Brittany/Coverage/Active_Clus
# FileA=AllMut.STAR.Active.Clus.cov_1.9.bed
# FileBDIR=/data/rc003/Brittany/Coverage/AllL1s_Clus
# FileB=AllMut.STAR.AllL1s.Clus.cov_1.9.bed
# OUTDIR=/data/rc003/Brittany/Coverage/Intersects

fileAName=${FileA%.cov_1.9.bed}
fileBName=${FileB%.cov_1.9.bed}

OUTFILE="int.${fileAName}.${fileBName}.NoDAC.bed"

echo "Commencing program" 
TZ=Australia/Adelaide date   


# Check OUTDIR exists 
if [ -d $OUTDIR ]; then
	echo "OUT folder exists..."  
else 
	echo "creating OUT folder"  
	mkdir $OUTDIR
fi 

	cd ${FileADIR}
	
	echo "Commencing intersect for ${filename}"  
	bedtools intersect -a  ${FileADIR}/${FileA} -b  ${FileBDIR}/${FileB} > ${OUTDIR}/${OUTFILE} 
	echo "Finished intersect"



echo "Completed program"  
TZ=Australia/Adelaide date   

