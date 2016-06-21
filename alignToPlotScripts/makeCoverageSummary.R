meanFrac <- read.table(file = "~/Documents/University/Honours_2016/Project/ReadCoverage/Mut-F2-Rep1-Plots/meanFraction.txt")
meanNum <- read.table(file = "~/Documents/University/Honours_2016/Project/ReadCoverage/Mut-F2-Rep1-Plots/meanNumber.txt")
colnames(meanFrac) <- c("Num", "Values")
colnames(meanNum) <- c("Num", "Values")

parameters <- read.table("~/Documents/University/Honours_2016/Project/Genomes/alignToPlotScripts/Parameters.txt")
parametersR <- read.table("~/Documents/University/Honours_2016/Project/Genomes/alignToPlotScripts/ParametersR.txt")

means <- cbind(parameters, parametersR, meanFrac$Values, meanNum$Values, deparse.level = 0)

colnames(means) <- c("Mismatches", "MultiMaps", "fractionCovered", "depthAtCovered" )

meansDF <- as.data.frame(means)

write.table(means, file = "~/Documents/University/Honours_2016/Project/ReadCoverage/Mut-F2-Rep1-Plots/SummaryTable.txt")

pdf("~/Documents/University/Honours_2016/Project/ReadCoverage/Mut-F2-Rep1-Plots/SummaryPlot.pdf")
plot(meansDF$fractionCovered, meansDF$depthAtCovered, 
     main = 'Average depth of covered L1 bases', 
     ylab = 'Mean depth of covered bases in L1 elements',
     xlab = 'Mean proportion of L1 bases covered by at least one read' )
dev.off

head(meansDF)

# Playing with plots
pdf()
plot(meansDF$Mismatches, meansDF$fractionCovered, 
     main = 'Average depth of covered L1 bases', 
     ylab = 'Mean depth of covered bases in L1 elements',
     xlab = 'Number of allowed mismatches', type = 'n')
text(meansDF$Mismatches, meansDF$fractionCovered, paste(meansDF$Mismatches, meansDF$MultiMaps, sep=", "), cex=0.8)

plot(meansDF$MultiMaps, meansDF$fractionCovered, 
     main = 'Average depth of covered L1 bases', 
     ylab = 'Mean depth of covered bases in L1 elements',
     xlab = 'Number of reads allowed to map to the same coordinate', type = 'n')
text(meansDF$MultiMaps, meansDF$fractionCovered, paste(meansDF$Mismatches, meansDF$MultiMaps, sep=", "), cex=0.8)

plot(meansDF$Mismatches, meansDF$depthAtCovered, 
     main = 'Average depth of covered L1 bases', 
     ylab = 'Mean depth of covered bases in L1 elements',
     xlab = 'Number of allowed mismatches', type = 'n')
text(meansDF$Mismatches, meansDF$depthAtCovered, paste(meansDF$Mismatches, meansDF$MultiMaps, sep=", "), cex=0.8)

plot(meansDF$MultiMaps, meansDF$depthAtCovered, 
     main = 'Average depth of covered L1 bases', 
     ylab = 'Mean depth of covered bases in L1 elements',
     xlab = 'Number of reads allowed to map to the same coordinate', type = 'n')
text(meansDF$MultiMaps, meansDF$depthAtCovered, paste(meansDF$Mismatches, meansDF$MultiMaps, sep=", "), cex=0.8)

BestWorst <- read.table("./ReadCoverage/Mut-F2-Rep-1NotPlots/SummaryBestTable.txt")
colnames(BestWorst) <- c("Mismatch", "Multimap", "Proportion at depth", "Mean depth of covered bases" )

dBestWorst <- density(BestWorst$Multimap)
plot(dBestWorst)

plot(BestWorst$`Proportion at depth`, BestWorst$`Mean depth of covered bases`, type = 'n',
     main = 'Mismatch and multimapping parameters for the highest and lowest values', 
     ylab = 'Mean depth of covered bases in L1 elements',
     xlab = 'Mean proportion of L1 bases covered by at least one read' )
text(BestWorst$`Proportion at depth`, BestWorst$`Mean depth of covered bases`, paste(round(BestWorst$Mismatch, 2), round(BestWorst$Multimap, 2), sep=", "), cex=0.8)


