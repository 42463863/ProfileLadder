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


test_that("permutation bootstrap validity", {
  set.seed(1234)
  result <- permuteReserve(parallelReserve(triangle), B = 50)
  ### structure tests
  expect_type(result, "list")
  expect_type(result$eSummary, "double")
  expect_type(result$pSummary, "double")
  ### formal corectness 
  expect_equal(length(result$pReserves), 50)
  expect_equal(dim(result$pUltimates), c(50,3))
  expect_equal(dim(result$pLatest), c(50,3))
  expect_equal(dim(result$pLatestCum), c(50,3))
  expect_equal(dim(result$pFirst), c(50,3))
  ### bootstrap performance
  expect_equal(round(as.numeric(result$pSummary)[1]), 38)
  expect_equal(round(as.numeric(result$pSummary)[2]), 6)
  expect_equal(round(as.numeric(result$pSummary)[3]), 16)
  expect_equal(round(as.numeric(result$pSummary)[4]), 1)
})

