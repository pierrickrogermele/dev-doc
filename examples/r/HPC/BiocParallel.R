#!/usr/bin/env Rscript

a <- 5
v <- 1:10

fct <- function(x) x * 2 + a

unlist(lapply(v, fct))

unlist(BiocParallel::bplapply(v, fct))
