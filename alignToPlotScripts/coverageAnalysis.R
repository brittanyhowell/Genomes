args = commandArgs(TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}


# Reading coverage table

coverage <- read.table(file = args[1])
colnames(coverage) <- c("chromosome", "start", "stop", "read", "Unique", "Strand", "number overlapping features", "Number bases at depth", "length of read", "Fraction of read at depth")

#Average depth of covered bases

depthAtCovered <- (coverage$`number overlapping features`/coverage$`Number bases at depth`)*101

pdf(args[2])
plot(coverage$`Fraction of read at depth`, depthAtCovered, xlim = c(0, 1), ylim = c(0,10),
     main = 'Average depth of covered L1 bases',
     ylab = 'Depth of covered bases in L1 elements',
     xlab = 'Proportion of L1 bases covered by at least one read')
graphics.off()

pdf(args[3])
plot(coverage$`Fraction of read at depth`, depthAtCovered, xlim = c(0, .2), ylim = c(1,2.5),
     main = 'Average depth of covered L1 bases',
     ylab = 'Depth of covered bases in L1 elements',
     xlab = 'Proportion of L1 bases covered by at least one read')
graphics.off()


sink("meanFraction.txt", append=TRUE)
mean(coverage$`Fraction of read at depth`)
sink()

sortDAC <- sort(depthAtCovered)
sink("meanNumber.txt", append = TRUE)
mean(sortDAC) 
sink()

sink("medFraction.txt", append=TRUE)
median(coverage$`Fraction of read at depth`)
sink()

sortDAC <- sort(depthAtCovered)
sink("medNumber.txt", append = TRUE)
median(sortDAC) 
sink()


