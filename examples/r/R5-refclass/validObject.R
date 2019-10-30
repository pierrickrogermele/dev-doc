#!/usr/bin/env Rscript

A <- setRefClass('A', fields=list(a='numeric'),
    methods=list(
       initialize=function(a=0) {
           a <<- a
       }
))

setValidity("A", function(object) {
    if (object$a < 0)
        return("WRONG ! `a` cannot be negative.")
    return(TRUE)
})

A()
A(-1)


