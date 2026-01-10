# Summary Method for the S3 Objects `permutedReserve`

The function provides an overall summary of the output from the function
[`permuteReserve()`](https://42463863.github.io/ProfileLadder/reference/permuteReserve.md)
(i.e., the summary of the object of the class `permutedReserve`)

## Usage

``` r
# S3 method for class 'permutedReserve'
summary(object, triangle.summary = FALSE, ...)
```

## Arguments

- object:

  an object of the class `permutedReserve` – i.e., the output form the
  [`permuteReserve()`](https://42463863.github.io/ProfileLadder/reference/permuteReserve.md)
  functions

- triangle.summary:

  logical (`FALSE` by DEFAULT) indicating whether a brief table with the
  empirical summary of the permutted run-off triangles (the first
  column, the last running diagonal, and the ultimate amounts in
  particular) should be printed in the output or not

- ...:

  not used

## Value

Summary of the completed functional profiles (provided by one of the
functions
[`parallelReserve()`](https://42463863.github.io/ProfileLadder/reference/parallelReserve.md)
or
[`mcReserve()`](https://42463863.github.io/ProfileLadder/reference/mcReserve.md))
and the overall reserve distribution obtained in terms of the
permutation bootstrap – the function
[`permuteReserve()`](https://42463863.github.io/ProfileLadder/reference/permuteReserve.md).
The output is a list with the following items:

- origins:

  a matrix with the row-specific summary of the completed functional
  profiles (except the first fully developed profile—i.e., the first row
  in the run-off triangle). The first column of the matrix (`First`)
  gives the first origin payments; The second column (`Latest`) gives
  the last available (cumulative) payments (i.e., values from the last
  running diagonal in the run-off triangle); The third column
  (`Dev.To.Date`) gives a relative proportion of the paid amount
  (`Latest`) with respect to the estimated ultimate (`Ultimate`) given
  in the fourth column; The column denoted as `IBNR` gives the estimated
  amount still left to pay (Incurred But Not Reported); The sixth column
  provides the estimated standard errors (`S.E.`) of IBNR obtained from
  the permutation bootstrap; The last column returns the corresponding
  coefficients of variation (`CV`).

- overall:

  Table with the summary of the true/estimated reserve: `Paid amount`
  represents the sum of the last running diagonal; `Estimated reserve`
  gives the reserve estimate provided by one of the estimation algorithm
  (PARALLAX, REACT, or MACRAME); `True reserve` is given as a sum of the
  last column (if available, `NA` otherwise); Finally, some Accuracy in
  terms of `Reserve%` is given as a percentage of the estimated reserve
  with respect to the true reserve (see Maciak, Mizera, and Pešta (2022)
  and `Dev.To.Date` gives the proportion of the overall estimatd
  ultimate and the overall paid amount

- dist:

  Table with basic empirical characteristics of the overall reserve
  distribution provided by the permutation bootstrap: `Boot.Mean` stands
  for the empirical mean of the bootstrap distribution; `Std.Er.` gives
  the corresponding standard error of the bootstrap distribution;
  `BootCov%` stands for a percentage proportion between the standard
  error and the empirical mean of the bootstrap distribution; Finally,
  `BootVar.xxx` provides the estimated quantile of the bootstrap reserve
  distribution (0.995 by DEFAULT).

## See also

[`parallelReserve()`](https://42463863.github.io/ProfileLadder/reference/parallelReserve.md),
[`mcReserve()`](https://42463863.github.io/ProfileLadder/reference/mcReserve.md),
[`permuteReserve()`](https://42463863.github.io/ProfileLadder/reference/permuteReserve.md)

## Examples

``` r
data(CameronMutual)
summary(CameronMutual)
#>        1              2               3               4               5        
#>  Min.   :3689   Min.   : 6043   Min.   : 6789   Min.   : 7089   Min.   : 7164  
#>  1st Qu.:5066   1st Qu.: 8055   1st Qu.: 8978   1st Qu.: 9402   1st Qu.: 9776  
#>  Median :5186   Median : 8590   Median : 9551   Median :10189   Median :10618  
#>  Mean   :5448   Mean   : 8866   Mean   :10105   Mean   :10669   Mean   :11009  
#>  3rd Qu.:5926   3rd Qu.: 9761   3rd Qu.:11500   3rd Qu.:12098   3rd Qu.:12507  
#>  Max.   :7452   Max.   :12421   Max.   :14171   Max.   :14752   Max.   :15066  
#>        6               7               8               9        
#>  Min.   : 7197   Min.   : 7253   Min.   : 7267   Min.   : 7266  
#>  1st Qu.: 9854   1st Qu.: 9908   1st Qu.: 9959   1st Qu.: 9908  
#>  Median :10724   Median :10758   Median :10792   Median :10792  
#>  Mean   :11158   Mean   :11241   Mean   :11289   Mean   :11294  
#>  3rd Qu.:12702   3rd Qu.:12806   3rd Qu.:12882   3rd Qu.:12888  
#>  Max.   :15354   Max.   :15637   Max.   :15720   Max.   :15744  
#>        10       
#>  Min.   : 7266  
#>  1st Qu.: 9907  
#>  Median :10803  
#>  Mean   :11312  
#>  3rd Qu.:12890  
#>  Max.   :15786  

## summary for the point reserve prediction
summary(parallelReserve(CameronMutual))
#> PARALLAX reserve prediction (by origins)
#>       First Latest Dev.To.Date Ultimate IBNR
#> 2      5984  13113   1.0000000    13113    0
#> 3      7452  15720   0.9997456    15724    4
#> 4      7115  13872   0.9943373    13951   79
#> 5      5753  11282   0.9883487    11415  133
#> 6      3937   8757   0.9690163     9037  280
#> 7      5127   9325   0.9496894     9819  494
#> 8      5046   8984   0.9142159     9827  843
#> 9      5129   8202   0.8361709     9809 1607
#> 10     3689   3689   0.4197292     8789 5100
#> total 49232  92944   0.9158488   101484 8540
#> 
#> Overall reserve summary
#>     Est.Reserve    Est.Ultimate     Paid Amount    True Reserve        Reserve% 
#>         8540.00       113699.00       105159.00         7963.00            7.25 
#> 

## summary for the overall reserve distribution
summary(permuteReserve(parallelReserve(CameronMutual)))
#>   |                                           | 0 % ~calculating    |>                                          | 1 % ~01s            |>                                          | 2 % ~01s            |>>                                         | 3 % ~01s            |>>                                         | 4 % ~01s            |>>>                                        | 5 % ~01s            |>>>                                        | 6 % ~01s            |>>>>                                       | 7 % ~01s            |>>>>                                       | 8 % ~01s            |>>>>                                       | 9 % ~01s            |>>>>>                                      | 10% ~01s            |>>>>>                                      | 11% ~01s            |>>>>>>                                     | 12% ~01s            |>>>>>>                                     | 13% ~01s            |>>>>>>>                                    | 14% ~01s            |>>>>>>>                                    | 15% ~01s            |>>>>>>>                                    | 16% ~01s            |>>>>>>>>                                   | 17% ~01s            |>>>>>>>>                                   | 18% ~01s            |>>>>>>>>>                                  | 19% ~01s            |>>>>>>>>>                                  | 20% ~01s            |>>>>>>>>>>                                 | 21% ~01s            |>>>>>>>>>>                                 | 22% ~01s            |>>>>>>>>>>                                 | 23% ~01s            |>>>>>>>>>>>                                | 24% ~01s            |>>>>>>>>>>>                                | 25% ~01s            |>>>>>>>>>>>>                               | 26% ~01s            |>>>>>>>>>>>>                               | 27% ~01s            |>>>>>>>>>>>>>                              | 28% ~01s            |>>>>>>>>>>>>>                              | 29% ~01s            |>>>>>>>>>>>>>                              | 30% ~01s            |>>>>>>>>>>>>>>                             | 31% ~01s            |>>>>>>>>>>>>>>                             | 32% ~01s            |>>>>>>>>>>>>>>>                            | 33% ~01s            |>>>>>>>>>>>>>>>                            | 34% ~01s            |>>>>>>>>>>>>>>>>                           | 35% ~01s            |>>>>>>>>>>>>>>>>                           | 36% ~01s            |>>>>>>>>>>>>>>>>                           | 37% ~01s            |>>>>>>>>>>>>>>>>>                          | 38% ~01s            |>>>>>>>>>>>>>>>>>                          | 39% ~01s            |>>>>>>>>>>>>>>>>>>                         | 40% ~01s            |>>>>>>>>>>>>>>>>>>                         | 41% ~00s            |>>>>>>>>>>>>>>>>>>>                        | 42% ~00s            |>>>>>>>>>>>>>>>>>>>                        | 43% ~00s            |>>>>>>>>>>>>>>>>>>>                        | 44% ~00s            |>>>>>>>>>>>>>>>>>>>>                       | 45% ~00s            |>>>>>>>>>>>>>>>>>>>>                       | 46% ~00s            |>>>>>>>>>>>>>>>>>>>>>                      | 47% ~00s            |>>>>>>>>>>>>>>>>>>>>>                      | 48% ~00s            |>>>>>>>>>>>>>>>>>>>>>>                     | 49% ~00s            |>>>>>>>>>>>>>>>>>>>>>>                     | 50% ~00s            |>>>>>>>>>>>>>>>>>>>>>>                     | 51% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>                    | 52% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>                    | 53% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>                   | 54% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>                   | 55% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>                  | 56% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>                  | 57% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>                  | 58% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>                 | 59% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>                 | 60% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>>                | 61% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>>                | 62% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>>>               | 63% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>>>               | 64% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>>>               | 65% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>              | 66% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>              | 67% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>             | 68% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>             | 69% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>            | 70% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>            | 71% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>            | 72% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>           | 73% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>           | 74% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>          | 75% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>          | 76% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>         | 77% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>         | 78% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>         | 79% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>        | 80% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>        | 81% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>       | 82% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>       | 83% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>      | 84% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>      | 85% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>      | 86% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     | 87% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     | 88% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>    | 89% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>    | 90% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>   | 91% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>   | 92% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>   | 93% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  | 94% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  | 95% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> | 96% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> | 97% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>| 98% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>| 99% ~00s            |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>| 100% elapsed=01s  
#> PARALLAX based reserve prediction (with B = 500 bootstrap permutations)
#>       First Latest Dev.To.Date Ultimate IBNR        S.E        CV
#> 2      5984  13113   1.0000000    13113    0   0.000000       NaN
#> 3      7452  15720   0.9997456    15724    4   8.112413 2.0281032
#> 4      7115  13872   0.9943373    13951   79  25.757557 0.3260450
#> 5      5753  11282   0.9883487    11415  133  58.295361 0.4383110
#> 6      3937   8757   0.9690163     9037  280  68.777973 0.2456356
#> 7      5127   9325   0.9496894     9819  494  98.820026 0.2000405
#> 8      5046   8984   0.9142159     9827  843 223.150265 0.2647097
#> 9      5129   8202   0.8361709     9809 1607 558.250631 0.3473868
#> 10     3689   3689   0.4197292     8789 5100 647.832695 0.1270260
#> total 49232  92944   0.9158488   101484 8540 877.800532 0.1027869
#> 
#> Overall reserve distribution
#>      Boot.Mean        Std.Er.       BootCov%    BootVar.995 
#>    9057.485652     877.800532       9.691437       1.262077 
#> 
#> The PARALLAX predicted reserve represents the 30.74% quantile of the reserve distribution
#> Bootstrap simulated reserves beyond 2σ rule: 17 (out of 500)
#> 
```
