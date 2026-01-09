# Access Markov Chain Breaks for Run-Off Triangle Increments

Retrieves the Markov chain components from the output of the
[`incrExplor()`](https://42463863.github.io/ProfileLadder/reference/incrExplor.md)
function or the
[`mcReserve()`](https://42463863.github.io/ProfileLadder/reference/mcReserve.md)
function. In particular, the function returns the set of breaks used to
define the bins for the incremental run-off triangle increments.

## Usage

``` r
mcBreaks(object)
```

## Arguments

- object:

  An object of the class `profileLadder` returned from the function
  [`mcReserve()`](https://42463863.github.io/ProfileLadder/reference/mcReserve.md)
  or an object of the class `mcSetup` returned from the function
  [`incrExplor()`](https://42463863.github.io/ProfileLadder/reference/incrExplor.md).

## Value

The vector of the break points that define the set of bins for the
run-off triangle increments.

## See also

[`mcReserve()`](https://42463863.github.io/ProfileLadder/reference/mcReserve.md),
[`incrExplor()`](https://42463863.github.io/ProfileLadder/reference/incrExplor.md),
[`mcStates()`](https://42463863.github.io/ProfileLadder/reference/mcStates.md),
[`mcTrans()`](https://42463863.github.io/ProfileLadder/reference/mcTrans.md)

## Examples

``` r
## DEFAULT performance of the incrExplor() function and the MACRAME algorithm
output1 <- incrExplor(CameronMutual)
output2 <- mcReserve(CameronMutual)

## Extracting the DEFAULT break points from both outputs
mcBreaks(output1)
#>  [1] -Inf   75  147  288  388  554  780 1465 2587 3955  Inf
mcBreaks(output2)
#>  [1] -Inf   75  147  288  388  554  780 1465 2587 3955  Inf

## Extracting the corresponding break points for 4 Markov states
mcBreaks(incrExplor(CameronMutual, states = 4))
#> [1] -Inf  214  554 1750  Inf
```
