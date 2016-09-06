#!/usr/bin/env python

# The quick sort, or partition-exchange sort, algorithm uses a divide-and-conquer strategy. It splits the array in two, and makes sure the left part contains smaller elements than the right part. Then it make recursive calls to the subparts.
#
# Quicksort is a comparison sort and, in efficient implementations, is not a stable sort.
# Quicksort is an in-place sort.
#
# The algorithm is in O(n.log(n)) in average case, and O(n^2) in worst case.
# Worst case happens when each time we partition a subarray [i,j] we get two unbalanced subarrays [i] and [i+1,j].
# The best case is when each time we partition a subarray [i,j] we get two balanced (same size) subarrays [i,(i+j)/2] and [(i+j)/2+1,j].
#
# If the pivot is taken each time in middle of the subarray, then the cases of sorted inputs (direct or reverse) are best cases.
# If the pivot is taken at start or end of the subarray, then the cases of sorted inputs (direct or reverse) are worst cases.
# If we take the pivot randomly then we get an average case on each run.
#
# Since it uses  a divide-and-conquer strategy, it can be parallelized.
#
# The worst-case in O(n^2) is a security risk when the algorithm is used on large data set and exposed to attacks.
#
# Improvements of the implementation:
# _ To make sure at most O(log N) space is used, recurse first into the smaller half of the array, and use a tail call to recurse into the other.
# _ Use insertion sort for small subarrays.
# _ Choose the pivot by taking an index by random. This makes the worst-case unpredictable, and protects the algorithm again security risk, unless the random number generator is predictable and someone can get information about it.

from common import run_sort

def do_quick_sort(a, start, end) :
	i = start
	j = end
	x = a[(start+end)//2] # use middle element as pivot
	while i <= j :
		while a[i] < x : # search for a larger element
			i = i + 1
		while a[j] > x : # search for a smaller element
			j = j - 1

		if i <= j :
			tmp = a[i]
			a[i] = a[j]
			a[j] = tmp
			i = i + 1
			j = j - 1

	if start < j :
		do_quick_sort(a, start, j)

	if i < end :
		do_quick_sort(a, i, end)

def quick_sort(a):
	do_quick_sort(a, 0, len(a) - 1)

run_sort(globals().get('quick_sort'))
