# vi: ft=R

# Install latest version of Bioconductor
source("http://bioconductor.org/biocLite.R")
biocLite("BiocUpgrade")

# Install latest version of /genomes/ library
biocLite("UniProt.ws")

# Load libraries
library(UniProt.ws)

# List all available keys
print(keytypes(UniProt.ws))

# List all available columns
print(columns(UniProt.ws))

# Search from Entrez ID
rm(res)
res <- select(UniProt.ws,
			  keys=c("5982"),
			  columns=c("UNIPROTKB"),
			  keytype="ENTREZ_GENE")
print(res)

# Search from UniProt ID
rm(res)
res <- select(UniProt.ws,
			  keys=c("Q75MT5"),
			  columns=c("ENTREZ_GENE"),
			  keytype="UNIPROTKB")
print(res)

# Get sequence & co
cols <-	c("UNIPROTKB",    # UniProt Knowledge Base
		                # Accession (UniProt ID)
		"EC",           # Enzyme entry (EXPASY ID enzyme.expasy.org)
		                # Enzyme name
		"LENGTH",       # Sequence length aa (amino acids)
		"DOMAIN",       # Protein domain ???
		"DOMAINS",      # Protein domain ???
		"SEQUENCE"      # Sequence
		                # Tissue specificity
		                # Genome RNAi (swissprot)
		                # Protein reference
						)

print(select(UniProt.ws, keys=c("5982"), columns=cols, keytype="ENTREZ_GENE"))
print(select(UniProt.ws, keys=c("Q8WZ42"), columns=cols, keytype="UNIPROTKB"))

# Search from sequence (blastp)
# ==> not available
