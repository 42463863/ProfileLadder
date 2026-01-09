# Package index

## Core Functions

The key functions of the ProfileLadder package that implement three
functional-based nonparametric (point) reserve prediction algorithsms,
the overall distributional reserve prediction implemented in the
permutation bootstrap resampling, and the prediction of the next running
diagonal (so-called 1-year-ahead prediction).

- [`parallelReserve()`](https://42463863.github.io/ProfileLadder/reference/parallelReserve.md)
  : Parallel Based Development Profile Reserve
- [`mcReserve()`](https://42463863.github.io/ProfileLadder/reference/mcReserve.md)
  : MACRAME Based Development Profile Reserve
- [`permuteReserve()`](https://42463863.github.io/ProfileLadder/reference/permuteReserve.md)
  : Permutation Bootstrap Reserve (PARALLAX, REACT, MACRAME)
- [`predict(`*`<profileLadder>`*`)`](https://42463863.github.io/ProfileLadder/reference/predict.profileLadder.md)
  : One-year-ahead prediction based on PARALLAX, REACT, or MACRAME

## Utility Functions

Supporting functions that help to handle run-off triangle data and allow
some functionality between the ProfileLadder package and the ChainLadder
package.

- [`as.profileLadder()`](https://42463863.github.io/ProfileLadder/reference/as.profileLadder.md)
  :

  S3 Method Class `profileLadder`

- [`incrExplor()`](https://42463863.github.io/ProfileLadder/reference/incrExplor.md)
  : Exploration of Run-Off Triangle Increments

- [`mcBreaks()`](https://42463863.github.io/ProfileLadder/reference/mcBreaks.md)
  : Access Markov Chain Breaks for Run-Off Triangle Increments

- [`mcStates()`](https://42463863.github.io/ProfileLadder/reference/mcStates.md)
  : Access Markov Chain States in the MACRAME Algorithm

- [`mcTrans()`](https://42463863.github.io/ProfileLadder/reference/mcTrans.md)
  : Access Markov Chain Transition Matrix in the MACRAME Algorithm

- [`observed()`](https://42463863.github.io/ProfileLadder/reference/observed.md)
  : Observed Run-Off Triangle Layout vs. Predicted (Unknown) Layout

## Print & Summary Methods

- [`print(`*`<mcSetup>`*`)`](https://42463863.github.io/ProfileLadder/reference/print.mcSetup.md)
  :

  Print Objects of the S3 Class `mcSetup`

- [`print(`*`<permutedReserve>`*`)`](https://42463863.github.io/ProfileLadder/reference/print.permutedReserve.md)
  :

  Print Objects of the S3 Class `permutedReserve`

- [`print(`*`<profileLadder>`*`)`](https://42463863.github.io/ProfileLadder/reference/print.profileLadder.md)
  :

  Print Objects of the S3 Class `profileLadder`

- [`print(`*`<profilePredict>`*`)`](https://42463863.github.io/ProfileLadder/reference/print.profilePredict.md)
  :

  Print Objects of the S3 Class `profilePredict`

- [`summary(`*`<mcSetup>`*`)`](https://42463863.github.io/ProfileLadder/reference/summary.mcSetup.md)
  :

  Summary Method for the S3 Class Object `mcSetup`

- [`summary(`*`<permutedReserve>`*`)`](https://42463863.github.io/ProfileLadder/reference/summary.permutedReserve.md)
  :

  Summary Method for the S3 Objects `permutedReserve`

- [`summary(`*`<profileLadder>`*`)`](https://42463863.github.io/ProfileLadder/reference/summary.profileLadder.md)
  :

  Summary Method for Objects of the S3 Class Method `profileLadder`

## Plot Methods

- [`plot(`*`<mcSetup>`*`)`](https://42463863.github.io/ProfileLadder/reference/plot.mcSetup.md)
  : Visualization of the Run-Off Triangle Increments for the Markov
  Chain
- [`plot(`*`<permutedReserve>`*`)`](https://42463863.github.io/ProfileLadder/reference/plot.permutedReserve.md)
  : Plotting the Output of the Permutation Bootstrap
- [`plot(`*`<profileLadder>`*`)`](https://42463863.github.io/ProfileLadder/reference/plot.profileLadder.md)
  : Plotting Development Profiles
- [`plot(`*`<profilePredict>`*`)`](https://42463863.github.io/ProfileLadder/reference/plot.profilePredict.md)
  : Plotting Predicted Run-Off Diagonal

## Other

- [`set.fancy.print()`](https://42463863.github.io/ProfileLadder/reference/set.fancy.print.md)
  :

  Set Custom Color Styles for `profileLadder` Output

## Datasets

Datasets from a real actuarial practice but also from areas beyond the
insurance business.

- [`CameronMutual`](https://42463863.github.io/ProfileLadder/reference/CameronMutual.md)
  : Cameron Mutual Insurance Company Data
- [`covid19CZ`](https://42463863.github.io/ProfileLadder/reference/covid19CZ.md)
  : First Occurrences of Covid-19 Cases in the Czech Republic
- [`CZ.casco`](https://42463863.github.io/ProfileLadder/reference/CZ.casco.md)
  : Vehicles damages within a conventional full Casco insurance
- [`CZ.liability`](https://42463863.github.io/ProfileLadder/reference/CZ.liability.md)
  : Liability insurance of employees in the Czech Republic.
- [`CZ.property`](https://42463863.github.io/ProfileLadder/reference/CZ.property.md)
  : Property damages caused by fires, floods, windstorms, and explosions
- [`GFCIB`](https://42463863.github.io/ProfileLadder/reference/GFCIB.md)
  : Guarantee Fund of the Czech Insurers' Bureau Data
- [`MidwestMutual`](https://42463863.github.io/ProfileLadder/reference/MidwestMutual.md)
  : Midwest Family Mutual Insurance Company Data
- [`NevadaGeneral`](https://42463863.github.io/ProfileLadder/reference/NevadaGeneral.md)
  : Nevada General Insurance Company Data
- [`xNetSubscribe`](https://42463863.github.io/ProfileLadder/reference/xNetSubscribe.md)
  : Internet Provider Monthly Income Data
