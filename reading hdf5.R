source('http://bioconductor.org/biocLite.R')
biocLite('rhdf5')
library(rdhf5)

created <- h5createFile('example.h5')