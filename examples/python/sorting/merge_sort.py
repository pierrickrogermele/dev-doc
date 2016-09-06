#!/usr/bin/env python

# The merge sort algorithm uses a divide-and-conquer strategy. It splits the array to sort in two, and sorts these two parts recursively. Then it merges the two sorted subarrays.
#
# The algorithm is in O(n.log2(n))
#
# Since it uses  a divide-and-conquer strategy, it can be parallelized.

from common import run_sort

# Merge two consecutive subparts of an array. Indicies of the subparts are [p,q] and [q,r].
# The algorithm uses a buffer.
def merge(a, p, q, r):
	tmp = []
	i = p
	j = q + 1
	while i <= q or j <= r :
		if i <= q and (j > r or a[i] < a[j]) :
			tmp.append(a[i])
			i = i + 1
		else :
			tmp.append(a[j])
			j = j + 1

	# copy back buffer
	for i in range(len(tmp)) :
		a[p + i] = tmp[i]

# Merge sort. Use recursive algorithm
def do_merge_sort(a, i, j):
	if j - i + 1 > 2 :
		k = (j + i) / 2
		do_merge_sort(a, i, k)
		do_merge_sort(a, k + 1, j)
		merge(a, i, k, j)
	elif j - i + 1 == 2 and a[i] > a[j] :
		tmp = a[i]
		a[i] = a[j]
		a[j] = tmp

def merge_sort(a):
	do_merge_sort(a, 0, len(a)-1)

run_sort(globals().get('merge_sort'))
