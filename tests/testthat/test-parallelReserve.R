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

test_that("parallelReserve (PARALLAX) returns expected structure and values", {
  result <- parallelReserve(triangle)
  expect_type(result, "list")
  expect_equal(as.numeric(result$reserve[3]), 30)
})

test_that("parallelReserve (REACT) returns expected structure and values", {
  result <- parallelReserve(triangle, method = "react")
  expect_equal(as.numeric(result$reserve), c(280, 310, 30, NA))
})