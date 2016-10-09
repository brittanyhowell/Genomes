#/bin/bash
gapDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Thesis/Figures/findGenomeGaps
texDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Thesis/appendices
newTex=${texDIR}/genomePlotGaps.tex



# Check if treeFile exists
if [ -f ${newTex} ]; then
	rm ${newTex}
	touch ${newTex}
    echo "${newTex} exists....replacing" 
else
    touch ${newTex}
    echo "${newTex} did not exist....creating" 
fi

cd ${gapDIR}
# Make tablefile
for iPlot in *.pdf ; do 

filename=${iPlot%.pdf}


captionName=$(echo $filename | sed 's/gaps_//g' | sed 's/_A//g'| sed 's/_/-/g')
	

	echo "\begin{figure}[h]" >> ${newTex}
	echo "\centering"  >> ${newTex}
	echo "\includegraphics[width=0.6\linewidth]{Figures/findGenomeGaps/${filename}.pdf}" >> ${newTex}
	echo "\caption{Gap indicating plot for ${captionName} generated with findgaps.go and coverageIntervals.R}" >> ${newTex}
	echo "\label{fig:coverage-${captionName}}" >> ${newTex}
	echo "\end{figure}" >> ${newTex}                                             
	echo "" >> ${newTex}



done

