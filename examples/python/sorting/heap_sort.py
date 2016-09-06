#!/usr/bin/env python

# Heap sort algorithm is a comparison-based sorting algorithm. It consists in two steps:
# 1) a heap binary tree is built out of the data.
# 2) a sorted array is created by repeatedly removing the largest element from the heap, and inserting it into the array.
# The heap is reconstructed after each removal. 
#
# Heapsort can be performed in place. The array can be split into two parts, the sorted array and the heap. 
#
# Heapsort is an in-place algorithm, but it is not a stable sort (i.e.: it doesn't preserve the ordering of elements).
#
# The algorithm is in O(n.log2(n)), so better than quick sort in worst case.

from common import run_sort

def sift_down(a, start, end) :
	root = start
	while root * 2 + 1 <= end :
		child = root * 2 + 1
		swap = root

		# check if root is smaller than left child
		if a[swap] < a[child] :
			swap = child

		# check if right child exists, and if it's bigger that what we're currently swapping with
		if child + 1 <= end and a[swap] < a[child + 1] :
			swap = child + 1

		# swap if needed
		if swap != root :
			tmp = a[root]
			a[root] = a[swap]
			a[swap] = tmp
			root = swap
		else :
			return

def heapify(a) :
	start = (len(a) - 2) / 2
	while start >= 0 :
		sift_down(a, start, len(a) - 1)
		start = start - 1

def heap_sort(a) :
	heapify(a)
	end = len(a) - 1
	while end > 0 :
		# swap root of the heap with last element of the heap
		tmp = a[end]
		a[end] = a[0]
		a[0] = tmp

		end = end - 1
		sift_down(a, 0, end)

run_sort(globals().get('heap_sort'))
