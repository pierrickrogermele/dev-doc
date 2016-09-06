def fibo(n):
	f_n_1 = 1  # F_{-1} = 1
	f_n = 0    # F_0 = 0
	for i in range(n):  # n fois
		(f_n_1, f_n) = (f_n, f_n + f_n_1)
	return f_n
