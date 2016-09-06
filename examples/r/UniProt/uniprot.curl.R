#!/usr/bin/env R --slave -f
# vi: ft=R

# Load libraries
library(RCurl)
#print(getURL("http://www.uniprot.org/uniprot/?query=gene:UNQ5982&format=tab"))
print(getURL("http://www.uniprot.org/uniprot/?query=accession:Q8WZ42&format=xml"))
