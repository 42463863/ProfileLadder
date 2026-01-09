# Parallel Based Development Profile Reserve

The function takes a cumulative (or incremental) run-off triangle
(partially or completely observed) and returns the reserve prediction
obtained by the PARALLAX or REACT algorithm (see Maciak, Mizera, and
Pešta (2022) for more details). If a full data matrix is provided as the
input then the algorithms uses only on the relevant part of the data—the
run-off triangle only (i.e., the top-left triangular part of the matrix)
but standard incremental residuals (true incremental payments minus
predicted increments) are returned for retrospective validation purposes
(if `residuals = TRUE`). If the run-off triangle is provided only,then
the algorithm caclulates so-called back-fitted (incremental) residuals
instead (see Maciak, Mizera, and Pešta (2022) for details).

## Usage

``` r
parallelReserve(
  chainLadder,
  method = "parallax",
  cum = TRUE,
  residuals = FALSE
)
```

## Arguments

- chainLadder:

  cumulative or incremental run-off triangle (the triangle must be of
  the class `triangle` or `matrix`) in terms of a square matrix (i.e., a
  fully observed run-off triangle) or a standard run-off triangle
  instead (i.e, the top-left triangular part of the matrix

- method:

  prediction method to be used: PARALLAX (DEFAULT `method = "parallax"`)
  or REACT (`method = "react"`)

- cum:

  logical (`TRUE` for a cumulative triangle and `FALSE` for an
  incremental triangle)

- residuals:

  logical to indicate whether incremental residuals should be provided
  or not. If the run-off triangle is complete then the residuals are
  obtained in terms of true increments minus the predicted increments.
  If the bottom-right part of the triangle is not available the
  residuals are provided in terms of the backfitting approach (see
  Maciak, Mizera, and Pesta (2022) for further details)

## Value

An object of the class `profileLadder` which is a list with the
following elements:

- reserve:

  numeric vector with four values summarizing the reserve: Total paid
  amount (i.e., the sum of the last observed diagonal in a cumulative
  run-off triangle); Total estimated amount (i.e., the sum of the last
  column in the completed cumulative triangle); Estimated reserve (i.e.,
  the sum of the last column in the completed cumulative triangle minus
  the sum of the last observed diagonal in `chainLadder`); True
  reserve—if the completed (true) `chainLadder` is provided in the input
  (i.e., the sum of the last column in `chainLadder` minus the sum of
  the last diagonal in `chainLadder`)

- method:

  algorithm used for the reserve estimation (PARALLAX or REACT)

- Triangle:

  the run-off triangle considered as the input for the underlying
  estimation algorithm (PARALLAX or REACT)

- FullTriangle:

  completed functional development profiles (the lower-right triangular
  part in `completed`) estimated by the PARALLAX algorithm or the REACT
  algorithm

- trueCompleted:

  true (complete) run-off triangle (if available) and `NA` value
  provided otherwise

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

[`mcReserve()`](https://42463863.github.io/ProfileLadder/reference/mcReserve.md),
[`permuteReserve()`](https://42463863.github.io/ProfileLadder/reference/permuteReserve.md),
[`summary.profileLadder()`](https://42463863.github.io/ProfileLadder/reference/summary.profileLadder.md)

## Examples

``` r
## run-off (upper-left) triangle with NA values (bottom-right part)
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
parallelReserve(MW2014, residuals = TRUE)
#> PARALLAX Reserving 
#>     Estimated Reserve    Estimated Ultimate           Paid Amount 
#>                 25385                454502                429117 
#>          True Reserve 
#>                    NA 
#> 
#> PARALLAX method (functional profile completion)
#> 13109   20355  21337  22043  22401  22658  22997  23158  23492  23664  23699  23904  23960  23992  23994  24001  24002  
#> 14457   22038  22627  23114  23238  23312  23440  23490  23964  23976  24048  24111  24252  24538  24540  24550  24551  
#> 16075   22672  23753  24052  24206  24757  24786  24807  24823  24888  24986  25401  25681  25705  25732  25742  25743  
#> 15682   23464  24465  25052  25529  25708  25752  25770  25835  26075  26082  26146  26150  26167  26194  26204  26205  
#> 16551   23706  24627  25573  26046  26115  26283  26481  26701  26718  26724  26728  26735  26752  26779  26789  26790  
#> 15439   23796  24866  25317  26139  26154  26175  26205  26764  26818  26836  26959  26966  26983  27010  27020  27021  
#> 14629   21645  22826  23599  24992  25434  25476  25549  25604  25709  25723  25787  25791  25815  25842  25852  25853  
#> 17585   26288  27623  27939  28335  28638  28715  28759  29525  30302  30320  30443  30450  30467  30494  30504  30505  
#> 17419   25941  27066  27761  28043  28477  28721  28878  28948  29725  29743  29866  29873  29890  29917  29927  29928  
#> 16665   25370  26909  27611  27729  27861  29830  29844  29914  30691  30709  30832  30839  30856  30883  30893  30894  
#> 15471   23745  25117  26378  26971  27396  27480  27678  28444  29221  29239  29362  29369  29386  29413  29423  29424  
#> 15103   23393  26809  27691  28061  29183  29260  29417  29487  30264  30282  30405  30412  30429  30456  30466  30467  
#> 14540   22642  23571  24127  24210  24761  24790  24811  24827  24892  24990  25405  25685  25709  25736  25746  25747  
#> 14590   22336  23440  24029  24183  24734  24763  24784  24800  24865  24963  25378  25658  25682  25709  25719  25720  
#> 13967   21515  22603  23090  23214  23288  23416  23466  23940  23952  24024  24087  24228  24514  24516  24526  24527  
#> 12930   20111  21093  21799  22157  22414  22753  22914  23248  23420  23455  23660  23716  23748  23750  23757  23758  
#> 12539   19720  20702  21408  21766  22023  22362  22523  22857  23029  23064  23269  23325  23357  23359  23366  23367  

## completed run-off triangle with 'unknown' truth (lower-bottom part)  
## for the estimation purposes only the upper-left triangle is used 
data(CameronMutual)
parallelReserve(CameronMutual, residuals = TRUE)
#> PARALLAX Reserving 
#>     Estimated Reserve    Estimated Ultimate           Paid Amount 
#>                  8540                113699                105159 
#>          True Reserve 
#>                  7963 
#> 
#> PARALLAX method (functional profile completion)
#> 5244     9228  10823  11352  11791  12082  12120  12199  12215  12215  
#> 5984     9939  11725  12346  12746  12909  13034  13109  13113  13113  
#> 7452    12421  14171  14752  15066  15354  15637  15720  15724  15724  
#> 7115    11117  12488  13274  13662  13859  13872  13947  13951  13951  
#> 5753     8969   9917  10697  11135  11282  11320  11399  11415  11415  
#> 3937     6524   7989   8543   8757   8904   8942   9021   9037   9037  
#> 5127     8212   8976   9325   9539   9686   9724   9803   9819   9819  
#> 5046     8006   8984   9333   9547   9694   9732   9811   9827   9827  
#> 5129     8202   8966   9315   9529   9676   9714   9793   9809   9809  
#> 3689     6276   7741   8295   8509   8656   8694   8773   8789   8789  

## the previous output is identical (in term of the reserve prediction) 
## but back-fitted residuals are provided in the output instead 
print(observed(CameronMutual))
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
parallelReserve(observed(CameronMutual), residuals = TRUE)
#> PARALLAX Reserving 
#>     Estimated Reserve    Estimated Ultimate           Paid Amount 
#>                  8540                113699                105159 
#>          True Reserve 
#>                    NA 
#> 
#> PARALLAX method (functional profile completion)
#> 5244     9228  10823  11352  11791  12082  12120  12199  12215  12215  
#> 5984     9939  11725  12346  12746  12909  13034  13109  13113  13113  
#> 7452    12421  14171  14752  15066  15354  15637  15720  15724  15724  
#> 7115    11117  12488  13274  13662  13859  13872  13947  13951  13951  
#> 5753     8969   9917  10697  11135  11282  11320  11399  11415  11415  
#> 3937     6524   7989   8543   8757   8904   8942   9021   9037   9037  
#> 5127     8212   8976   9325   9539   9686   9724   9803   9819   9819  
#> 5046     8006   8984   9333   9547   9694   9732   9811   9827   9827  
#> 5129     8202   8966   9315   9529   9676   9714   9793   9809   9809  
#> 3689     6276   7741   8295   8509   8656   8694   8773   8789   8789  

```
