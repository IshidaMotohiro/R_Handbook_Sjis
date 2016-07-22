context("Hello World function")

test_that("check a string:",{
            expect_match(hello(), "Hello, world!")
          } )
