#/bin/bash
PlotsDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Project/ReadCoverage/Mut-F2-Rep1-Plots


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

	echo "\begin{figure}[tbp]" >> SummaryPlot.tex
	echo "\centering"  >> SummaryPlot.tex
	echo "\includegraphics[width=0.6\linewidth]{/Users/brittanyhowell/Documents/University/Honours_2016/Project/ReadCoverage/Mut-F2-Rep1-Plots/SummaryPlot.pdf}" >> SummaryPlot.tex
	echo "\caption{Summary of coverage}" >> SummaryPlot.tex
	echo "\label{fig:SummCoverage}" >> SummaryPlot.tex
	echo "\end{figure}" >> SummaryPlot.tex