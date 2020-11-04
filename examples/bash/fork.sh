#!/bin/bash

child() {
	local n=$1
	#local pid=$(sh -c 'echo $PPID') # TODO This call blocks

	echo "CHILD $n \$\$ = $$ (child has same PID as parent)"
	echo "CHILD $n \$PPID = $PPID (child and parent has same PPID !!!)"
	#echo "CHILD $n real PID = $pid"
}

echo START
for n in 1 2 ; do
	child $n &
	echo "PARENT Child $n PID = $! (this is the real child PID)"
done
echo "PARENT \$\$ (current PID) = $$ (child has same PID as parent)"
echo "PARENT \$PPID (parent PID) = $PPID (child and parent has same PPID !!!)"
