library(testthat)
library(ProfileLadder)


test_that("incrExplor test for DEFAULT", {
  result <- incrExplor(CameronMutual)
  expect_type(result, "list")
  expect_type(result$MarkovChain, "list")
  expect_equal(as.numeric(result$MarkovChain$states), c(13, 81, 197, 302.5, 438, 601, 948, 1672.5, 3073, 3993))
  expect_equal(as.numeric(result$MarkovChain$breaks[c(1,11)]), c(-Inf, Inf))
})


test_that("incrExplor test for user-based modifications", {
  result <- incrExplor(CameronMutual, out = 0)
  expect_equal(sum(result$userDefined$increments), 105159)
  expect_equal(result$userDefined$method, "DEFAULT (median)")
})
