library(testthat)
library(ProfileLadder)


test_that("performance of the observed function", {
  expect_equal(as.logical(observed(1)), TRUE)
  expect_equal(sum(observed(2)), 3)
  expect_equal(sum(as.numeric(CameronMutual == observed(CameronMutual)), na.rm = T), 55)
})



