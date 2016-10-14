# Genomes
## phoenixAlign-Coverage

## Summary:
Takes you from alignment to plot, on phoenix! With some other extractions too.
I had this idea to investigate how many L1s had high coverage. No further analysis was completed. 

#### Input/Output
Input: 		STAR genome, intervals of interest.
Output: 	Coverage plots which show the proportion of the element covered as well as the depth at those covered bases.

#### Script Purposes:

- alignIndexSTAR.sh: Invokes STAR and stores output intelligently.
- bamIntersect.sh: See alignToPlotScripts for riveting explanation.
- convertBAMtoBed.sh: See alignToPlotScripts for riveting explanation.
- coverageSorting.R: It looks like it makes histograms, and plots coverage. It does. (For just one sample)
- extractHighCoverage.sh: Reads coverage file, pulls out intervals that exceed specified coverage, and records the number of lines in each of those files.
- extractHighDAC: Calculates depth at covered L1 elements, and prints the L1s which exceed the threshold to a file.
- extractHighOverlap: Calculates the number of reads which overlap the L1, and prints those which exceed the count to a file.
- indexBam.sh: Indexes BAMs.
- intersect-cov.sh: Intersects two sets of L1 intervals in BED format.
- runSTAR.sh: submits several bash scripts to run STAR in parallel.
- unzip.sh: Unzips.

