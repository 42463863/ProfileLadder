library(testthat)
library(ProfileLadder)

# Example triangle
triangle <- matrix(
  c(100, 120, 130,
    80,  90,  NA,
    60,  NA,  NA),
  nrow = 3,
  byrow = TRUE
)

test_that("mcReserve returns expected structure and values", {
  result <- mcReserve(triangle)
  expect_type(result, "list")
  expect_equal(as.numeric(result$reserve), c(280,290,10,NA))
  expect_equal(as.numeric(result$MarkovChain$states), c(10,20))
  expect_equal(as.numeric(result$MarkovChain$breaks), c(-Inf, 20, Inf))
})

test_that("mcReserve accessors works properly", {
  result <- mcReserve(triangle)
  expect_equal(as.numeric(mcStates(result)), c(10,20))
  expect_equal(as.numeric(mcBreaks(result)), c(-Inf, 20, Inf))
  expect_equal(mcTrans(result), rbind(c(0,0), c(1,0)))
})