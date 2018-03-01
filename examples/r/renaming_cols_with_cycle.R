#!/usr/bin/env Rscript

# From StackOverflow [loop for renaming columns in r](https://stackoverflow.com/questions/48922668/loop-for-renaming-columns-in-r/48923140#48923140).

    # Make a copy mydata column names
    newnames <- names(mydata)
    
    # Build input data
    mydata <- data.frame(a=1,b=2,c=3,d=4,e=5,e=6,e=7,e=8,f=9)
    for (i in seq(10:440)) mydata[[i]] <- 10
    
    # A vector of variable names for the sake of the example
    varnames <- paste('var', 1:45)
    
    # Set new variable names
    newnames[10:length(newnames)] <- paste(rep(varnames, each = 10)[1:(length(newnames)-9)], 1:10, sep = '_')
    
    # Commit your changes
    names(mydata) <- newnames
    
    # Result
    names(mydata)[1:20]
