#!/usr/bin/env python3

# Create test file
filename = "file_overwriting.txt"
with open(filename, 'w') as f:
    f.write("bbccdde\n")
print('Initial content of file is:')
with open(filename, 'r') as f:
    print(f.readline())

# Inserting characters at start of file
s = 'aa'
wbuf = bytes(s, encoding='utf-8')
print("Inserting \"%s\" at the beginning of the file." % s)
n=len(wbuf)
with open(filename, 'r+b') as f:
    while len(wbuf) > 0:
        pos=f.tell()
        rbuf = f.read(n)
        f.seek(pos)
        f.write(wbuf)
        wbuf=rbuf
print('Content of file after insertion is:')
with open(filename, 'r') as f:
    print(f.readline())
