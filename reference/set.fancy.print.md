# Set Custom Color Styles for `profileLadder` Output

Function to set user-modified color layout for the run-off triangle
visualization and the overall output presentation

## Usage

``` r
set.fancy.print(
  color.known = "#333333",
  color.predicted = "#CC00CC",
  color.unknown = "#999999",
  color.info = "#CC00CC",
  display.digits = 0
)
```

## Arguments

- color.known:

  Color (e.g., a hexadecimal code) for the run-off triangle part (the
  upper-left triangle)

- color.predicted:

  Color (e.g., a hexadecimal code) for the predicted part of the run-off
  triangle (the bottom-right triangle)

- color.unknown:

  Color (e.g., a hexadecimal code) for the 'unknown' future (the
  bottom-right triangle which is typically not avalaialble for insurance
  practice but is often provided for retrospective evaluations)

- color.info:

  Color (e.g., a hexadecimal code) for the information messages in the
  outputs of the prediction functions
  [`parallelReserve()`](https://42463863.github.io/ProfileLadder/reference/parallelReserve.md),
  [`mcReserve()`](https://42463863.github.io/ProfileLadder/reference/mcReserve.md),
  and
  [`permuteReserve()`](https://42463863.github.io/ProfileLadder/reference/permuteReserve.md)

- display.digits:

  the number of digits to be used when using the fancy print option for
  run-off triangles. No decimal point are used by DEFAULT (i.e.,
  `display.digits = 0` by DEFAULT)

## Value

Sets the user-defined option for fancy print color styles

## See also

[`print.profileLadder()`](https://42463863.github.io/ProfileLadder/reference/print.profileLadder.md)

## Examples

``` r
## fancy print option for the run-off triangle 
print(as.profileLadder(observed(CameronMutual)), fancy.print = TRUE)
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

## fancy print option for the run-off triangle with two decimals
set.fancy.print(display.digits = 2)
print(as.profileLadder(observed(CameronMutual)))
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

## standard print option for the run-off triangle
print(as.profileLadder(observed(CameronMutual)), fancy.print = FALSE)
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

## PARALLAX based run-off triangle completion (fancy print)
options(profileLadder.fancy = TRUE)
parallelReserve(CameronMutual)
#> PARALLAX Reserving 
#>     Estimated Reserve    Estimated Ultimate           Paid Amount 
#>                  8540                113699                105159 
#>          True Reserve 
#>                  7963 
#> 
#> PARALLAX method (functional profile completion)
#> 5244.00      9228.00   10823.00   11352.00   11791.00   12082.00   12120.00   12199.00   12215.00   12215.00   
#> 5984.00      9939.00   11725.00   12346.00   12746.00   12909.00   13034.00   13109.00   13113.00   13113.00   
#> 7452.00     12421.00   14171.00   14752.00   15066.00   15354.00   15637.00   15720.00   15724.00   15724.00   
#> 7115.00     11117.00   12488.00   13274.00   13662.00   13859.00   13872.00   13947.00   13951.00   13951.00   
#> 5753.00      8969.00    9917.00   10697.00   11135.00   11282.00   11320.00   11399.00   11415.00   11415.00   
#> 3937.00      6524.00    7989.00    8543.00    8757.00    8904.00    8942.00    9021.00    9037.00    9037.00   
#> 5127.00      8212.00    8976.00    9325.00    9539.00    9686.00    9724.00    9803.00    9819.00    9819.00   
#> 5046.00      8006.00    8984.00    9333.00    9547.00    9694.00    9732.00    9811.00    9827.00    9827.00   
#> 5129.00      8202.00    8966.00    9315.00    9529.00    9676.00    9714.00    9793.00    9809.00    9809.00   
#> 3689.00      6276.00    7741.00    8295.00    8509.00    8656.00    8694.00    8773.00    8789.00    8789.00   

## PARALLAX based run-off triangle completion (standard print)
options(profileLadder.fancy = FALSE)
parallelReserve(CameronMutual)
#> PARALLAX Reserving 
#>     Estimated Reserve    Estimated Ultimate           Paid Amount 
#>                  8540                113699                105159 
#>          True Reserve 
#>                  7963 
#> 
#> PARALLAX method (functional profile completion)
#>       dev
#> origin    1     2     3     4     5     6     7     8     9    10
#>     1  5244  9228 10823 11352 11791 12082 12120 12199 12215 12215
#>     2  5984  9939 11725 12346 12746 12909 13034 13109 13113 13113
#>     3  7452 12421 14171 14752 15066 15354 15637 15720 15724 15724
#>     4  7115 11117 12488 13274 13662 13859 13872 13947 13951 13951
#>     5  5753  8969  9917 10697 11135 11282 11320 11399 11415 11415
#>     6  3937  6524  7989  8543  8757  8904  8942  9021  9037  9037
#>     7  5127  8212  8976  9325  9539  9686  9724  9803  9819  9819
#>     8  5046  8006  8984  9333  9547  9694  9732  9811  9827  9827
#>     9  5129  8202  8966  9315  9529  9676  9714  9793  9809  9809
#>     10 3689  6276  7741  8295  8509  8656  8694  8773  8789  8789
```
