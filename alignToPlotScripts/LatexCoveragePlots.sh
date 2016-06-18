#/bin/bash
PlotsDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Project/ReadCoverage/Mut-F2-Rep1-Plots



cd ${PlotsDIR}

# Check if tablefile exists
if [ -f coveragePlots.tex ]; then
	rm coveragePlots.tex
	touch coveragePlots.tex
    echo "coveragePlots.tex exists....replacing" 
else
    touch coveragePlots.tex
    echo "coveragePlots.tex did not exist....creating" 
fi

# Make tablefile
for iPlot in *zoom.pdf ; do 

filename=${iPlot%-zoom.pdf}
captionName=$(echo $filename | sed 's/_/-/g')

	echo "\begin{figure}[tbp]" >> coveragePlots.tex
	echo "\centering"  >> coveragePlots.tex
	echo "\makebox[\textwidth][c]{" >> coveragePlots.tex
	echo "\includegraphics[width=0.6\linewidth]{/Users/brittanyhowell/Documents/University/Honours_2016/Project/ReadCoverage/Mut-F2-Rep1-Plots/Mut-F2-Rep1_CGTACG_L007-STAR-10-20-bothorf.pdf}" >> coveragePlots.tex
	echo "\includegraphics[width=0.6\linewidth]{/Users/brittanyhowell/Documents/University/Honours_2016/Project/ReadCoverage/Mut-F2-Rep1-Plots/Mut-F2-Rep1_CGTACG_L007-STAR-10-20-bothorf-zoom.pdf}}" >> coveragePlots.tex
	echo "\caption{${captionName}}" >> coveragePlots.tex
	echo "\label{fig:coverage-${captionName}}" >> coveragePlots.tex
	echo "\end{figure}" >> coveragePlots.tex
	echo ""

done

