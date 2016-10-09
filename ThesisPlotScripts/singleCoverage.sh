#/bin/bash
covPlotDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Thesis/Figures/candidateCoverage
texDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Thesis/appendices
newTex=${texDIR}/singleCoverage.tex



# Check if treeFile exists
if [ -f ${newTex} ]; then
	rm ${newTex}
	touch ${newTex}
    echo "${newTex} exists....replacing" 
else
    touch ${newTex}
    echo "${newTex} did not exist....creating" 
fi

cd ${covPlotDIR}
# Make tablefile
for iPlot in *zoom.pdf ; do 

filename=${iPlot%-zoom.pdf}


captionName=$(echo $filename | sed 's/_/-/g')
	

	echo "\begin{figure}[htp]" >> ${newTex}
	echo "\centering"  >> ${newTex}
	echo "\makebox[\textwidth][c]{" >> ${newTex}
	echo "\begin{subfigure}[b]{.59\textwidth}" >> ${newTex}
	echo "\includegraphics[width=\linewidth]{Figures/candidateCoverage/${filename}.pdf}" >> ${newTex}
	echo "\vspace{-1cm}" >> ${newTex}
	echo "\caption{Average depth and proportion of L1 covered}" >> ${newTex}
	echo "\end{subfigure}" >> ${newTex}
	echo "\begin{subfigure}[b]{.59\textwidth}" >> ${newTex}
	echo "\includegraphics[width=\linewidth]{Figures/candidateCoverage/${filename}-zoom.pdf}" >> ${newTex}
	echo "\vspace{-1cm}" >> ${newTex}
	echo "\caption{Enlarged lower left quartile of (a)}" >> ${newTex}
	echo "\end{subfigure}}" >> ${newTex}
	echo "\caption{${captionName}}" >> ${newTex}
	echo "\label{fig:coverage-${captionName}}" >> ${newTex}
	echo "\end{figure}" >> ${newTex}                                             
	echo "" >> ${newTex}



done

