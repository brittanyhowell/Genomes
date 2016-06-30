args = commandArgs(trailingOnly = TRUE)


medFrac <- read.table(file = args[1])
medNum <- read.table(file = args[2])
colnames(medFrac) <- c("Num", "Values")
colnames(medNum) <- c("Num", "Values")

parametersMatch <- read.table(args[3])
parametersMap <- read.table(args[4])

meds <- cbind(parametersMatch, parametersMap, medFrac$Values, medNum$Values, deparse.level = 0)


colnames(meds) <- c("Mismatches", "MultiMaps", "fractionCovered", "depthAtCovered" )


write.table(meds, file = args[5])