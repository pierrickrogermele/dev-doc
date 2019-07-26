#!/usr/bin/env Rscript

# A vector of integers
n = c(2L, 3L, 5L)
print(n)

# A vector of strings
s = c("aa", "bb", "cc", "dd", "ee") 
print(s)

# A vector of logicals
b = c(TRUE, FALSE, TRUE, FALSE, FALSE) 
print(b)

# Construct a list (i.e.: a generic vector)
x = list(n, s, b, 3)   # x contains copies of n, s, b
print(x)

# Construct a hash map
m = list()
m["key1"] = "value1"
m["key2"] = "value2"
m$key3 = "value3"
print(m)

# Map
cat("\nUse the Map function to apply an operation on each element.\n")
x=1:100
unlist(Map({function (a) a*2}, x))

# Reduce
cat("\nUse the Reduce function to compute a function on the values of a vector to obtain a scalar.\n")
x=seq(1,10,0.5)
Reduce(function (x, y) x+y, x)

# Filter
cat("\nUse the Filter function to filter out some values from a vector.\n")
x=1:10
Filter(function (x) x%%2==0, x)
