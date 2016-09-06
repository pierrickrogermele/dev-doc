#!/usr/bin/env python

# The bubble sort algorithm goes from left to right inside the array, and permutes all consecutive elements so that a[i+1] > a[i]. It repeats the operation until it can find no consecutive elements to permute.
# The algorithm running time is in O(n^2).

from common import run_sort

def bubble_sort(a):
	# loop until there are no elements to swap
	while True:
		did_swap = False

		# loop on all elements from left to right
		for i in range(len(a)-1):

			# find two consecutive elements to swap
			if a[i] > a[i+1]:
				did_swap = True
				tmp = a[i]
				a[i] = a[i+1]
				a[i+1] = tmp

		# quit while loop, since there are no more elements to swap
		if not did_swap:
			break

run_sort(globals().get('bubble_sort'))
