import random
from time import time

def check(a):
	for i in range(len(a)-1):
		assert a[i] <= a[i+1]

def make_random_array(n):
	a = []
	for i in range(n):
		a.append(random.randint(1,1000))
	return a

def make_sorted_array(n):
	return range(n)

def make_reverse_sorted_array(n):
	return range(n, 0, -1)

def time_sort(sort_algo, a):
	start = time()
	sort_algo(a)
	end = time()
	check(a)
	return end - start

def run_sort(sort_algo):
	n = 1000
	print("random  {0} {1}".format(n, time_sort(sort_algo, make_random_array(n))))
	print("sorted  {0} {1}".format(n, time_sort(sort_algo, make_sorted_array(n))))
	print("reverse {0} {1}".format(n, time_sort(sort_algo, make_reverse_sorted_array(n))))
