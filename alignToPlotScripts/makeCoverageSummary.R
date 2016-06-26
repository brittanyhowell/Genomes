args = commandArgs(trailingOnly = TRUE)
# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}

meanFrac <- read.table(file = args[1])
meanNum <- read.table(file = args[2])
colnames(meanFrac) <- c("Num", "Values")
colnames(meanNum) <- c("Num", "Values")

parametersMatch <- read.table(args[10])
parametersMap <- read.table(args[11])


means <- cbind(parametersMatch, parametersMap, meanFrac$Values, meanNum$Values, deparse.level = 0)

colnames(means) <- c("Mismatches", "MultiMaps", "fractionCovered", "depthAtCovered" )

meansDF <- as.data.frame(means)

write.table(means, file = args[3])

pdf(args[4], width = 10, height = 8)
plot(meansDF$depthAtCovered, meansDF$fractionCovered,
     main = 'Average depth of covered L1 bases',
     ylab = 'Mean depth of covered bases in L1 elements',
     xlab = 'Mean proportion of L1 bases covered by at least one read', type = 'n')
text(meansDF$depthAtCovered, meansDF$fractionCovered, paste(meansDF$Mismatches, meansDF$MultiMaps, sep=", "), cex=1.1)
graphics.off()

pdf(args[5])
plot(meansDF$fractionCovered, meansDF$depthAtCovered, 
     main = 'Average depth of covered L1 bases',
     ylab = 'Mean depth of covered bases in L1 elements',
     xlab = 'Mean proportion of L1 bases covered by at least one read', type = 'n')
text(meansDF$fractionCovered, meansDF$depthAtCovered, paste(meansDF$Mismatches, meansDF$MultiMaps, sep=", "), cex=1.1)
graphics.off()

# Playing with plots
pdf(args[6], width=6, height=6)
plot(meansDF$Mismatches, meansDF$fractionCovered, xlim = c(0,21),
     ylab = 'Mean proportion covered',
     xlab = 'Number of allowed mismatches', type = 'n')
text(meansDF$Mismatches, meansDF$fractionCovered, paste(meansDF$Mismatches, meansDF$MultiMaps, sep=", "), cex=1.1)
graphics.off()

pdf(args[7], width=6, height=6)
plot(meansDF$MultiMaps, meansDF$fractionCovered, xlim = c(19,46),
     ylab = 'Mean proportion covered',
     xlab = 'Number of reads allowed to map to the same coordinate', type = 'n')
text(meansDF$MultiMaps, meansDF$fractionCovered, paste(meansDF$Mismatches, meansDF$MultiMaps, sep=", "), cex=1.1)
graphics.off()

pdf(args[8], width=6, height=6)
plot(meansDF$Mismatches, meansDF$depthAtCovered, xlim = c(0,21),
     ylab = 'Mean depth of covered bases in L1 elements',
     xlab = 'Number of allowed mismatches', type = 'n')
text(meansDF$Mismatches, meansDF$depthAtCovered, paste(meansDF$Mismatches, meansDF$MultiMaps, sep=", "), cex=1.1)
graphics.off()

pdf(args[9], width=6, height=6)
plot(meansDF$MultiMaps, meansDF$depthAtCovered, xlim = c(19,46),
     ylab = 'Mean depth of covered bases in L1 elements',
     xlab = 'Number of reads allowed to map to the same coordinate', type = 'n')
text(meansDF$MultiMaps, meansDF$depthAtCovered, paste(meansDF$Mismatches, meansDF$MultiMaps, sep=", "), cex=1.1)
graphics.off()
