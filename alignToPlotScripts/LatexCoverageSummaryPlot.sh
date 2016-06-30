#/bin/bash
PlotsDIR=$1

cd ${PlotsDIR}

# Check if tablefile exists
if [ -f SummaryPlot.tex ]; then
	rm SummaryPlot.tex
	touch SummaryPlot.tex
    echo "SummaryPlot.tex exists....replacing" 
else
    touch SummaryPlot.tex
    echo "SummaryPlot.tex did not exist....creating" 
fi

	echo "\begin{figure}[tb]" >> SummaryPlot.tex
	echo "\centering"  >> SummaryPlot.tex
	echo "\includegraphics[width=\linewidth]{/Users/brittanyhowell/Documents/University/Honours_2016/Project/ReadCoverage/Mut-F2-Rep1-Plots/SummaryPlot.pdf}" >> SummaryPlot.tex
	echo "\caption{Summary of read coverage of L1 elements in the mouse genome. Values represent mean depth and proportion covered of all L1 elements with a single set of paramters. Plots for individual parameters can be found in appendix \ref{Plots:RawCov}.}" >> SummaryPlot.tex
	echo "\label{fig:SummCoverage}" >> SummaryPlot.tex
	echo "\end{figure}" >> SummaryPlot.tex