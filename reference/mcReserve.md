# MACRAME Based Development Profile Reserve

The function takes a cumulative (or incremental) run-off triangle
(partially or completely observed) and returns the reserve prediction
obtained by the MACRAME algorithm (see Maciak, Mizera, and Pešta (2022)
for further details).

## Usage

``` r
mcReserve(
  chainLadder,
  cum = TRUE,
  residuals = FALSE,
  states = NULL,
  breaks = NULL
)
```

## Arguments

- chainLadder:

  a cumulative or incremental run-off triangle (the triangle must be of
  the class `triangle` or `matrix`) in terms of a square matrix with a
  fully observed upper-left triangular part. If the lower-right part is
  also provided the function will also return standard residuals but
  only the upper-left (run-off) triangle is be used for the reserve
  prediction purposes

- cum:

  logical to indicate the type of the input triangle that is provided
  (DEFAULT value is `TRUE` for the cumulative triangle, `FALSE` if
  `chainLadder` is of the incremental type)

- residuals:

  logical to indicate whether (incremental) residuals should be provided
  in output or not. If the run-off triangle is completely observed then
  the residuals are obtained in terms of the true increments minus the
  predicted ones. If the bottom-right triangle is not available (which
  is a typical situation in practice) then the residuals are obtained in
  terms of a back-fitting approach (see Maciak, Mizera, and Pešta (2022)
  for further details). However, the back-fitted residuals are only
  calculated when no user specification of the states (in `states`) and
  breaks (in `breaks`) is provided (as it is usually not appropriate to
  use the same states/breaks for the flipped run-off triangle)

- states:

  numeric value to provide either the number of the Markov states to be
  used or it can specify an explicit set of the states instead. The
  default setting (`states = NULL`) provides the set of states in a
  fully data-driven manner as proposed in Maciak, Mizera, and
  Pešta (2022) while any choice of `breaks` is ignored. If the number of
  states is specified by `states`, the states are obtained analogously
  as in Maciak, Mizera, and Pešta (2022), however, the number of actual
  states is adjusted and the parameter `breaks` is again ignored

  If parameter `states` provides an explicit vector of Markov chain
  states (the smallest state should be larger than the smallest observed
  increment in the run-off triangle and, similarly, the largest state
  should be smaller than the largest observed increment) then the
  corresponding bins (breaks) for the run-off triangle increments are
  defined automatically by the midpoints between the provided states
  (with `breaks` being set to `NULL` DEFAULT)

- breaks:

  vector parameter which provides explicit (unique and monotonly
  increasing) break points (disjoint bins) for the run-off triangle
  incremenets. Each bin should be represented by the corresponding
  Markov chain state—either the values given in `states` or provided
  automatically if `states` is not a valid vector of the Markov states.
  If the breaks are provided as `breaks = c(-Inf, ... , Inf)` defining
  `k` bins all together then `states` should be a vector of the same
  length `k`. Alternatively, the breaks can be also specified by a set
  of finite numbers defining again `k` bins—in such cases, the parameter
  `states` should be of the length `length(states) = k + 1`. Each value
  in `states` should represent one bin defined by `breaks`

## Value

An object of the type `list` with with the following elements:

- reserve:

  numeric vector with four values: Total paid amount (i.e., the sum of
  the last observed diagonal in a cumulative run-off triangle);
  Estimated ultimate (i.e., the sum of the last column in the completed
  cumulative run-off triangle); Estimated reserve (i.e., the sum of the
  last column in the completed cumulative triangle minus the sum of the
  last observed diagonal in `chainLadder`); True reserve if a completed
  `chainLadder` is provided for the input (i.e., the sum of the last
  column in `chainLadder` minus the sum of the last diagonal in
  `chainLadder`)

- method:

  algorithm used for the reserve estimation

- Triangle:

  the input run-off triangle provided in `chainLadder`

