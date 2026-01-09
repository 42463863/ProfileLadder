# Midwest Family Mutual Insurance Company Data

An illustrative dataset—a matrix (of the dimensions 10`x`10) with ten
completed years of claims payment developments of the Midwest Family
Mutual Insurance company from the period 1988 – 1997. The data matrix
contains ten origin/occurrence years (with the first row representing
the incident year 1988) and ten consecutive development periods/years
(in columns).

## Usage

``` r
data(MidwestMutual)
```

## Format

### MidwestMutual

A simple `10x10` matrix of a class `triangle` with ten origin years
(rows) each being fully developed within ten consecutive development
periods/years (columns)

- origin:

  matrix rows with the occurrence year (origin)

- dev:

  matrix columns with the development period (development)

## Source

<https://www.casact.org/publications-research/research/research-resources>  
(Other Liability Data Set, NAIC group code: 23574)

## Details

The run-off triangle (the upper-left triangular part of the data matrix)
contains only positive increments making the triangle suitable for the
standard modelling approach—the over-dispersed Poisson model (GLM
approach).

In practice, the run-off triangle only (the upper triangular part) of
the data matrix is known while the bottom-right triangular part is
treated as a future outcome (an "unknown" truth) that should be
estimated/predicted. The Midwest Family Mutual Insurance data matrix is
fully observed to allow for some retrospective goodness-of-fit
evaluations.

## References

Meyers, G. G. and P. Shi (2011). Loss reserving data pulled from NAIC
Schedule P. Available from
<https://www.casact.org/publications-research/research/research-resources>

Maciak, M., Mizera, I., and Pešta, M. (2022). Functional Profile
Techniques for Claims Reserving. ASTIN Bulletin, 52(2), 449-482.
DOI:10.1017/asb.2022.4 (Portfolio \#2)
