# vi: ft=R

# Install latest version of Bioconductor
source("http://bioconductor.org/biocLite.R")
biocLite("BiocUpgrade")

# Install latest version of /genomes/ library
biocLite("genomes")
install.packages("genomes", repos="http://www.bioconductor.org/packages/devel/bioC", type="source")

# Load libraries
library("genomes")

# Load eukariotes data set
rm(euks)
data(euks)
update(euks)
print(euks)
