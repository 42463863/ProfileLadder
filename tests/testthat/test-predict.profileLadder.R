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


test_that("predict method for PARALLAX and REACT", {
  ### structure of the output
  result <- predict(parallelReserve(triangle))
  expect_s3_class(result, "list")
  expect_type(result$reserve, "double")
  expect_equal(dim(result$extTriangle), c(3,4))
  
  ### formal corectness 
  expect_equal(length(result$newDiagonal), 3)
  expect_equal(result$newDiagonal, c(70,100,130))
})

test_that("predict method for MACRAME", {
  ### structure of the output
  result <- predict(mcReserve(triangle))
  expect_s3_class(result, "list")
  expect_type(result$reserve, "double")
  expect_equal(dim(result$extTriangle), c(3,4))
  
  ### formal corectness 
  expect_equal(length(result$newDiagonal), 3)
  expect_equal(result$newDiagonal, c(70,90,130))
})

