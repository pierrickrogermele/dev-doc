#!/usr/bin/env Rscript

# Define a class:
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

# Getting the names of the slots:
slotNames("Rectangle")

# Getting the names and the types of the slots:
getSlots("Rectangle")

# Getting also inheritance information:
getClass("Rectangle")

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
# Remove a class
removeClass("Animal")
