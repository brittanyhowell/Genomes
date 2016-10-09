#/bin/bash
covPlotDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Thesis/Figures/webLogo/either
FigDIR=Figures/webLogo/either
texDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Thesis/appendices
newTex=${texDIR}/humanWLEither.tex



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
for iPlot in *-three.pdf ; do 

filename=${iPlot%-three.pdf}


captionName=$(echo $filename | sed 's/_/-/g' | sed 's/-either-/-/g' )
	

	echo "\begin{figure}[htp]" >> ${newTex}
	echo "\centering"  >> ${newTex}
	echo "\makebox[\textwidth][c]{" >> ${newTex}
	echo "\begin{subfigure}[b]{.4\textwidth}" >> ${newTex}
	echo "\includegraphics[width=\linewidth]{${FigDIR}/${filename}-five.pdf}" >> ${newTex}
	echo "\vspace{-1cm}" >> ${newTex}
	echo "\caption{5' splice junction}" >> ${newTex}
	echo "\end{subfigure}" >> ${newTex}
	echo "\begin{subfigure}[b]{.4\textwidth}" >> ${newTex}
	echo "\includegraphics[width=\linewidth]{${FigDIR}/${filename}-three.pdf}" >> ${newTex}
	echo "\vspace{-1cm}" >> ${newTex}
	echo "\caption{3' splice junction}" >> ${newTex}
	echo "\end{subfigure}}" >> ${newTex}
	echo "\caption{Nucleotides present at the splice junction of L1s in sample ${captionName}. Size of letter corresponds to proportional representation in the sequences analysed}" >> ${newTex}
	echo "\label{fig:webLogo-${captionName}}" >> ${newTex}
	echo "\end{figure}" >> ${newTex}                                             
	echo "" >> ${newTex}



done

