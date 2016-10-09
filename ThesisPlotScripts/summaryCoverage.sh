#/bin/bash
PlotsDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Thesis/Figures/candidateCoverage

texDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Thesis/appendices/
newTex="${texDIR}/SummaryPlot.tex"

cd ${texDIR}
# Check if tablefile exists
if [ -f ${newTex} ]; then
	rm ${newTex}
	touch ${newTex}
    echo "${newTex} exists....replacing" 
else
    touch ${newTex}
    echo "${newTex} did not exist....creating" 
fi

	echo "\begin{figure}[tb]" >> ${newTex}
	echo "\centering"  >> ${newTex}
	echo "\includegraphics[width=\linewidth]{Figures/candidateCoverage/SummaryPlot.pdf}" >> ${newTex}
	echo "\caption{Summary of read coverage of L1 elements in the mouse genome. Values represent mean depth and proportion covered of all L1 elements with a single set of paramters. Plots for individual parameters can be found in appendix \ref{Plots:RawCov}.}" >> ${newTex}
	echo "\label{fig:SummCoverage}" >> ${newTex}
	echo "\end{figure}" >> ${newTex}