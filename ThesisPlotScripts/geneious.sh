#/bin/bash
gapDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Thesis/Figures/geneious
texDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Thesis/appendices
newTex=${texDIR}/geneious.tex



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
for iPlot in *.png ; do 

filename=${iPlot%.png}


captionName=$(echo $filename | sed 's/_/-/g')
noCoord=${filename%-*}
noUnder=$(echo $filename | sed 's/_/-/g')

	echo "\begin{figure}[h]" >> ${newTex}
	echo "\centering"  >> ${newTex}
	echo "\includegraphics[width=0.6\linewidth]{Figures/geneious/${iPlot}}" >> ${newTex}
	echo "\caption{Gap in multiple alignment of L1 ${noUnder}}" >> ${newTex}
	echo "\label{fig:genomeGap${filename}}" >> ${newTex}
	echo "\end{figure}" >> ${newTex}                                             
	echo "" >> ${newTex}



done




# captionName=$(echo $filename | sed 's/_/-/g')
# noCoord=(${filename%-*} 
# # noUnder=$(echo $noCoord | sed 's/_/-/g')

# 	echo "\begin{figure}[h]" >> ${newTex}
# 	echo "\centering"  >> ${newTex}
# 	echo "\includegraphics[width=0.6\linewidth]{Figures/geneious/${iPlot}}" >> ${newTex}
# 	echo "\caption{Gap in multiple alignment of L1 ${noCoord}}" >> ${newTex}
# 	# echo "\label{fig:genomeGap${noUnder}}" >> ${newTex}
# 	echo "\end{figure}" >> ${newTex}                                             
# 	echo "" >> ${newTex}



# done
