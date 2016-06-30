#/bin/bash
PlotsDIR=$1

cd ${PlotsDIR}

# Check if tablefile exists
if [ -f MedianTableLatex.tex ]; then
	rm MedianTableLatex.tex
	touch MedianTableLatex.tex
    echo "MedianTableLatex.tex exists....replacing" 
else
    touch MedianTableLatex.tex
    echo "MedianTableLatex.tex did not exist....creating" 
fi

# Make Full table
echo "\begin{longtable}[c]{|l|l|p{5.5cm}|p{5.5cm}|}" >> MedianTableLatex.tex
echo "\caption{Median values for alignment coverage data. Median fraction of read at non-zero depth represents the average proportion of covered L1s. Median depth at covered bases refers to the average depth of the L1 bases which are covered by at least one read.} \\\\" >> MedianTableLatex.tex
echo "\hline" >> MedianTableLatex.tex
echo "Mismatches & Multi-mapping & Median fraction of read at non-zero depth & Median depth of covered bases \\\\" >> MedianTableLatex.tex
echo "\hline\hline \endfirsthead" >>MedianTableLatex.tex
echo "\hline" >> MedianTableLatex.tex
echo "Mismatches & Multi-mapping & Median fraction of read at non-zero depth & Median depth of covered bases \\\\" >> MedianTableLatex.tex
echo "\hline\hline \endhead" >>MedianTableLatex.tex
echo "\hline \endfoot" >> MedianTableLatex.tex
sed -n 2,31p medianTable.txt | awk '{print $2 "\t" "&" "\t" $3 "\t" "&" "\t" $4 "\t" "&" "\t" $5 "\t" "\\\\"}' >> MedianTableLatex.tex
echo "\end{longtable}" >> MedianTableLatex.tex

