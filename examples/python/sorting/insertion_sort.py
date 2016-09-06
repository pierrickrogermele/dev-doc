#!/usr/bin/env python

# The insertion sort algorithm takes each element starting at the second and search for the right place to insert on the left part of the array. So at each step the left part of the array is sorted, while the right part contains remaining elements to sort.
# The algorithm is in O(n^2).

from common import run_sort

# sort
def insertion_sort(a):
	# goes from left to right
	for j in range(1, len(a)):
		key = a[j]
		i = j - 1

		# look in the left part for the right place where to insert a[j]
		while i >= 0 and a[i] > key:
			a[i+1] = a[i]
			i = i - 1

		# insert a[j]
		a[i+1] = key

run_sort(globals().get('insertion_sort'))
