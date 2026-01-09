# Print Objects of the S3 Class `profilePredict`

Function to organize and print the 1-year prediction based on the
PARALLAX and REACT algorithm
([`parallelReserve()`](https://42463863.github.io/ProfileLadder/reference/parallelReserve.md))
or the MACRAME algorithm
([`mcReserve()`](https://42463863.github.io/ProfileLadder/reference/mcReserve.md))

## Usage

``` r
# S3 method for class 'profilePredict'
print(x, fancy.print = getOption("profileLadder.fancy", TRUE), ...)
```

## Arguments

- x:

  an object of the class `profileLadder` resulting from a call of one of
  the functions
  [`parallelReserve()`](https://42463863.github.io/ProfileLadder/reference/parallelReserve.md)
  or `mcReserve`

- fancy.print:

  logical to indicate whether a fancy run-off triangle should be printed
  in the output (DEFAULT) or a standard print option should be used
  instead. Note that that the fancy print option uses, by DEFAULT, zero
  number of decimal digits. Specific colors for the fancy print option
  and the number of decimal points to be used can be set by the function
  [`set.fancy.print()`](https://42463863.github.io/ProfileLadder/reference/set.fancy.print.md).
  The fancy print option can be supressed by
  `options(profileLadder.fancy = FALSE)`.

- ...:

  further arguments passed to
  [`print()`](https://rdrr.io/r/base/print.html)

## Value

displays information resulting from a call of the
[`predict()`](https://rdrr.io/r/stats/predict.html) applied to the
output of the
[`parallelReserve()`](https://42463863.github.io/ProfileLadder/reference/parallelReserve.md)
or
[`mcReserve()`](https://42463863.github.io/ProfileLadder/reference/mcReserve.md)
function—the one year ahead prediction in the run-off triagle

## See also

[`parallelReserve()`](https://42463863.github.io/ProfileLadder/reference/parallelReserve.md),
[`mcReserve()`](https://42463863.github.io/ProfileLadder/reference/mcReserve.md),
[`set.fancy.print()`](https://42463863.github.io/ProfileLadder/reference/set.fancy.print.md)

## Examples

``` r
data(CameronMutual)
predict(parallelReserve(CameronMutual))
#>       dev
#> origin    1     2     3     4     5     6     7     8     9    10    11
#>     1  5244  9228 10823 11352 11791 12082 12120 12199 12215 12215 12215
#>     2  5984  9939 11725 12346 12746 12909 13034 13109 13113 13113    NA
#>     3  7452 12421 14171 14752 15066 15354 15637 15720 15724    NA    NA
#>     4  7115 11117 12488 13274 13662 13859 13872 13947    NA    NA    NA
#>     5  5753  8969  9917 10697 11135 11282 11320    NA    NA    NA    NA
#>     6  3937  6524  7989  8543  8757  8904    NA    NA    NA    NA    NA
#>     7  5127  8212  8976  9325  9539    NA    NA    NA    NA    NA    NA
#>     8  5046  8006  8984  9333    NA    NA    NA    NA    NA    NA    NA
#>     9  5129  8202  8966    NA    NA    NA    NA    NA    NA    NA    NA
#>     10 3689  6276    NA    NA    NA    NA    NA    NA    NA    NA    NA
```
