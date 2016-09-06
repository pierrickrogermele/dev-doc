#!/usr/bin/env python

# The direct sort algorithm goes from left to right inside the array, and for each element tries to find a smaller element in the right part of the array. If it finds it, then it permutres the both elements.
# At any time of the algorithm, the left part is sorted in increasing order.
# The algorithm running time is in O(n^2).

from common import run_sort

# sort
def direct_sort(a):
	# goes from left to right inside the array
	for i in range(len(a)-1):
		k = i

		# look inside the right part of the array for an element smaller than the ith element
		for j in range (i + 1, len(a)):
			if a[j] < a[k]:
				k = j

		# exchange kth element and ith element
		if k != i:
			tmp = a[i]
			a[i] = a[k]
			a[k] = tmp

run_sort(globals().get('direct_sort'))
