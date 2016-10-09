#/bin/bash
PlotsDIR=$1
CoverageDIR=$2



cd $PlotsDIR
# Check if tablefile exists
if [ -f coveragePlots.tex ]; then
	rm coveragePlots.tex
	touch coveragePlots.tex
    echo "coveragePlots.tex exists....replacing" 
else
    touch coveragePlots.tex
    echo "coveragePlots.tex did not exist....creating" 
fi

plot="0"

# Make tablefile
for iPlot in *zoom.pdf ; do 

filename=${iPlot%-zoom.pdf}


captionName=$(echo $filename | sed 's/_/-/g')
	

	echo "\begin{figure}[htp]" >> coveragePlots.tex
	echo "\centering"  >> coveragePlots.tex
	echo "\makebox[\textwidth][c]{" >> coveragePlots.tex
	echo "\begin{subfigure}[b]{.59\textwidth}" >> coveragePlots.tex
	echo "\includegraphics[width=\linewidth]{${PlotsDIR}/${filename}.pdf}" >> coveragePlots.tex
	echo "\vspace{-1cm}" >> coveragePlots.tex
	echo "\caption{Average depth and proportion of L1 covered}" >> coveragePlots.tex
	echo "\end{subfigure}" >> coveragePlots.tex
	echo "\begin{subfigure}[b]{.59\textwidth}" >> coveragePlots.tex
	echo "\includegraphics[width=\linewidth]{${PlotsDIR}/${filename}-zoom.pdf}" >> coveragePlots.tex
	echo "\vspace{-1cm}" >> coveragePlots.tex
	echo "\caption{Enlarged lower left quartile of (a)}" >> coveragePlots.tex
	echo "\end{subfigure}}" >> coveragePlots.tex
	echo "\caption{${captionName}}" >> coveragePlots.tex
	echo "\label{fig:coverage-${captionName}}" >> coveragePlots.tex
	echo "\end{figure}" >> coveragePlots.tex                                             
	echo "" >> coveragePlots.tex



done

