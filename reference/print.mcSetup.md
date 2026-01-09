# Print Objects of the S3 Class `mcSetup`

Function to organize and print the output provided by the function
[`incrExplor()`](https://42463863.github.io/ProfileLadder/reference/incrExplor.md)

## Usage

``` r
# S3 method for class 'mcSetup'
print(x, ...)
```

## Arguments

- x:

  an object of the class `mcSetup` resulting from a call of the
  [`incrExplor()`](https://42463863.github.io/ProfileLadder/reference/incrExplor.md)
  function

- ...:

  further arguments passed to `print`

## Value

displays information resulting from a call of the
[`incrExplor()`](https://42463863.github.io/ProfileLadder/reference/incrExplor.md)
function

## See also

[`incrExplor()`](https://42463863.github.io/ProfileLadder/reference/incrExplor.md),
[`mcReserve()`](https://42463863.github.io/ProfileLadder/reference/mcReserve.md),
[`mcBreaks()`](https://42463863.github.io/ProfileLadder/reference/mcBreaks.md),
[`mcStates()`](https://42463863.github.io/ProfileLadder/reference/mcStates.md)

## Examples

``` r
data(CameronMutual)
x <- incrExplor(CameronMutual)
print(x) 
#> Data-driven (default) setting of the Markov Chain in MACRAME
#> MC States: 13 81 197 302.5 438 601 948 1672.5 3073 3993
#> 
#> Corresponding bins for the run-off triangle increments
#>  [1] "[-Inf, 75)"   "[75, 147)"    "[147, 288)"   "[288, 388)"   "[388, 554)"  
#>  [6] "[554, 780)"   "[780, 1465)"  "[1465, 2587)" "[2587, 3955)" "[3955, Inf)" 
#> 
```
