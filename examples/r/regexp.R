#!/usr/bin/env R --slave -f


if (grepl("^<!toto", "<!toto", perl=TRUE))
	print("FOUND toto")

if (grepl("^<!toto", c("tagada", "zou", "<!toto"), perl=TRUE))
	print("FOUND toto")
