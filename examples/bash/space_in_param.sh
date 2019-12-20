#!/usr/bin/env bash

function foo {
	local a=$1
	local b=$2
	local c=$3
	local d=$4

	echo "a=$a"
	echo "b=$b"
	echo "c=$c"
	echo "d=$d"
}

foo a b c d
foo "a b" c d

echo
echo 'x="a b"'
x="a b"
foo $x
foo "$x"

echo
echo 'x="\"a b\""'
x="\"a b\""
foo $x
foo "$x"

echo
echo 'x="-a \"z o\" -b -c"'
x="-a \"z o\" -b -c"
foo $x
foo "$x"

echo
echo Using an array
a=()
a+=(-a)
a+=("z o")
a+=(-b)
a+=(-c)
foo ${a[@]}
foo "${a[@]}"
