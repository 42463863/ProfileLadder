# Access Markov Chain States in the MACRAME Algorithm

Retrieves the Markov chain components from a `profileLadder` object
returned from the function
[`mcReserve()`](https://42463863.github.io/ProfileLadder/reference/mcReserve.md)
or the `mcSetup` object returned from the function
[`incrExplor()`](https://42463863.github.io/ProfileLadder/reference/incrExplor.md).
In particular, the function returns the vector of the states used by the
underlying Markov Chain utilized for reserve prediction in the MACRAME
algorithm.

## Usage

``` r
mcStates(object)
```

## Arguments

- object:

  An object of the class `profileLadder` returned from the function
  [`mcReserve()`](https://42463863.github.io/ProfileLadder/reference/mcReserve.md)
  or an object of the class `mcSetup` returned from the function
  [`incrExplor()`](https://42463863.github.io/ProfileLadder/reference/incrExplor.md).

## Value

The vector of the Markov chain states that are used by the MACRAME
algorithm.

## See also

[`mcReserve()`](https://42463863.github.io/ProfileLadder/reference/mcReserve.md),
[`incrExplor()`](https://42463863.github.io/ProfileLadder/reference/incrExplor.md),
[`mcBreaks()`](https://42463863.github.io/ProfileLadder/reference/mcBreaks.md),
[`mcTrans()`](https://42463863.github.io/ProfileLadder/reference/mcTrans.md)

## Examples

``` r
## MACRAME reserve prediction with the DEFAULT Markov chain setup 
output <- mcReserve(CameronMutual)

## Extracting the corresponding Markov states
mcStates(output)
#>  [1]   13.0   81.0  197.0  302.5  438.0  601.0  948.0 1672.5 3073.0 3993.0

#' ## Extracting the corresponding states when explicit breaks are used
mcStates(mcReserve(CameronMutual, breaks = c(1000, 2000, 3000)))
#> [1]  291.0 1595.0 2773.5 3955.0
```
