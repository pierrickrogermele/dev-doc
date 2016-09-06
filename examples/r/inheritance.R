#!/usr/bin/env R --slave -f

Square <- setRefClass("Square", fields = list( a = "numeric"))

# !!! For inheritance to work, all arguments of a parent's constructor must have default values (i.e.: an empty constructor must be provided). This is a S4 requirements.
Square$methods( initialize = function(a = 0, ...) {
                a <<- a
                callSuper(...)
                }
              )

Rectangle <- setRefClass("Rectangle", contains = "Square", fields = list( b = "numeric"))

Rectangle$methods( initialize = function(b, ...) {
                b <<- b
                callSuper(...)
                }
              )
