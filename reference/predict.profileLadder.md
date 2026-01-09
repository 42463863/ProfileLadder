# One-year-ahead prediction based on PARALLAX, REACT, or MACRAME

The function provides a one-year-ahead prediction for a given run-off
triangle (i.e., estimating a new running diagonal based on some
nonparametric, functional-based prediction algorithm, PARALLAX, REACT,
or MACRAME).

## Usage

``` r
# S3 method for class 'profileLadder'
predict(object, ...)
```

## Arguments

- object:

  an object of the class `profileLadder` which is the output from the
  [`parallelReserve()`](https://42463863.github.io/ProfileLadder/reference/parallelReserve.md)
  function or the `mcReserve` function

- ...:

  further arguments passed to
  [`predict()`](https://rdrr.io/r/stats/predict.html)

## Value

An object of the class `profilePredict` which is a list with the
following elements:

- reserve:

  The overall predicted amount of the next year payments—the new running
  diagonal in an extended (cumulative) run-off triangle minus the last
  observed diagonal (in the cumulative triangle again)

- methods:

  Provides the information about the underlying nonparametric
  (functional-based) method that is used for the 1-year-ahead prediction
  (PRALLAX, REACT, or MACRAME)

- newDiagonal:

  Numeric vector representing the prediction of the new running diagonal
  (ordered in a way that first value corresponds to the payment for the
  last occurrence period (typically the largest amount) and the last
  value corresponds with the next-year payment for the first occurrence
  periods—typically the smallest amount)

- extTriangle:

  The extended run-off triangle—the R object of the class `triangle`
  that also contains the new predicted diagonal—the 1-year-ahead
  prediction

## See also

[`parallelReserve()`](https://42463863.github.io/ProfileLadder/reference/parallelReserve.md),
[`mcReserve()`](https://42463863.github.io/ProfileLadder/reference/mcReserve.md)

## Examples

``` r
## full run-off triangle complettion
parallelReserve(CameronMutual)
#> PARALLAX Reserving 
#>     Estimated Reserve    Estimated Ultimate           Paid Amount 
#>                  8540                113699                105159 
#>          True Reserve 
#>                  7963 
#> 
#> PARALLAX method (functional profile completion)
#> 5244     9228  10823  11352  11791  12082  12120  12199  12215  12215  
#> 5984     9939  11725  12346  12746  12909  13034  13109  13113  13113  
#> 7452    12421  14171  14752  15066  15354  15637  15720  15724  15724  
#> 7115    11117  12488  13274  13662  13859  13872  13947  13951  13951  
#> 5753     8969   9917  10697  11135  11282  11320  11399  11415  11415  
#> 3937     6524   7989   8543   8757   8904   8942   9021   9037   9037  
#> 5127     8212   8976   9325   9539   9686   9724   9803   9819   9819  
#> 5046     8006   8984   9333   9547   9694   9732   9811   9827   9827  
#> 5129     8202   8966   9315   9529   9676   9714   9793   9809   9809  
#> 3689     6276   7741   8295   8509   8656   8694   8773   8789   8789  

## one-year-ahead prediction based on PARALLAX
predict(parallelReserve(CameronMutual))
#> 5244     9228  10823  11352  11791  12082  12120  12199  12215  12215  12215  
#> 5984     9939  11725  12346  12746  12909  13034  13109  13113  13113      .  
#> 7452    12421  14171  14752  15066  15354  15637  15720  15724      .      .  
#> 7115    11117  12488  13274  13662  13859  13872  13947      .      .      .  
#> 5753     8969   9917  10697  11135  11282  11320      .      .      .      .  
#> 3937     6524   7989   8543   8757   8904      .      .      .      .      .  
#> 5127     8212   8976   9325   9539      .      .      .      .      .      .  
#> 5046     8006   8984   9333      .      .      .      .      .      .      .  
#> 5129     8202   8966      .      .      .      .      .      .      .      .  
#> 3689     6276      .      .      .      .      .      .      .      .      .  
```
