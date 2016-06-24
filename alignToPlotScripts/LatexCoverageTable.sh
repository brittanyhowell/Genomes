#/bin/bash
PlotsDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Project/ReadCoverage/Mut-F2-Rep1-merge-Plots


cd ${PlotsDIR}

# Check if tablefile exists
if [ -f SummaryTableMergeLatex.tex ]; then
	rm SummaryTableMergeLatex.tex
	touch SummaryTableMergeLatex.tex
    echo "SummaryTableMergeLatex.tex exists....replacing" 
else
    touch SummaryTableMergeLatex.tex
    echo "SummaryTableMergeLatex.tex did not exist....creating" 
fi

# Make Full table
echo "\begin{longtable}[c]{|l|l|p{5.5cm}|p{5.5cm}|}" >> SummaryTableMergeLatex.tex
echo "\caption{Summary coverage values for alignments. Mean fraction of read at non-zero depth represents the average proportion of covered L1s. Mean depth at covered bases refers to the average depth of the L1 bases which are covered by a read.} \\\\" >> SummaryTableMergeLatex.tex
echo "\hline" >> SummaryTableMergeLatex.tex
echo "Mismatches & Multi-mapping & Mean fraction of read at non-zero depth & Mean depth of covered bases \\\\" >> SummaryTableMergeLatex.tex
echo "\hline\hline \endfirsthead" >>SummaryTableMergeLatex.tex
echo "\hline" >> SummaryTableMergeLatex.tex
echo "Mismatches & Multi-mapping & Mean fraction of read at non-zero depth & Mean depth of covered bases \\\\" >> SummaryTableMergeLatex.tex
echo "\hline\hline \endhead" >>SummaryTableMergeLatex.tex
echo "\hline \endfoot" >> SummaryTableMergeLatex.tex
sed -n 2,31p SummaryTable.txt | awk '{print $2 "\t" "&" "\t" $3 "\t" "&" "\t" $4 "\t" "&" "\t" $5 "\t" "\\\\"}' >> SummaryTableMergeLatex.tex
echo "\end{longtable}" >> SummaryTableMergeLatex.tex



# PlotsDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Project/ReadCoverage/Mut-F2-Rep1-Plots


# cd ${PlotsDIR}

# # Check if tablefile exists
# if [ -f SummaryTableLatex.tex ]; then
# 	rm SummaryTableLatex.tex
# 	touch SummaryTableLatex.tex
#     echo "SummaryTableLatex.tex exists....replacing" 
# else
#     touch SummaryTableLatex.tex
#     echo "SummaryTableLatex.tex did not exist....creating" 
# fi

# # Make Full table
# echo "\begin{longtable}[c]{|l|l|p{5.5cm}|p{5.5cm}|}" >> SummaryTableLatex.tex
# echo "\caption{Summary coverage values for alignments. Mean fraction of read at non-zero depth represents the average proportion of covered L1s. Mean depth at covered bases refers to the average depth of the L1 bases which are covered by a read.} \\\\" >> SummaryTableLatex.tex
# echo "\hline" >> SummaryTableLatex.tex
# echo "Mismatches & Multi-mapping & Mean fraction of read at non-zero depth & Mean depth of covered bases \\\\" >> SummaryTableLatex.tex
# echo "\hline\hline \endfirsthead" >>SummaryTableLatex.tex
# echo "\hline" >> SummaryTableLatex.tex
# echo "Mismatches & Multi-mapping & Mean fraction of read at non-zero depth & Mean depth of covered bases \\\\" >> SummaryTableLatex.tex
# echo "\hline\hline \endhead" >>SummaryTableLatex.tex
# echo "\hline \endfoot" >> SummaryTableLatex.tex
# sed -n 2,31p SummaryTable.txt | awk '{print $2 "\t" "&" "\t" $3 "\t" "&" "\t" $4 "\t" "&" "\t" $5 "\t" "\\\\"}' >> SummaryTableLatex.tex
# echo "\end{longtable}" >> SummaryTableLatex.tex

