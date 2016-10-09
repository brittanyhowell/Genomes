#/bin/bash
fastQCDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Thesis/Figures/candidateFastQC
texDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Thesis/appendices
newTex=${texDIR}/fastQC.tex



# Check if treeFile exists
if [ -f ${newTex} ]; then
	rm ${newTex}
	touch ${newTex}
    echo "${newTex} exists....replacing" 
else
    touch ${newTex}
    echo "${newTex} did not exist....creating" 
fi

cd ${fastQCDIR}
# Make tablefile
for iDIR in *fastqc ; do 

cd ${fastQCDIR}/${iDIR}/Images



captionNoUnder=$(echo $iDIR | sed 's/_/-/g')
captionName="${captionNoUnder%-fastqc}"
	



	echo "\begin{figure}[htp]" >> ${newTex}
	echo "\makebox[\textwidth][c]{" >> ${newTex}
	echo "\centering"  >> ${newTex}
	echo "\begin{subfigure}[b]{0.55\textwidth}" >> ${newTex}
	echo "\includegraphics[width=\linewidth]{Figures/candidateFastQC/${iDIR}/Images/adapter_content.png}" >> ${newTex}               
	echo "\caption{Adapter Content}" >> ${newTex}
	echo "\includegraphics[width=\linewidth]{Figures/candidateFastQC/${iDIR}/Images/per_base_quality.png}" >> ${newTex}              
	echo "\caption{Per Base Quality}" >> ${newTex}
	echo "\includegraphics[width=\linewidth]{Figures/candidateFastQC/${iDIR}/Images/per_tile_quality.png}" >> ${newTex}
	echo "\caption{Per Tile Quality}" >> ${newTex}
	echo "\end{subfigure}" >> ${newTex}
	echo "\begin{subfigure}[b]{0.55\textwidth}" >> ${newTex}
	echo "\includegraphics[width=\linewidth]{Figures/candidateFastQC/${iDIR}/Images/duplication_levels.png}" >> ${newTex}            
	echo "\caption{Duplication Levels}" >> ${newTex}
	echo "\includegraphics[width=\linewidth]{Figures/candidateFastQC/${iDIR}/Images/per_base_sequence_content.png}" >> ${newTex}     
	echo "\caption{Per Base Sequence Quality}" >> ${newTex}
	echo "\includegraphics[width=\linewidth]{Figures/candidateFastQC/${iDIR}/Images/sequence_length_distribution.png}" >> ${newTex}
	echo "\caption{Sequence Length Distribution}" >> ${newTex}
	echo "\end{subfigure}}" >> ${newTex}
	echo "\end{figure}" >> ${newTex} 

	echo "\begin{figure}[htp]" >> ${newTex}
	echo "\makebox[\textwidth][c]{" >> ${newTex}
	echo "\centering"  >> ${newTex}
	echo "\begin{subfigure}[b]{0.55\textwidth}" >> ${newTex}
	echo "\includegraphics[width=\linewidth]{Figures/candidateFastQC/${iDIR}/Images/kmer_profiles.png}" >> ${newTex}                 
	echo "\caption*{(g) Kmer Profiles}" >> ${newTex}
	echo "\includegraphics[width=\linewidth]{Figures/candidateFastQC/${iDIR}/Images/per_sequence_gc_content.png}" >> ${newTex}
	echo "\caption*{(h) Per Sequence GC Content}" >> ${newTex}
	echo "\end{subfigure}" >> ${newTex}
	echo "\begin{subfigure}[b]{0.55\textwidth}" >> ${newTex}
	echo "\includegraphics[width=\linewidth]{Figures/candidateFastQC/${iDIR}/Images/per_base_n_content.png}" >> ${newTex}            
	echo "\caption*{(i) Per Base N content}" >> ${newTex}
	echo "\includegraphics[width=\linewidth]{Figures/candidateFastQC/${iDIR}/Images/per_sequence_quality.png}" >> ${newTex}
	echo "\caption*{(j) Per Sequence Quality}" >> ${newTex}
	echo "\end{subfigure}}" >> ${newTex}
	echo "\caption{FastQC data for mouse sample ${captionName}}" >> ${newTex}
	echo "\label{fig:coverage-${iDIR}}" >> ${newTex}
	echo "\end{figure}" >> ${newTex}                                             
	echo "" >> ${newTex}	

done

