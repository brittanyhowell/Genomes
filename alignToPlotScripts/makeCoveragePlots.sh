#/bin/bash

COVERAGE=/Users/brittanyhowell/Documents/University/Honours_2016/Project/ReadCoverage/Mut-F2-Rep1/*
CoverageDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Project/ReadCoverage/Mut-F2-Rep1
Scripts=/Users/brittanyhowell/Documents/University/Honours_2016/Project/Genomes/alignToPlotScripts
Plots=/Users/brittanyhowell/Documents/University/Honours_2016/Project/ReadCoverage/Mut-F2-Rep1-Plots

echo "Commencing program"
TZ="Australia/Adelaide" date

# Check if there are already plots
cd ${CoverageDIR}
for iPlot in *.bed ; do 

	filename=${iPlot%.coverage.bed}

	if [ -f "${filename}.pdf" ]; then
		rm "$filename.pdf" 
		echo "Removed ${filename} PDFs" 
	else 
		echo "No ${filename} plot in Coverage folder to remove" 
	fi 
done

# Check if the folder $Plots exists
if [ -d $Plots ]; then
	rm -r $Plots 
	mkdir $Plots
	echo "Plots folder exists... replacing" 
else 
	echo "creating Plots folder" 
	mkdir $Plots
fi 

echo "finished removing"
# Plot coverage

for iCov in $COVERAGE; do 
	
	filename=${iCov%.coverage.bed}

	cd ${Scripts}
	Rscript coverageAnalysis.R ${iCov} ${filename}.pdf ${filename}.zoom.pdf
	
done
 
 # Move all files into plots folder
 cd ${CoverageDIR}
 mv *.pdf ${Plots}

 # Rename plots for the sake of LaTeX.

 cd ${Plots}
 for iPlot in *.pdf ; do 

 	AddDash=$(echo $iPlot | sed 's/\./-/g')
 	RemovePdf=${AddDash%-pdf}
 	LatexName="${RemovePdf}.pdf"

 	mv $iPlot $LatexName

 done




 echo "complete"


