#!/usr/bin/env Rscript
library(methods)

A <- setRefClass("A")

A$methods( initialize = function(...) {
	callSuper(...)
	print('A constructor')
})

B <- setRefClass("B")

B$methods( initialize = function(...) {
	callSuper(...)
	print('B constructor')
})

C <- setRefClass("C", contains = c('A', 'B'))

C$methods( initialize = function(...) {
	callSuper(...)
	print('C constructor')
})

# Only the constructor of the first mother class is called. Which means that the fields of the other mother classes cannot be initialized with callSuper().
c <- C()
