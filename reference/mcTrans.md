# Access Markov Chain Transition Matrix in the MACRAME Algorithm

Retrieves the Markov chain components from a `profileLadder` object
returned from the function
[`mcReserve()`](https://42463863.github.io/ProfileLadder/reference/mcReserve.md)
– in particular, the function returns the matrix of the estimated
transition probabilities used by the underlying Markov Chain to provide
the reserve prediction.

## Usage

``` r
mcTrans(object)
```

## Arguments

- object:

  An object of class `profileLadder`.

## Value

The matrix of the estimated Markov chain transition probabilities

## See also

[`mcReserve()`](https://42463863.github.io/ProfileLadder/reference/mcReserve.md),
[`mcBreaks()`](https://42463863.github.io/ProfileLadder/reference/mcBreaks.md),
[`mcStates()`](https://42463863.github.io/ProfileLadder/reference/mcStates.md)

## Examples

``` r
## MACRAME reserve prediction with the DEFAULT Markov chain setup 
output <- mcReserve(CameronMutual)

## Extracting the corresponding break points
mcTrans(output)
#>         [,1]   [,2]   [,3]   [,4] [,5] [,6] [,7] [,8] [,9] [,10]
#>  [1,] 0.5000 0.5000 0.0000 0.0000 0.00 0.00 0.00 0.00    0     0
#>  [2,] 0.6667 0.3333 0.0000 0.0000 0.00 0.00 0.00 0.00    0     0
#>  [3,] 0.3333 0.6667 0.0000 0.0000 0.00 0.00 0.00 0.00    0     0
#>  [4,] 0.3333 0.0000 0.3333 0.3333 0.00 0.00 0.00 0.00    0     0
#>  [5,] 0.0000 0.0000 0.6000 0.2000 0.20 0.00 0.00 0.00    0     0
#>  [6,] 0.0000 0.0000 0.2500 0.5000 0.25 0.00 0.00 0.00    0     0
#>  [7,] 0.0000 0.0000 0.0000 0.0000 0.50 0.00 0.50 0.00    0     0
#>  [8,] 0.0000 0.0000 0.0000 0.0000 0.25 0.75 0.00 0.00    0     0
#>  [9,] 0.0000 0.0000 0.0000 0.0000 0.00 0.25 0.50 0.25    0     0
#> [10,] 0.0000 0.0000 0.0000 0.0000 0.00 0.00 0.25 0.75    0     0
```
