#!/usr/bin/env R --slave -f

# !!! For inheritance to work, all arguments of a parent's constructor must have default values (i.e.: an empty constructor must be provided). This is a S4 requirements.

Square <- setRefClass("Square",
                      fields = list(a = "numeric"),
                      methods = list(
                      	initialize = function(a = 0, ...) {
                      		message('Square constructor with a = ', a)
                      		callSuper(...)
                      		a <<- a
                      },

					  foo = function() {
						  message('Square::foo()')
					  },
					  foo2 = function() {
						  message('Square::foo2()')
					  }
                      ))

Rectangle <- setRefClass("Rectangle", contains = "Square",
                         fields = list(b = "numeric"),
                         methods = list(
                            initialize = function(b, ...) {
                                message('Rectangle constructor with b = ', b)
                                callSuper(...)
                                b <<- b
                            },
					  foo = function() {
						  message('Rectangle::foo()')
					  }
                        ))
# Constructors calls
r1 <- Rectangle(4)
r2 <- Rectangle(a=2, b=4)

# Calling a method dynamically
# Where is function foo()?
# By default, function foo() is not in the names of r1:
'foo' %in% names(r1)
# But if we call it explicitly:
r1$foo()
# then now, it's in the names of r1:
'foo' %in% names(r1)
# So to call dynamically a method, we must evaluate the expression as a string:
eval(parse(text = 'r1$foo2()'))
