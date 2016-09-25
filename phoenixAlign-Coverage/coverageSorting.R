setwd("~/Documents/University/Honours_2016/Project/ReadCoverage/Combined/")

coverage <- read.table(file = "./AllMut.STAR.O2.bO.coverage.bed")
colnames(coverage) <- c("chromosome", "start", "stop", "read", "Unique", "Strand", "# reads", "Bases covered", "L1 length", "Fraction covered")

head(coverage)

hist(coverage$`Fraction covered`)

hist(coverage$`L1 length`)

highCoverage <- coverage
 
plot(coverage$`L1 length`, coverage$`Fraction covered`,
     xlab = "L1 length",
     ylab = "Fraction of L1 covered",
     cex = .5)
