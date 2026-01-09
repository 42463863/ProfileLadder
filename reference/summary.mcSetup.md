# Summary Method for the S3 Class Object `mcSetup`

The function provides an overall summary of the output from the function
[`incrExplor()`](https://42463863.github.io/ProfileLadder/reference/incrExplor.md)

## Usage

``` r
# S3 method for class 'mcSetup'
summary(object, ...)
```

## Arguments

- object:

  an object of the class `mcSetup` – the output from the
  [`incrExplor()`](https://42463863.github.io/ProfileLadder/reference/incrExplor.md)
  function

- ...:

  not used

## Value

Returns a standard summary table (with basic description
characteristics) for raw run-off triangle increments and their
standardized (by using the maximum increment) counterparts. The function
also returns the corresponding bins for the increments and their
representations in terms of the Markov chain states.

## See also

[`incrExplor()`](https://42463863.github.io/ProfileLadder/reference/incrExplor.md),
[`mcBreaks()`](https://42463863.github.io/ProfileLadder/reference/mcBreaks.md),
[`mcStates()`](https://42463863.github.io/ProfileLadder/reference/mcStates.md)

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

## default summary output
summary(incrExplor(CameronMutual))
#> Input triangle type: Cumulative
#> Summary of the increments
#>                 Min   1st Q.   Median      Mean   3rd Q.  Max   Std.Er.
#> Raw increments    0 197.0000 529.0000 1126.0000 1595.000 4969 1340.0000
#> Std. increments   0   0.0396   0.1065    0.2267    0.321    1    0.2697
#> 
#> Total number of increments: 45,  Total number of unique increments: 45
#> Number of suspicious increments (using 2σ rule): 8,  Outliers (3σ rule): 1
#> 
#> Data-driven bins for the run-off triangle increments
#>  [1] "[-Inf, 75)"   "[75, 147)"    "[147, 288)"   "[288, 388)"   "[388, 554)"  
#>  [6] "[554, 780)"   "[780, 1465)"  "[1465, 2587)" "[2587, 3955)" "[3955, Inf)" 
#> 
#> Markov Chain states (medians of the increments within each bin)
#>  [1]   13.0   81.0  197.0  302.5  438.0  601.0  948.0 1672.5 3073.0 3993.0

## summary output for user-modified settings
summary(incrExplor(CameronMutual, states = 5, method = "mean"))
#> Input triangle type: Cumulative
#> Summary of the increments (development periods: 2,3,4,5,6,7,8,9,10)
#>                Min   1st Q.   Median      Mean   3rd Q.  Max   Std.Er.
#> Raw increments   0 197.0000 529.0000 1126.0000 1595.000 4969 1340.0000
#> Std.increments   0   0.0396   0.1065    0.2267    0.321    1    0.2697
#> 
#> Total number of increments: 45,  Total number of unique increments: 45
#> Number of suspicious increments (using 2σ rule): 4,  Outliers (3σ rule): 0
#> 
#> User-defined bins for the selected run-off triangle increments
#> [1] "[-Inf, 147)" "[147, 388)"  "[388, 780)"  "[780, 2587)" "[2587, Inf)"
#> 
#> Markov Chain states (means of the increments within each bin)
#> [1]   48.11111  249.55556  523.77778 1273.22222 3536.77778
```
