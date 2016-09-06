### R code from vignette source 'vignettes/UniProt.ws/inst/doc/UniProt.ws.Rnw'

###################################################
### code chunk number 1: loadPkg
###################################################
library(UniProt.ws)


###################################################
### code chunk number 2: help (eval = FALSE)
###################################################
## help("UniProt.ws")


###################################################
### code chunk number 3: show
###################################################
UniProt.ws


###################################################
### code chunk number 4: availSpecies
###################################################
availableUniprotSpecies(pattern="musculus")


###################################################
### code chunk number 5: setTaxID
###################################################
taxId(UniProt.ws) <- 10090
UniProt.ws


###################################################
### code chunk number 6: columns
###################################################
head(keytypes(UniProt.ws))


###################################################
### code chunk number 7: keytypes
###################################################
head(columns(UniProt.ws))


###################################################
### code chunk number 8: keys (eval = FALSE)
###################################################
## egs = keys(UniProt.ws, "ENTREZ_GENE")


###################################################
### code chunk number 9: select
###################################################
keys <- c("22627","22629")
columns <- c("PDB","UNIGENE","SEQUENCE")
kt <- "ENTREZ_GENE"
res <- select(UniProt.ws, keys, columns, kt)
head(res)


