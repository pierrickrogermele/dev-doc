library(testthat)
source("foo.R")

test.foo <- function(v, w) {
	expect_equal(foo(v), w)
}

test.foo.na <- function() {
	expect_true(is.na(foo(NA_integer_)))
}

test.foo.computes <- function() {
	expect_equal(foo(0), 0)
	expect_equal(foo(1), 2)
	expect_equal(foo(-4), -8)
}

context("Testing foo")

test_that("foo returns NA", test.foo.na())
test_that("foo computes normaly", test.foo.computes())
test_that("foo computes some vals", test.foo(10, 20))
