#!/usr/bin/env Rscript

Rcpp::sourceCpp(code='
// @@@BEGIN_CPP@@@
#include <vector>
#include <iostream>
#include <Rcpp.h>

//[[Rcpp::export]]
std::vector<int> foo(std::vector<int>& v) {

	v.push_back(1);
	v.push_back(2);
	v.push_back(3);

	std::cout << &v[0] << std::endl;
	std::cout << v.size() << std::endl;

	return(v);
}

//[[Rcpp::export]]
Rcpp::IntegerVector foo2(Rcpp::IntegerVector v) {

	v.push_back(1);
	v.push_back(2);
	v.push_back(3);

	std::cout << &v[0] << std::endl;
	std::cout << v.size() << std::endl;

	std::vector<int> w = Rcpp::as<std::vector<int> >(v);
	std::cout << &w[0] << std::endl;
	std::cout << w.size() << std::endl;

	std::vector<int> x = Rcpp::as<std::vector<int> >(v);
	std::cout << &x[0] << std::endl;
	std::cout << x.size() << std::endl;

	return(v);
}
// @@@END_CPP@@@
')

x <- integer()
foo(x)
x
foo2(x)
x
foo2(x)
x
