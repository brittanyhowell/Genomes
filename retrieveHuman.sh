#!/bin/bash

cd Documents/University/Honours_2016/Project/Genomes/
mkdir homo_sapien
cd homo_sapien

mkdir unplaced
cd unplaced
wget --timestamping 'ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA_000001405.22_GRCh38.p7/GCA_000001405.22_GRCh38.p7_assembly_structure/Primary_Assembly/unplaced_scaffolds/FASTA/unplaced.scaf.fna.gz'
gunzip unplaced.scaf.fna.gz
mv unplaced.scaf.fna unplaced_mouse.fasta
cd ..

mkdir unlocalised
cd unlocalised
wget --timestamping 'ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA_000001405.22_GRCh38.p7/GCA_000001405.22_GRCh38.p7_assembly_structure/Primary_Assembly/unlocalized_scaffolds/FASTA/*'
gunzip *
cd ..

mkdir assembled
cd assembled
wget --timestamping 'ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA_000001405.22_GRCh38.p7/GCA_000001405.22_GRCh38.p7_assembly_structure/Primary_Assembly/assembled_chromosomes/FASTA/*'
gunzip *
