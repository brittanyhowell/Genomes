## Script uses R to make plots from coverage data.
#/bin/bash

# files & directories
COVERAGE=/Users/brittanyhowell/Documents/University/Honours_2016/Project/ReadCoverage/makePlots/Mut-F2-Rep1-Full/*
CoverageDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Project/ReadCoverage/makePlots/Mut-F2-Rep1-Full/
Scripts=/Users/brittanyhowell/Documents/University/Honours_2016/Project/Genomes/alignToPlotScripts
Plots=/Users/brittanyhowell/Documents/University/Honours_2016/Project/ReadCoverage/makePlots/Mut-F2-Rep1-Plots-Full/

# Map and Match parameter tables
# Match=${Scripts}/ParameterTables/ParametersMatch.txt
# Map=${Scripts}/ParameterTables/ParametersMaps.txt

echo "Commencing program"
TZ="Australia/Adelaide" date

# Check if there are already plots
cd ${CoverageDIR}
for iPlot in *.bed ; do 

	filename=${iPlot%.coverage.bed}

	if [ -f "${filename}.pdf" ]; then
		rm "$filename.pdf" 
		echo "Removed ${filename} PDFs"	
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
echo "Plotting coverage plots"
for iCov in $COVERAGE; do 
	filename=${iCov%.coverage.bed}
	cd ${Scripts}
	Rscript coverageAnalysis.R ${iCov} ${filename}.pdf ${filename}.zoom.pdf ${filename}.ultraZoom.pdf

done

 mv meanNumber.txt ${Plots}
 mv meanFraction.txt ${Plots}
 mv medNumber.txt ${Plots}
 mv medFraction.txt ${Plots}

 # Move all files into plots folder
 cd ${CoverageDIR}
 mv *.pdf ${Plots}
echo "Plots created and moved"

 # Rename plots for the sake of LaTeX.
 cd ${Plots}
 for iPlot in *.pdf ; do 

 	AddDash=$(echo $iPlot | sed 's/\./-/g')
 	RemovePdf=${AddDash%-pdf}
 	LatexName="${RemovePdf}.pdf"

 	mv $iPlot $LatexName

 done

echo "Plots renamed"
 
 cd ${Scripts}
 echo "Making LaTeX plots"
./LatexCoveragePlots.sh ${Plots}

echo "Making summary Plot"

Rscript makeCoverageSummary.R ${Plots}/meanFraction.txt ${Plots}/meanNumber.txt ${Plots}/SummaryTable.txt ${Plots}/SummaryPlot.pdf ${Plots}/SummaryPlotNum.pdf  ${Plots}/Summary-MismatchFraction.pdf ${Plots}/Summary-MultimapFraction.pdf ${Plots}/Summary-MismatchDepth.pdf ${Plots}/Summary-MultiFraction.pdf ${Match} ${Map}

echo "Making median table"
Rscript makeMedianTable.R ${Plots}/medFraction.txt ${Plots}/medNumber.txt ${Match} ${Map} ${Plots}/medianTable.txt

echo "Making summary Latex tables"
./LatexCoverageTable.sh ${Plots}
./LatexMedianTable.sh ${Plots}

echo "Making Latex Summary Plot"

./LatexCoverageSummaryPlot.sh ${Plots}




 echo "complete"


