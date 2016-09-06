#!/usr/bin/env Rscript
# vi: ft=R

con <- file("stdin")
v <- scan(file = con, what = character(), quiet = TRUE)
print(v)
close(con)
