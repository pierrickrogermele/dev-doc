#!/usr/bin/env Rscript

# Create an object of class Animal
obj <- list(type='bird', legs=2)
class(obj) <- 'Animal'
obj
# The class name is recorded as an attribute.

# Print the class
class(obj)

# Define a constructor
createAnimal <- function(type, legs) {
    obj <- list(type=type, legs=legs)
    attr(obj, 'class') <- 'Animal' # same as class(obj) <- 'animal'
    return(obj)
}
createAnimal('dog', 4)

# Implement the print() method for our class
print.Animal <- function(obj) {
    cat('A', obj$type, 'with', obj$legs, "legs.\n")
}
obj

# If the attribute class is missing, the default implementation of print() is used:
unclass(obj)

# Listing existing generic methods
methods(class="default")

# Defining our own generic function
myfct <- function(obj) {
    UseMethod("myfct")
}

# Implementing a default method
myfct.default <- function(obj) {
    cat("A default implementation.\n")
}

# Call myfct() on a object
obj <- createAnimal('serpent', 0)
myfct(obj)

# Implementing myfct() for an Animal instance
myfct.Animal <- function(obj) {
    cat("An implementation for the Animal class.\n")
}
myfct(obj)
