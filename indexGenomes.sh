#!/bin/bash

# Invoked by:
#
# sbatch indexGenomesMouse.sh 
#

#SBATCH -p batch
#SBATCH -N 1 
#SBATCH -n 8  				
#SBATCH --time=0-04:00  	
#SBATCH --mem=30GB 			

# Notification configuration 
#SBATCH --mail-type=END                                         
#SBATCH --mail-type=FAIL           
#SBATCH --mail-user=brittany.howell@student.adelaide.edu.au      


# Load the necessary modules
module load Bowtie2/2.2.6-foss-2015b

# build with bowtie
bowtie2-build mm10.fa mm10
#bowtie2-build hg38.fa hg38
2> output.log
