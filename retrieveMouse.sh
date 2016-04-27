#!/bin/bash

cd Documents/University/Honours_2016/Project/Genomes/
mkdir mus_musculus
cd mus_musculus

mkdir unplaced
cd unplaced
wget --timestamping 'ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA_000001635.6_GRCm38.p4/GCA_000001635.6_GRCm38.p4_assembly_structure/Primary_Assembly/unplaced_scaffolds/FASTA/unplaced.scaf.fna.gz'
gunzip unplaced.scaf.fna.gz
mv unplaced.scaf.fna unplaced_mouse.fasta
cd ..

mkdir unlocalised
cd unlocalised
wget --timestamping 'ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA_000001635.6_GRCm38.p4/GCA_000001635.6_GRCm38.p4_assembly_structure/Primary_Assembly/unlocalized_scaffolds/FASTA/*'
gunzip *
cd ..

mkdir assembled
cd assembled
wget --timestamping 'ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA_000001635.6_GRCm38.p4/GCA_000001635.6_GRCm38.p4_assembly_structure/Primary_Assembly/assembled_chromosomes/FASTA/*'
gunzip *
