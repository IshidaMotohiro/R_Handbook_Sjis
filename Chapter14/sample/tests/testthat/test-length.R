context("lengthChar function")

x <- "this is test."

test_that("check length of string:",{
  expect_equal(lengthChar(x) , 13)
} )

