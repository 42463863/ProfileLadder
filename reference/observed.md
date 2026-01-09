# Observed Run-Off Triangle Layout vs. Predicted (Unknown) Layout

Simple layout function to allow work with fully developed run-off
triangles (i.e., completed squares that also contain typically unknown
(future) claim payments). Such data are not common in actuarial practice
but they are usefull for retrospective analysis and back-testing
purposes.

## Usage

``` r
observed(object, cum = TRUE)
```

## Arguments

- object:

  either an integer value to denote the dimension of the run-off
  triangle layout (i.e., the value that represents the number of origins
  (rows) and also the number of the development periods (columns)).
  Alternatively, a cumulative or incremental run-off triangle (i.e, an
  object of the class `matrix` or `triangle`) can be provided in
  `object`. In such case the output returns the standard run-off
  triangle with `NA` values in the lower-right triangular part of the
  matrix (regardless of wheter the input triangle in `object` forms a
  run-off triangle or it is a fully observed triangle—data matrix)

- cum:

  logical to indicate whether the output run-off triangle is supposed to
  be of a cumulative type (`DEFAULT`) or an incremental type
  (`cum = FALSE`). If the input in `object` is an integer value (i.e.,
  the dimension of the run-off triangle) then the choice of the `cum`
  parameter is ignored

## Value

If `object` is an integer value then the function returns a TRUE/FALSE
layout matrix with the `TRUE` values for the observed (known) part of
the run-off triangle (the upper-left triangular part of the matrix) and
values `FALSE` otherwise. If `object` is a matrix (an object of the
class `matrix` or `triangle`) then the function returns the observed
(known) part of the run-off triangle with `NA` values elsewhere.
Depending on the choice of the `cum` parameter, either a cumulative
(`DEFAULT`) or incremental (`cum = FALSE`) run-off triangle is returned

## See also

[`plot.profileLadder()`](https://42463863.github.io/ProfileLadder/reference/plot.profileLadder.md),
[`parallelReserve()`](https://42463863.github.io/ProfileLadder/reference/parallelReserve.md),
[`mcReserve()`](https://42463863.github.io/ProfileLadder/reference/mcReserve.md)

## Examples

``` r
## observed/unobserved layout for the run-off triangle with 5 origins
print(observed(5))
#>      [,1]  [,2]  [,3]  [,4]  [,5]
#> [1,] TRUE  TRUE  TRUE  TRUE  TRUE
#> [2,] TRUE  TRUE  TRUE  TRUE FALSE
#> [3,] TRUE  TRUE  TRUE FALSE FALSE
#> [4,] TRUE  TRUE FALSE FALSE FALSE
#> [5,] TRUE FALSE FALSE FALSE FALSE
print(!observed(5))
#>       [,1]  [,2]  [,3]  [,4]  [,5]
#> [1,] FALSE FALSE FALSE FALSE FALSE
#> [2,] FALSE FALSE FALSE FALSE  TRUE
#> [3,] FALSE FALSE FALSE  TRUE  TRUE
#> [4,] FALSE FALSE  TRUE  TRUE  TRUE
#> [5,] FALSE  TRUE  TRUE  TRUE  TRUE

## fully observed run-off triangle with typically unknown (future) payments
## included in the lower-right triangular part for evaluation purposes
data(CameronMutual) ## the full data matrix
observed(CameronMutual) ## cummulative run-off triangle
#>       dev
#> origin    1     2     3     4     5     6     7     8     9    10
#>     1  5244  9228 10823 11352 11791 12082 12120 12199 12215 12215
#>     2  5984  9939 11725 12346 12746 12909 13034 13109 13113    NA
#>     3  7452 12421 14171 14752 15066 15354 15637 15720    NA    NA
#>     4  7115 11117 12488 13274 13662 13859 13872    NA    NA    NA
#>     5  5753  8969  9917 10697 11135 11282    NA    NA    NA    NA
#>     6  3937  6524  7989  8543  8757    NA    NA    NA    NA    NA
#>     7  5127  8212  8976  9325    NA    NA    NA    NA    NA    NA
#>     8  5046  8006  8984    NA    NA    NA    NA    NA    NA    NA
#>     9  5129  8202    NA    NA    NA    NA    NA    NA    NA    NA
#>     10 3689    NA    NA    NA    NA    NA    NA    NA    NA    NA
observed(CameronMutual, cum = FALSE) ## incremental run-off triangle
#>       dev
#> origin    1    2    3   4   5   6   7  8  9 10
#>     1  5244 3984 1595 529 439 291  38 79 16  0
#>     2  5984 3955 1786 621 400 163 125 75  4 NA
#>     3  7452 4969 1750 581 314 288 283 83 NA NA
#>     4  7115 4002 1371 786 388 197  13 NA NA NA
#>     5  5753 3216  948 780 438 147  NA NA NA NA
#>     6  3937 2587 1465 554 214  NA  NA NA NA NA
#>     7  5127 3085  764 349  NA  NA  NA NA NA NA
#>     8  5046 2960  978  NA  NA  NA  NA NA NA NA
#>     9  5129 3073   NA  NA  NA  NA  NA NA NA NA
#>     10 3689   NA   NA  NA  NA  NA  NA NA NA NA
```
