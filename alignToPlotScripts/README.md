# Genomes
## alignToPlotScripts

Takes you from alignment to plot.

#### Input/Output
Input: 		STAR genome, intervals of interest.
Output: 	Coverage plots which show the proportion of the element covered as well as the depth at those covered bases.

#### Script Purposes:



- Intersect.sh:					Invokes bedtools intersect.
- LatexCoveragePlots.sh: 			Generates LaTeX plot for all coverage plots.
- LatexCoverageSummaryPlot.sh: 	Generates LaTeX plot for summary coverage plot.
- LatexCoverageTable.sh:  		Generates LaTeX table for mean coverage data.
- LatexMedianTable.sh: 			Generates LaTeX table for median coverage data.
- alignIndexSTAR.sh:		 	Invokes STAR for a range of different parameters.
- bamIntersect.sh:				Invokes bedtools intersect. But this time with bam input!
- bedtoolsCoverage.sh: 			Invokes bedtools coverage.
- convertBAMtoBed.sh: 			Converts bams to beds. 
- convertDotToLatexName.sh:		Removes .s from file names so Latex will plot the plots.
- coverageAnalysis.R:			Reads coverage data, calculates average depth and portion of L1 covered, plots data,
- makeCoveragePlots.sh:			Invokes coverageAnalysis.R on all coverage tables, then invokes LatexCoveragePlots.sh, makeCoverageSummary.R, makeMedianTable.R, LatexCoverageTable.sh, LatexMedianTable.sh and LatexCoverageSummaryPlot.sh.
- makeCoverageSummary.R:		Reads mean coverage data and plots overall summary plot, then makes plots showing the influene of multimapping and mismatch tolerance on L1 coverage.
- makeMedianTable.R:			Generates .txt table from median coverage data.
- mergeBED.sh:					merges BEDs in a directory.
- moveCoverageBED.sh:			Migrates data from VM to Mac.
- redoAlignments.sh: 			Runs STAR for defined variables.
- samTools.sh: 					I grew tired of asking Google what the correct tools were.