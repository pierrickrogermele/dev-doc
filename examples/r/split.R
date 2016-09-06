#!/usr/bin/env R --slave -f

# Split at ;
v <- strsplit('aaa; bbb;ccc ;ddd', ';')
print(v)
print(paste('V = ',v))

# Split at new line
v <- strsplit("aaa\n bbb\nccc \nddd", "\n")
print(v)
print(paste('V = ',v))
