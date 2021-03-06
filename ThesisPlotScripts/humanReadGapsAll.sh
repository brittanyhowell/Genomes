#/bin/bash
gapDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Thesis/Figures/gapHumanAll
FigDIR=Figures/gapHumanAll/
texDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Thesis/appendices
newTex=${texDIR}/gapReadHumanAll.tex



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


captionName=$(echo $filename | sed 's/_/-/g')


	echo "\begin{figure}[h]" >> ${newTex}
	echo "\centering"  >> ${newTex}
	echo "\includegraphics[width=0.8\linewidth]{${FigDIR}/${iPlot}}" >> ${newTex}
	echo "\caption{Deletions occurring in reads which overlap human L1 elements. All reads entirely within the L1 interval were included. Black boxes indicate the portion of the L1 which was skipped in the aligned read. Reads generated from sample ${captionName}. Gaps detected with bamReader.go and plotted with coverageSplitReads.R}" >> ${newTex}
	echo "\label{fig:genomeGap${filename}}" >> ${newTex}
	echo "\end{figure}" >> ${newTex}                                             
	echo "" >> ${newTex}



done



