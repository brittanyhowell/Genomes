#/bin/bash

COVERAGE=/Users/brittanyhowell/Documents/University/Honours_2016/Project/ReadCoverage/Mut-F2-Rep1/*
COVERAGEDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Project/ReadCoverage/Mut-F2-Rep1
Scripts=/Users/brittanyhowell/Documents/University/Honours_2016/Project/Genomes/alignToPlotScripts

# Plot coverage

for iCov in $COVERAGE; do 
	
	filename=${iCov%.coverage.bed}

	cd ${Scripts}
	Rscript coverageAnalysis.R ${iCov} ${filename}.pdf
	
done

