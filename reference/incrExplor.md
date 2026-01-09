# Exploration of Run-Off Triangle Increments

The function takes a cumulative or incremental run-off triangle
(partially or completely observed) and provides some basic exploratory
of the observed incremental payments. The function serves as a useful
tool for a user-based insight when manually defining the states of the
Markov Chain that is used to drive the reserve prediction in the MACRAME
algorithm implemented within the function
[`mcReserve()`](https://42463863.github.io/ProfileLadder/reference/mcReserve.md).

## Usage

``` r
incrExplor(
  triangle,
  method = c("median", "mean", "max", "min"),
  out = 1,
  states = NULL,
  breaks = NULL
)
```

## Arguments

- triangle:

  cumulative or incremental run-off triangle (an object of the class
  `triangle` or `matrix`) specified in terms of a partially observed
  (run-off triangle) or a fully observed (completed triangle) matrix.
  Only the upper-left triangular part (run-off trangle) is used to
  provide the output analysis of the incremental payments and the
  underlying Markov chain setting options

- method:

  method form `c("median", "mean", "max", "min")` used to summarize the
  run-off triangle increments within the given set of bins. Each bin
  with the increments is represented by a corresponding Markov state
  value (obtained by the `method` choice with `median` being the DEFAULT
  option)

- out:

  integer value ranging from 1 to the number of development periods
  (alternatively a vector of such integers) to indicate which columns of
  the run-off triangle should be excluded from the exploratory analysis
  of the increments. By DEFAULT, the first incremental payments—i.e.,
  the first column of the run-off triangle—are not considered
  (`out = 1`). No colums are exluded for `out = 0` and the whole run-off
  triangle is analyzed by `incrExplor()`. To specify multiple columns
  that should be excluded, one can use `out = c(1,2,3)` which will
  exlude the first three columns (the first three origins respectively)
  from the exploratory analysis

- states:

  either an integer value to indicate an explicit number of the Markov
  chain states to be used or a vector of explicit Markov chain states
  can be provided. The DEFAULT option (`states = NULL`) ensures a fully
  data-driven (automatic) set of the Markov chain states as originally
  proposed in Maciak, Mizera, and Pešta (2022)

- breaks:

  numeric vector of explicit (unique and monotonously increasing) break
  points to define the bins for the run-off triangle increments. If
  `states` is equal to some integer number (i.e., the explicit number of
  the Markov chain states is requested by `states`) then the value of
  `breaks` is ignored. If both `states` and `breaks` are specified
  (i.e., numeric vectors are provided for both) then the set of states
  in `states` must be given in a way that exactly one state value
  belongs to exactly one bin defined by the break points specified by
  `breaks`

## Value

An object of the class `mcSetup` with the following elements:

- incrTriangle:

  an object of the class `triangle` with the incremental run-off
  triangle

- triangleType:

  type of the input run-off triangle provided for the input object
  `triangle` (cumulative or incremental)

- defaultStates:

  the data-driven set of explicit states as used (by DEFAULT) by the
  [`mcReserve()`](https://42463863.github.io/ProfileLadder/reference/mcReserve.md)
  function – the MACRAME prediction algorithm

- defaultBreaks:

  the set of explicit data-driven breaks as used (by DEFAULT) by the
  [`mcReserve()`](https://42463863.github.io/ProfileLadder/reference/mcReserve.md)
  function – the MACRAME prediction algorithm

- increments:

  table with basic empirical characteristics of the increments of the
  input run-off triangle (without the first origin payments—the values
  in the first column of the run-off triangle). Two sets of increments
  are provided: the raw incremental payments in the first row of the
  table and the standardized increments (i.e., row incremental payments
  divided by the maximum payment within the row (while not considering
  the columns specified by the `out` parameter)

- userDefined:

  a list with all information regarding the user modified input (numeric
  vector `increments` with the increments being analyzed; numeric value
  in `outColumns` denoting the excluded columns in the run-off triangle;
  `method` used to summarize the increments within the bins; numeric
  vector with the resulting Markov chain states in `states` and the
  corresponding numeric vector with the break points in `breaks`
  defining the bins for the run-off triangle increments)

## References

Maciak, M., Mizera, I., and Pešta, M. (2022). Functional Profile
Techniques for Claims Reserving. ASTIN Bulletin, 52(2), 449-482.
DOI:10.1017/asb.2022.4

## See also

[`mcBreaks()`](https://42463863.github.io/ProfileLadder/reference/mcBreaks.md),
[`mcStates()`](https://42463863.github.io/ProfileLadder/reference/mcStates.md),
[`mcReserve()`](https://42463863.github.io/ProfileLadder/reference/mcReserve.md),
[`permuteReserve()`](https://42463863.github.io/ProfileLadder/reference/permuteReserve.md)

## Examples

``` r
data(CameronMutual) 

## default Markov Chain states with (roughly) equally occupied bins 
incrExplor(CameronMutual)
#> Data-driven (default) setting of the Markov Chain in MACRAME
#> MC States: 13 81 197 302.5 438 601 948 1672.5 3073 3993
#> 
#> Corresponding bins for the run-off triangle increments
#>  [1] "[-Inf, 75)"   "[75, 147)"    "[147, 288)"   "[288, 388)"   "[388, 554)"  
#>  [6] "[554, 780)"   "[780, 1465)"  "[1465, 2587)" "[2587, 3955)" "[3955, Inf)" 
#> 

## five Markov Chain states (with roughly equally occupied bins)
incrExplor(CameronMutual, states = 5)
#> Data-driven (default) setting of the Markov Chain in MACRAME
#> MC States: 13 81 197 302.5 438 601 948 1672.5 3073 3993
#> 
#> Corresponding bins for the run-off triangle increments
#>  [1] "[-Inf, 75)"   "[75, 147)"    "[147, 288)"   "[288, 388)"   "[388, 554)"  
#>  [6] "[554, 780)"   "[780, 1465)"  "[1465, 2587)" "[2587, 3955)" "[3955, Inf)" 
#> 
#> User-modified MC setting
#> MC States: 38 283 529 1371 3216
#> 
#> Corresponding bins for the run-off triangle increments
#> [1] "[-Inf, 147)" "[147, 388)"  "[388, 780)"  "[780, 2587)" "[2587, Inf)"
#> 
#> Development periods (run-off triangle columns) not considered: 1
#> Method selected to summarize the increments within each bin: DEFAULT (median)

## explicitly defined breaks for five increment bins while the Markov states
## are obtained as medians of the increments within each bin
incrExplor(CameronMutual, breaks = c(20, 500, 1000, 2000))
#> Data-driven (default) setting of the Markov Chain in MACRAME
#> MC States: 13 81 197 302.5 438 601 948 1672.5 3073 3993
#> 
#> Corresponding bins for the run-off triangle increments
#>  [1] "[-Inf, 75)"   "[75, 147)"    "[147, 288)"   "[288, 388)"   "[388, 554)"  
#>  [6] "[554, 780)"   "[780, 1465)"  "[1465, 2587)" "[2587, 3955)" "[3955, Inf)" 
#> 
#> User-modified MC setting
#> MC States: 8.5 248.5 764 1595 3216
#> 
#> Corresponding bins for the run-off triangle increments
#> [1] "[-Inf, 20)"   "[20, 500)"    "[500, 1000)"  "[1000, 2000)" "[2000, Inf)" 
#> 
#> Development periods (run-off triangle columns) not considered: 1
#> Method selected to summarize the increments within each bin: DEFAULT (median)

## explicitly defined breaks for five bins and the Markov states
## are given as the maximum increments within each bin
incrExplor(CameronMutual, breaks = c(20, 500, 1000, 2000), method = "max")
#> Data-driven (default) setting of the Markov Chain in MACRAME
#> MC States: 13 81 197 302.5 438 601 948 1672.5 3073 3993
#> 
#> Corresponding bins for the run-off triangle increments
#>  [1] "[-Inf, 75)"   "[75, 147)"    "[147, 288)"   "[288, 388)"   "[388, 554)"  
#>  [6] "[554, 780)"   "[780, 1465)"  "[1465, 2587)" "[2587, 3955)" "[3955, Inf)" 
#> 
#> User-modified MC setting
#> MC States: 16 439 978 1786 4969
#> 
#> Corresponding bins for the run-off triangle increments
#> [1] "[-Inf, 20)"   "[20, 500)"    "[500, 1000)"  "[1000, 2000)" "[2000, Inf)" 
#> 
#> Development periods (run-off triangle columns) not considered: 1
#> Method selected to summarize the increments within each bin: max

## manually defined breaks for the bins and the corresponding states 
## exactly one state must be within each break
incrExplor(CameronMutual, breaks = c(20, 500, 1000), 
                          states = c(10, 250, 800, 1500))
#> Data-driven (default) setting of the Markov Chain in MACRAME
#> MC States: 13 81 197 302.5 438 601 948 1672.5 3073 3993
#> 
#> Corresponding bins for the run-off triangle increments
#>  [1] "[-Inf, 75)"   "[75, 147)"    "[147, 288)"   "[288, 388)"   "[388, 554)"  
#>  [6] "[554, 780)"   "[780, 1465)"  "[1465, 2587)" "[2587, 3955)" "[3955, Inf)" 
#> 
#> User-modified MC setting
#> MC States: 10 250 800 1500
#> 
#> Corresponding bins for the run-off triangle increments
#> [1] "[-Inf, 20)"  "[20, 500)"   "[500, 1000)" "[1000, Inf)"
#> 
#> Development periods (run-off triangle columns) not considered: 1
#> Method selected to summarize the increments within each bin: DEFAULT (median)
```
