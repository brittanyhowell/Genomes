#/bin/bash
PlotsDIR=$1

cd ${PlotsDIR}

# Check if tablefile exists
if [ -f SummaryTableLatex.tex ]; then
	rm SummaryTableLatex.tex
	touch SummaryTableLatex.tex
    echo "SummaryTableLatex.tex exists....replacing" 
else
    touch SummaryTableLatex.tex
    echo "SummaryTableLatex.tex did not exist....creating" 
fi

# Make Full table
echo "\begin{longtable}[c]{|l|l|p{5.5cm}|p{5.5cm}|}" >> SummaryTableLatex.tex
echo "\caption{Summary coverage values for alignments. Mean fraction of read at non-zero depth represents the average proportion of covered L1s. Mean depth at covered bases refers to the average depth of the L1 bases which are covered by at least one read.} \\\\" >> SummaryTableLatex.tex
echo "\hline" >> SummaryTableLatex.tex
echo "Mismatches & Multi-mapping & Mean fraction of read at non-zero depth & Mean depth of covered bases \\\\" >> SummaryTableLatex.tex
echo "\hline\hline \endfirsthead" >>SummaryTableLatex.tex
echo "\hline" >> SummaryTableLatex.tex
echo "Mismatches & Multi-mapping & Mean fraction of read at non-zero depth & Mean depth of covered bases \\\\" >> SummaryTableLatex.tex
echo "\hline\hline \endhead" >>SummaryTableLatex.tex
echo "\hline \endfoot" >> SummaryTableLatex.tex
sed -n 2,31p SummaryTable.txt | awk '{print $2 "\t" "&" "\t" $3 "\t" "&" "\t" $4 "\t" "&" "\t" $5 "\t" "\\\\"}' >> SummaryTableLatex.tex
echo "\end{longtable}" >> SummaryTableLatex.tex

