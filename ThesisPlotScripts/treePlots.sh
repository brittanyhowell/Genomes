#/bin/bash
##plots mega trees
treeDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Project/ClusterFilter/finalPDFs
texDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Thesis/appendices
newTex=${texDIR}/megaTrees.tex



# Check if treeFile exists
if [ -f ${newTex} ]; then
	rm ${newTex}
	touch ${newTex}
    echo "${newTex} exists....replacing" 
else
    touch ${newTex}
    echo "${newTex} did not exist....creating" 
fi



cd ${treeDIR}
for iPlot in *.pdf ; do 

filename=${iPlot%.pdf}
captionName=$(echo $filename | sed 's/_/-/g')

	echo "\begin{figure}[htp]" >> ${newTex}
	echo "\centering"  >> ${newTex}
	echo "\includegraphics[height=.9\textheight]{Figures/trees/${filename}.pdf}" >> ${newTex}
	echo "\caption{Phylogenetic tree of mouse L1s in cluster ${captionName} based on full sequence. Tree was built using the neighbour joining method using the Jukes-Cantor model \citep{Jukes69} using MEGA7 \citep{Kumar16}. The percentage of replicate trees in which the associated taxa clustered together in the bootstrap test (1000 replicates) are shown next to the branches }" >> ${newTex}
	echo "\label{fig:megaTree-${filename}}" >> ${newTex}
	echo "\end{figure}" >> ${newTex}                                             
	echo "" >> ${newTex}

done

