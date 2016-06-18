meanFrac <- read.table(file = "../Project/ReadCoverage/Mut-F2-Rep1-Plots/medianFraction.txt")
meanNum <- read.table(file = "../Project/ReadCoverage/Mut-F2-Rep1-Plots/meanNumber.txt")
colnames(meanFrac) <- c("Num", "Values")
colnames(meanNum) <- c("Num", "Values")

means <- cbind(meanFrac$Values, meanNum$Values, deparse.level = 0)

colnames(means) <- c("fractionCovered", "depthAtCovered" )

sink("~/Desktop/Summary.txt")
meansDF <- as.data.frame(means)
sink()

pdf("~/Desktop/SummaryPlot.pdf")
plot(meansDF$fractionCovered, meansDF$depthAtCovered,  
     main = 'Average depth of covered L1 bases', 
     ylab = 'Mean depth of covered bases in L1 elements',
     xlab = 'Median proportion of L1 bases covered by at least one read' )
dev.off