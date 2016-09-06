### R code from vignette source 'vignettes/genomes/inst/doc/genome-tables.Rnw'

###################################################
### code chunk number 1: setup
###################################################
library(genomes)
options(warn=-1, width=75, digits=2, scipen=3,  "prompt" = "R> ", "continue" = " ")
options(SweaveHooks=list(fig=function() par(mar=c(5,4.2,1,1))))


###################################################
### code chunk number 2: biocLite (eval = FALSE)
###################################################
## source("http://bioconductor.org/biocLite.R")
## biocLite("genomes")


###################################################
### code chunk number 3: install (eval = FALSE)
###################################################
## install.packages("genomes", 
##    repos="http://www.bioconductor.org/packages/devel/bioC", type="source")


###################################################
### code chunk number 4: proks
###################################################
data(proks)
proks
summary(proks)
plot(proks, log='y', las=1)



###################################################
### code chunk number 5: update (eval = FALSE)
###################################################
## update(proks)


###################################################
### code chunk number 6: table2
###################################################
spp<-species(proks$name)
table2(spp)


###################################################
### code chunk number 7: complete
###################################################
complete <- subset(proks, status == "Complete")
x <- table(year(complete$released))
barplot(x, col="blue", ylim=c(0,max(x)*1.04), space=0.5, las=1,
axis.lty=1, xlab="Year", ylab="Genomes per year")
box()


###################################################
### code chunk number 8: yersinia
###################################################
## Yersinia pestis
yp<-subset(proks, name %like% 'Yersinia pestis*' & year(released)<2012 )
plotby(yp, labels=TRUE, cex=.5, lbty='n', curdate=FALSE)



