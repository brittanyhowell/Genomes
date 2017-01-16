#!/bin/bash
## indexGenomes.sh
## Date: 31-5-2016
# Invoked by: sbatch indexGenomes.sh

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
module load STAR/2.5.1a-foss-2015b



#Run STAR
 STAR --runMode genomeGenerate --runThreadN 8 --genomeDir /data/rc003/Brittany/Data/genomes/indexed/hg19 --genomeFastaFiles /data/rc003/Brittany/Data/genomes/hg19.fa

echo "Complete"

