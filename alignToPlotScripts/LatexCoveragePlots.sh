#/bin/bash
PlotsDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Project/ReadCoverage/Mut-F2-Rep1-merge-Plots


cd ${PlotsDIR}

# Check if tablefile exists
if [ -f coveragePlotsMerge.tex ]; then
	rm coveragePlotsMerge.tex
	touch coveragePlotsMerge.tex
    echo "coveragePlotsMerge.tex exists....replacing" 
else
    touch coveragePlotsMerge.tex
    echo "coveragePlotsMerge.tex did not exist....creating" 
fi

# Make tablefile
for iPlot in *zoom.pdf ; do 

filename=${iPlot%-zoom.pdf}
captionName=$(echo $filename | sed 's/_/-/g')

	echo "\begin{figure}[tbp]" >> coveragePlotsMerge.tex
	echo "\centering"  >> coveragePlotsMerge.tex
	echo "\makebox[\textwidth][c]{" >> coveragePlotsMerge.tex
	echo "\begin{subfigure}[b]{.59\textwidth}" >> coveragePlotsMerge.tex
	echo "\includegraphics[width=\linewidth]{/Users/brittanyhowell/Documents/University/Honours_2016/Project/ReadCoverage/Mut-F2-Rep1-Plots/Mut-F2-Rep1_CGTACG_L007-STAR-10-20-bothorf.pdf}" >> coveragePlotsMerge.tex
	echo "\vspace{-1cm}" >> coveragePlotsMerge.tex
	echo "\caption{Average depth and proportion of L1 covered}" >> coveragePlotsMerge.tex
	echo "\end{subfigure}" >> coveragePlotsMerge.tex
	echo "\begin{subfigure}[b]{.59\textwidth}" >> coveragePlotsMerge.tex
	echo "\includegraphics[width=\linewidth]{/Users/brittanyhowell/Documents/University/Honours_2016/Project/ReadCoverage/Mut-F2-Rep1-Plots/Mut-F2-Rep1_CGTACG_L007-STAR-10-20-bothorf-zoom.pdf}" >> coveragePlotsMerge.tex
	echo "\vspace{-1cm}" >> coveragePlotsMerge.tex
	echo "\caption{Enlarged lower left quartile of (a)}" >> coveragePlotsMerge.tex
	echo "\end{subfigure}}" >> coveragePlotsMerge.tex
	echo "\caption{${captionName}}" >> coveragePlotsMerge.tex
	echo "\label{fig:coverage-${captionName}}" >> coveragePlotsMerge.tex
	echo "\end{figure}" >> coveragePlotsMerge.tex                                                                                                                                                                                                                                                                                                                                                                            
	echo "" >> coveragePlotsMerge.tex

done

# PlotsDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Project/ReadCoverage/Mut-F2-Rep1-Plots


# cd ${PlotsDIR}

# # Check if tablefile exists
# if [ -f coveragePlots.tex ]; then
# 	rm coveragePlots.tex
# 	touch coveragePlots.tex
#     echo "coveragePlots.tex exists....replacing" 
# else
#     touch coveragePlots.tex
#     echo "coveragePlots.tex did not exist....creating" 
# fi

# # Make tablefile
# for iPlot in *zoom.pdf ; do 

# filename=${iPlot%-zoom.pdf}
# captionName=$(echo $filename | sed 's/_/-/g')

# 	echo "\begin{figure}[tbp]" >> coveragePlots.tex
# 	echo "\centering"  >> coveragePlots.tex
# 	echo "\makebox[\textwidth][c]{" >> coveragePlots.tex
# 	echo "\begin{subfigure}[b]{.59\textwidth}" >> coveragePlots.tex
# 	echo "\includegraphics[width=\linewidth]{/Users/brittanyhowell/Documents/University/Honours_2016/Project/ReadCoverage/Mut-F2-Rep1-Plots/Mut-F2-Rep1_CGTACG_L007-STAR-10-20-bothorf.pdf}" >> coveragePlots.tex
# 	echo "\vspace{-1cm}" >> coveragePlots.tex
# 	echo "\caption{Average depth and proportion of L1 covered}" >> coveragePlots.tex
# 	echo "\end{subfigure}" >> coveragePlots.tex
# 	echo "\begin{subfigure}[b]{.59\textwidth}" >> coveragePlots.tex
# 	echo "\includegraphics[width=\linewidth]{/Users/brittanyhowell/Documents/University/Honours_2016/Project/ReadCoverage/Mut-F2-Rep1-Plots/Mut-F2-Rep1_CGTACG_L007-STAR-10-20-bothorf-zoom.pdf}" >> coveragePlots.tex
# 	echo "\vspace{-1cm}" >> coveragePlots.tex
# 	echo "\caption{Enlarged lower left quartile of (a)}" >> coveragePlots.tex
# 	echo "\end{subfigure}}" >> coveragePlots.tex
# 	echo "\caption{${captionName}}" >> coveragePlots.tex
# 	echo "\label{fig:coverage-${captionName}}" >> coveragePlots.tex
# 	echo "\end{figure}" >> coveragePlots.tex                                                                                                                                                                                                                                                                                                                                                                            
# 	echo "" >> coveragePlots.tex

# done