- FullTriangle:

  completed run-off triangle (the upper-left triangular part is
  identical with the input triangle in `chainLadder` and the lower-right
  trianglular part is completed by the MACRAME algorithm

- trueCompleted:

  true completed triangle (if available) where the upper-left part is
  used by the MACRAME algorithm to estimate the reserve and the
  lower-right part is provided for some evaluation purposes. If the full
  triangle is not available `NA` is returned instead

- residuals:

  a triangle with the corresponding residuals (for `residuals = TRUE`).
  The residuals are either provided in the upper-left triangle
  (so-called back-fitted incremental residuals if true completed
  triangle is not available) or the residuals are given in the
  lower-right triangle (i,e., standard incremental residuals—if the true
  completed triangle is given)

## References

Maciak, M., Mizera, I., and Pešta, M. (2022). Functional Profile
Techniques for Claims Reserving. ASTIN Bulletin, 52(2), 449-482.
DOI:10.1017/asb.2022.4

## See also

[`incrExplor()`](https://42463863.github.io/ProfileLadder/reference/incrExplor.md),
[`permuteReserve()`](https://42463863.github.io/ProfileLadder/reference/permuteReserve.md),
[`mcBreaks()`](https://42463863.github.io/ProfileLadder/reference/mcBreaks.md),
[`mcStates()`](https://42463863.github.io/ProfileLadder/reference/mcStates.md),
[`mcTrans()`](https://42463863.github.io/ProfileLadder/reference/mcTrans.md)

## Examples

``` r
## run-off (upper-left) triangle with NA values
data(MW2014, package = "ChainLadder")
print(MW2014) 
#>       dev
#> origin     0     1     2     3     4     5     6     7     8     9    10    11
#>     1  13109 20355 21337 22043 22401 22658 22997 23158 23492 23664 23699 23904
#>     2  14457 22038 22627 23114 23238 23312 23440 23490 23964 23976 24048 24111
#>     3  16075 22672 23753 24052 24206 24757 24786 24807 24823 24888 24986 25401
#>     4  15682 23464 24465 25052 25529 25708 25752 25770 25835 26075 26082 26146
#>     5  16551 23706 24627 25573 26046 26115 26283 26481 26701 26718 26724 26728
#>     6  15439 23796 24866 25317 26139 26154 26175 26205 26764 26818 26836 26959
#>     7  14629 21645 22826 23599 24992 25434 25476 25549 25604 25709 25723    NA
#>     8  17585 26288 27623 27939 28335 28638 28715 28759 29525 30302    NA    NA
#>     9  17419 25941 27066 27761 28043 28477 28721 28878 28948    NA    NA    NA
#>     10 16665 25370 26909 27611 27729 27861 29830 29844    NA    NA    NA    NA
#>     11 15471 23745 25117 26378 26971 27396 27480    NA    NA    NA    NA    NA
#>     12 15103 23393 26809 27691 28061 29183    NA    NA    NA    NA    NA    NA
#>     13 14540 22642 23571 24127 24210    NA    NA    NA    NA    NA    NA    NA
#>     14 14590 22336 23440 24029    NA    NA    NA    NA    NA    NA    NA    NA
#>     15 13967 21515 22603    NA    NA    NA    NA    NA    NA    NA    NA    NA
#>     16 12930 20111    NA    NA    NA    NA    NA    NA    NA    NA    NA    NA
#>     17 12539    NA    NA    NA    NA    NA    NA    NA    NA    NA    NA    NA
#>       dev
#> origin    12    13    14    15    16
#>     1  23960 23992 23994 24001 24002
#>     2  24252 24538 24540 24550    NA
#>     3  25681 25705 25732    NA    NA
#>     4  26150 26167    NA    NA    NA
#>     5  26735    NA    NA    NA    NA
#>     6     NA    NA    NA    NA    NA
#>     7     NA    NA    NA    NA    NA
#>     8     NA    NA    NA    NA    NA
#>     9     NA    NA    NA    NA    NA
#>     10    NA    NA    NA    NA    NA
#>     11    NA    NA    NA    NA    NA
#>     12    NA    NA    NA    NA    NA
#>     13    NA    NA    NA    NA    NA
#>     14    NA    NA    NA    NA    NA
#>     15    NA    NA    NA    NA    NA
#>     16    NA    NA    NA    NA    NA
#>     17    NA    NA    NA    NA    NA

## MACRAME reserve prediction with the DEFAULT Markov chain setting 
mcReserve(MW2014, residuals = TRUE)
#> MACRAME Reserving 
#>     Estimated Reserve    Estimated Ultimate           Paid Amount 
#>              27861.23             456978.23             429117.00 
#>          True Reserve 
#>                    NA 
#> 
#> MACRAME method (functional profile completion)
#> 13109   20355  21337  22043  22401  22658  22997  23158  23492  23664  23699  23904  23960  23992  23994  24001  24002  
#> 14457   22038  22627  23114  23238  23312  23440  23490  23964  23976  24048  24111  24252  24538  24540  24550  24597  
#> 16075   22672  23753  24052  24206  24757  24786  24807  24823  24888  24986  25401  25681  25705  25732  25774  25899  
#> 15682   23464  24465  25052  25529  25708  25752  25770  25835  26075  26082  26146  26150  26167  26209  26334  26472  
#> 16551   23706  24627  25573  26046  26115  26283  26481  26701  26718  26724  26728  26735  26782  26856  26993  27140  
#> 15439   23796  24866  25317  26139  26154  26175  26205  26764  26818  26836  26959  27310  27573  27804  28007  28194  
#> 14629   21645  22826  23599  24992  25434  25476  25549  25604  25709  25723  25770  25844  25981  26128  26288  26452  
#> 17585   26288  27623  27939  28335  28638  28715  28759  29525  30302  30935  31310  31570  31788  31981  32165  32341  
#> 17419   25941  27066  27761  28043  28477  28721  28878  28948  29050  29209  29382  29548  29720  29890  30061  30231  
#> 16665   25370  26909  27611  27729  27861  29830  29844  29891  29965  30102  30249  30409  30573  30741  30909  31079  
#> 15471   23745  25117  26378  26971  27396  27480  27596  27799  27972  28159  28331  28507  28678  28850  29021  29192  
#> 15103   23393  26809  27691  28061  29183  29704  29971  30220  30427  30625  30808  30986  31161  31334  31506  31677  
#> 14540   22642  23571  24127  24210  24326  24529  24702  24889  25061  25237  25408  25580  25751  25922  26093  26263  
#> 14590   22336  23440  24029  24340  24602  24817  25021  25206  25387  25562  25736  25908  26079  26250  26421  26592  
#> 13967   21515  22603  23124  23391  23640  23847  24045  24228  24406  24581  24754  24926  25097  25268  25438  25609  
#> 12930   20111  21134  21657  21953  22202  22411  22607  22789  22967  23141  23314  23486  23657  23828  23998  24169  
#> 12539   13743  14333  14663  14924  15138  15335  15518  15696  15870  16043  16215  16386  16557  16727  16898  17069  

## complete run-off triangle with 'unknown' truth (lower-bottom run-off triangle)  
## with incremental residuals (true increments minus predicted ones)  
data(CameronMutual)
mcReserve(CameronMutual, residuals = TRUE)
#> MACRAME Reserving 
#>     Estimated Reserve    Estimated Ultimate           Paid Amount 
#>              8081.963            113240.963            105159.000 
#>          True Reserve 
#>              7963.000 
#> 
#> MACRAME method (functional profile completion)
#> 5244     9228  10823  11352  11791  12082  12120  12199  12215  12215  
#> 5984     9939  11725  12346  12746  12909  13034  13109  13113  13160  
#> 7452    12421  14171  14752  15066  15354  15637  15720  15756  15799  
#> 7115    11117  12488  13274  13662  13859  13872  13919  13960  14003  
#> 5753     8969   9917  10697  11135  11282  11340  11380  11422  11464  
#> 3937     6524   7989   8543   8757   8815   8855   8897   8939   8982  
#> 5127     8212   8976   9325   9496   9588   9646   9693   9737   9780  
#> 5046     8006   8984   9677  10157  10458  10641  10759  10840  10902  
#> 5129     8202   9244   9808  10165  10376  10502  10586  10649  10701  
#> 3689     4731   5295   5652   5863   5989   6073   6136   6188   6236  

## the same output in terms of the reserve prediction but back-fitted residuals 
## are provided instead (as the run-off triangle only is provided)
data(observed(CameronMutual))
#> Warning: data set ‘observed(CameronMutual)’ not found
mcReserve(observed(CameronMutual), residuals = TRUE)
#> MACRAME Reserving 
#>     Estimated Reserve    Estimated Ultimate           Paid Amount 
#>              8081.963            113240.963            105159.000 
#>          True Reserve 
#>                    NA 
#> 
#> MACRAME method (functional profile completion)
#> 5244     9228  10823  11352  11791  12082  12120  12199  12215  12215  
#> 5984     9939  11725  12346  12746  12909  13034  13109  13113  13160  
#> 7452    12421  14171  14752  15066  15354  15637  15720  15756  15799  
#> 7115    11117  12488  13274  13662  13859  13872  13919  13960  14003  
#> 5753     8969   9917  10697  11135  11282  11340  11380  11422  11464  
#> 3937     6524   7989   8543   8757   8815   8855   8897   8939   8982  
#> 5127     8212   8976   9325   9496   9588   9646   9693   9737   9780  
#> 5046     8006   8984   9677  10157  10458  10641  10759  10840  10902  
#> 5129     8202   9244   9808  10165  10376  10502  10586  10649  10701  
#> 3689     4731   5295   5652   5863   5989   6073   6136   6188   6236  

## MACRAME reserve prediction with the underlying Markov chain with five 
## explicit Markov chain states
mcReserve(CameronMutual, residuals = TRUE, states = c(200, 600, 1000))
#> MACRAME Reserving 
#>     Estimated Reserve    Estimated Ultimate           Paid Amount 
#>              13089.81             118248.81             105159.00 
#>          True Reserve 
#>               7963.00 
#> 
#> MACRAME method (functional profile completion)
#> 5244     9228  10823  11352  11791  12082  12120  12199  12215  12215  
#> 5984     9939  11725  12346  12746  12909  13034  13109  13113  13313  
#> 7452    12421  14171  14752  15066  15354  15637  15720  15920  16120  
#> 7115    11117  12488  13274  13662  13859  13872  14072  14272  14472  
#> 5753     8969   9917  10697  11135  11282  11482  11682  11882  12082  
#> 3937     6524   7989   8543   8757   8957   9157   9357   9557   9757  
#> 5127     8212   8976   9325   9525   9725   9925  10125  10325  10525  
#> 5046     8006   8984   9784  10344  10742  11046  11300  11528  11741  
#> 5129     8202   9002   9562   9960  10264  10518  10746  10959  11166  
#> 3689     4489   5049   5447   5751   6005   6233   6446   6653   6857  
```
