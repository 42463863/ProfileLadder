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


test_that("ProfileLadder class assignment", {
  set.seed(1234)
  result <- as.profileLadder(triangle)
  ### structure tests
  expect_type(result, "list")
  expect_equal(result$method, "Run-off triangle")
  ### formal corectness 
  expect_equal(is.na(result$FullTriangle), TRUE)
  expect_equal(is.na(result$trueComplete), TRUE)
  ### bootstrap performance
  expect_equal(as.numeric(result$reserve), c(280, NA, NA, NA))
})

