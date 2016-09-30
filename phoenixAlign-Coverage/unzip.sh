#!/bin/bash
## unzip.sh unzips many files
## Date: 31-5-2016
# Invoked by:unzip.sh
# 

#SBATCH -p batch
#SBATCH -N 1 
#SBATCH -n 8  				
#SBATCH --time=0-04:00
#SBATCH --mem=10GB 			

# Notification configuration 
#SBATCH --mail-type=END                                         
#SBATCH --mail-type=FAIL           
#SBATCH --mail-user=brittany.howell@student.adelaide.edu.au      

for zip in *.gz ; do
	echo "unziping ${zip}"
	gzip -d ${zip} 
done

echo "complete"

