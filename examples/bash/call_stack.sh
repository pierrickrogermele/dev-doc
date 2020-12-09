# Display the function, source filename and line number from the call stack

function foo2 {
	echo "CURRENT LINE=$LINENO"
	echo "LINES=${BASH_LINENO[@]}"
	echo "FCTS=${FUNCNAME[@]}"
	echo "FILE=${BASH_SOURCE[@]}"
}

function foo {
	echo "CURRENT LINE=$LINENO"
	echo "LINES=${BASH_LINENO[@]}"
	echo "FCTS=${FUNCNAME[@]}"
	echo "FILE=${BASH_SOURCE[@]}"
	foo2
}

echo "CURRENT LINE=$LINENO"
foo
