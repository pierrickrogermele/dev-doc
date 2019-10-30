#!/usr/bin/env Rscript

# Define a class:
setClass("Animal", representation=representation(type='character', legs='integer'))
# the `slots` field can be used instead of `representation`: 
setClass("Animal", slots=list(type='character', legs='integer'))

# Creating an object:
obj <- new("Animal", type='bird', legs=2L)
obj

# Test if an object is an S4 object:
isS4(obj)

# Creating an object is eased by the generator function built by setClass():
Animal <- setClass("Animal", slots=list(type='character', legs='integer'))
Animal(type='dog', legs=4L)

# Setting default values for members
Animal <- setClass("Animal", representation=representation(type='character', legs='integer'),
                   prototype=prototype(type='bird', legs=2L))
Animal()

# Access a slot:
obj@type
# or with the slot() function:
slot(obj, "type")

# Modify a slot:
obj@legs <- 3L
obj
# or using the slot() function:
slot(obj, "legs") <- 2L
obj

# List all S4 generic functions:
showMethods()

# Test if a function is an S3 generic function or an S4 generic function:
isS4(print)
isS4(show)

# List all methods of an S4 generic function:
showMethods(show)

# Implementing a show() method (equivalent of S3 print()) for a class:
args(show) # Checks the arguments of show()
setMethod("show", "Animal", function(object) {
    cat('A', object@type, 'with', object@legs, "legs.\n")
})
obj

# Validity checking
setValidity("Animal", function(object) {
    if (nchar(object@type) == 0)
        return("Type cannot be empty.")
    return(TRUE)
})
Animal(type="", legs=40L)

# The validity can also be set inside the class definition:
MyClass <- setClass("MyClass", representation=representation(n='integer'),
                    validity=function(object) { if (object@n > 0) TRUE else "WRONG" })
MyClass(n=-1L)
MyClass(n=10L)

# Inheritance
Square <- setClass("Square", representation(a='numeric'))
Square(a=10)
Rectangle <- setClass("Rectangle", representation(b='numeric'), contains="Square")
Rectangle(a=20, b=10)

# Define a generic
setGeneric(name="computeArea", def=function(object) {standardGeneric("computeArea")})

# Define method for Square
setMethod("computeArea", signature="Square",
          definition=function(object) { return(object@a * object@a) })
computeArea(Square(a=10))

# Avoid redefinition of a generic
lockBinding("computeArea", .GlobalEnv)

# Look at methods of a class
showMethods(class="Square")
showMethods(class="Rectangle")

# Get the definition of a method
getMethod("computeArea", signature="Square")

# Tests if a method exists for a class
existsMethod("show", signature="Square")
existsMethod("computeArea", signature="Square")

# Default values in initializer
cl <- setClass("MyClass", representation=representation(a='integer'),
               prototype=prototype(a=4L))
cl()

# Empty object
cl <- setClass("MyClass", representation=representation(a='integer'))
cl()
length(cl())
args(length)
setMethod("length", "MyClass", function(x) { return(length(x@a)) })
length(cl())

# Initializer
setValidity("MyClass", function(object) {
    if (object@a == 0L)
        return("WRONG")
    return(TRUE)
})
setMethod("initialize", "MyClass", function(.Object, a=0L) {
              .Object@a <- a
              validObject(.Object)
              return(.Object)
               })
cl()
cl(4L)
validObject(cl)

setMethod("initialize", "MyClass", function(.Object, a) {
              if (  ! missing(a)) {
                  .Object@a <- a
                  validObject(.Object)
              }
              return(.Object)
               })

# Remove a class
removeClass("Animal")

# A generic method with 2 arguments:
setGeneric("myMethodWith2Args", function(a, b) { standardGeneric("myMethodWith2Args") })
setMethod('myMethodWith2Args', 'integer', function(a, b) { a * b })
setMethod('myMethodWith2Args', 'numeric', function(a, b) { a + b })
showMethods('myMethodWith2Args')
myMethodWith2Args(1L, 2L)
myMethodWith2Args(1, 2)
myMethodWith2Args(1L, 2)
myMethodWith2Args(1, 2L)
setMethod('myMethodWith2Args', c(a='integer', b='numeric'), function(a, b) { a / b })
showMethods('myMethodWith2Args')
myMethodWith2Args(1L, 2)
myMethodWith2Args(1L, 2L)
setMethod('myMethodWith2Args', c(a='integer', b='missing'), function(a, b) { cat("b is missing.\n") })
myMethodWith2Args(3L)
setMethod('myMethodWith2Args', c(a='integer', b='ANY'), function(a, b) { cat("b is whatever.\n") })
myMethodWith2Args(3L, TRUE)

# Using super class method in inheritance
A <- setClass('A', representation=representation(x='numeric'), prototype=prototype(x=1))
setMethod('show', 'A', function(object) { cat("I'm A with x=", object@x, ".\n") })
A()
B <- setClass('B', contains='A', representation=representation(y='numeric'), prototype=prototype(y=2))
setMethod('show', 'B', function(object) { show(as(object, "A")); cat("I'm B with y=", object@y, ".\n") })
B()
C <- setClass('C', contains='A', representation=representation(z='numeric'), prototype=prototype(z=3))
setMethod('show', 'C', function(object) { callNextMethod() ; cat("I'm C with z=", object@z, ".\n") })
C()

setIs('C', 'B', coerce=function(from, to) {
          to <- B()
          to@y = from@z
          return(to)
               },
          replace=function(from, value) {
              from@z <- value
              return(from)
          }
)
as(C(), 'B')
as(B(), 'C')

# Virtual class
A <- setClass('A', representation=representation(x='numeric', 'VIRTUAL'))
A()
