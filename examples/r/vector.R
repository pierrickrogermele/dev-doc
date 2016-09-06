#!/usr/bin/env R --slave -f

# A vector of integers
n = c(2, 3, 5)
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
