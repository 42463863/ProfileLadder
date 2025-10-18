# ProfileLadder

[![CRAN Version](https://www.r-pkg.org/badges/version/ProfileLadder)](https://cran.r-project.org/package=ProfileLadder)

## Overview

The R package ProfileLadder provides nonparametric, functional-based methods for claims reserving based on 
aggregated chain-ladder data also known as the run-off triangles. 
The package implements three estimation/prediction algorithms (PARALLAX, REACT, and MACRAME) 
and the permutation bootstrap add-on proposed in Maciak, Mizera, and Pešta (2022). 

## Installation

The **ProfileLadder** package can be downloaded from CRAN in installed in R by using

```r
install.packages("ProfileLadder")


## Core package functions

- [`parallelReserve`](reference/parallelReserve.html)
  Implements the PARALLAX and REACT algorithms
  
- [`mcReserve`](reference/mcReserve.html)
  Implements the MACRAME algorithm
  
- [`permuteReserve`](reference/permuteReserve.html)
  Distributional reserve prediction (permutation bootstrap)