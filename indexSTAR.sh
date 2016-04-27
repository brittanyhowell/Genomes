#!/bin/bash

# Invoked by:
#
# sbatch indexSTAR.sh 
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
module load STAR/2.5.1a-foss-2015b

# build with STAR

STAR --runThreadN 8 --runMode genomeGenerate --genomeDir /indexed --genomeFastaFiles mm10.fa 

2> output.log