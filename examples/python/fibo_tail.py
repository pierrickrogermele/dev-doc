def fibo(n, f_n_1 = 1, f_n = 0):  # (n, F_{n-1}, F_n)
	if (n == 0):  # cas de base
		return f_n
	else:         # récurrence
		return fibo(n - 1, f_n, f_n + f_n_1)
