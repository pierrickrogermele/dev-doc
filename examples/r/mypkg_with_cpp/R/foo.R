#' @export
foo <- function(x) {
	return(x*2)
}

#' @import methods
#' @export MyFooClass
MyFooClass <- methods::setRefClass('MyFooClass')

MyFooClass$methods( initialize = function(...) {
	callSuper(...)
})
