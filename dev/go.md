GO
==

## Install

 * [Getting started on MacOS-X](https://golang.org/doc/install?download=go1.5.3.darwin-amd64.pkg).

## Run

To compile a Go program whose sources are installed in `/my/dir/src/my/prog`:
```bash
GOPATH=/my/dir go install my/prog
```
Go compile sources and install compile program inside `bin` folder, at the same level as the `src` folder.

## Hello world example

```go
package main

import "fmt"

func main() {
	fmt.Printf("hello, world\n")
}
```

## Array

## Slices

```go
b[:2] == []byte{'g', 'o'}   // elements 0 and 1
b[2:] == []byte{'l', 'a', 'n', 'g'} // all elements starting at element 2
b[:] == b // all elements
```
