# Print Objects of the S3 Class `profileLadder`

Function to organize and print the outputs provided by the function
[`parallelReserve()`](https://42463863.github.io/ProfileLadder/reference/parallelReserve.md)
and the function `mcReserve`

## Usage

``` r
# S3 method for class 'profileLadder'
print(x, fancy.print = getOption("profileLadder.fancy", TRUE), ...)
```

## Arguments

- x:

  an object of the class `profileLadder` resulting from a call of one of
  the functions
  [`parallelReserve()`](https://42463863.github.io/ProfileLadder/reference/parallelReserve.md),
  `mcReserve`, or
  [`as.profileLadder()`](https://42463863.github.io/ProfileLadder/reference/as.profileLadder.md)

- fancy.print:

  logical to indicate whether fancy run-off triangle should be printed
  or a standard output should be used instead. The default choice is
  `TRUE`. Note that that fancy print option uses by DEFAULT zero decimal
  digits. Specific colors for the fancy print option and the number of
  decimal points to be used can be set by the function
  [`set.fancy.print()`](https://42463863.github.io/ProfileLadder/reference/set.fancy.print.md).
  The fancy print option can be supressed by
  `options(profileLadder.fancy = FALSE)`.

- ...:

  further arguments passed to
  [`print()`](https://rdrr.io/r/base/print.html)

## Value

displays information resulting from a call of the
[`parallelReserve()`](https://42463863.github.io/ProfileLadder/reference/parallelReserve.md)
function or the `mcReserve` function

## See also

[`as.profileLadder()`](https://42463863.github.io/ProfileLadder/reference/as.profileLadder.md),
[`set.fancy.print()`](https://42463863.github.io/ProfileLadder/reference/set.fancy.print.md),
[`parallelReserve()`](https://42463863.github.io/ProfileLadder/reference/parallelReserve.md),
[`mcReserve()`](https://42463863.github.io/ProfileLadder/reference/mcReserve.md)

## Examples

``` r
data(CameronMutual)
## full run-off triangle printed with the fancy mode
x <- as.profileLadder(CameronMutual)
print(x) 
#> Run-off Reserving 
#>     Estimated Reserve    Estimated Ultimate           Paid Amount 
#>                    NA                    NA                105159 
#>          True Reserve 
#>                  7963 
#> 
#> Run-off triangle (complete/fully observed)
#> 5244     9228  10823  11352  11791  12082  12120  12199  12215  12215  
#> 5984     9939  11725  12346  12746  12909  13034  13109  13113  13115  
#> 7452    12421  14171  14752  15066  15354  15637  15720  15744  15786  
#> 7115    11117  12488  13274  13662  13859  13872  13935  13973  13972  
#> 5753     8969   9917  10697  11135  11282  11255  11331  11332  11354  
#> 3937     6524   7989   8543   8757   8901   9013   9012   9046   9164  
#> 5127     8212   8976   9325   9718   9795   9833   9885   9816   9815  
#> 5046     8006   8984   9633  10102  10166  10261  10252  10252  10252  
#> 5129     8202   9185   9681   9951  10033  10133  10182  10182  10183  
#> 3689     6043   6789   7089   7164   7197   7253   7267   7266   7266  

## run-off triangle with unobserved future payments 
x <- as.profileLadder(observed(CameronMutual))
print(x) 
#> Run-off Reserving 
#>     Estimated Reserve    Estimated Ultimate           Paid Amount 
#>                    NA                    NA                105159 
#>          True Reserve 
#>                    NA 
#> 
#> Run-off triangle
#> 5244     9228  10823  11352  11791  12082  12120  12199  12215  12215  
#> 5984     9939  11725  12346  12746  12909  13034  13109  13113      .  
#> 7452    12421  14171  14752  15066  15354  15637  15720      .      .  
#> 7115    11117  12488  13274  13662  13859  13872      .      .      .  
#> 5753     8969   9917  10697  11135  11282      .      .      .      .  
#> 3937     6524   7989   8543   8757      .      .      .      .      .  
#> 5127     8212   8976   9325      .      .      .      .      .      .  
#> 5046     8006   8984      .      .      .      .      .      .      .  
#> 5129     8202      .      .      .      .      .      .      .      .  
#> 3689        .      .      .      .      .      .      .      .      .  

## the same run-off triangle using a standard printing method 
options(profileLadder.fancy = FALSE)
print(x)
#> Run-off Reserving 
#>     Estimated Reserve    Estimated Ultimate           Paid Amount 
#>                    NA                    NA                105159 
#>          True Reserve 
#>                    NA 
#> 
#> Run-off triangle
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
```
