# Property damages caused by fires, floods, windstorms, and explosions

Illustrative dataset provided by the major insurance company in the
Czech Republic. The dataset contains large risks insurance portfolio in
the Czech Republic and it covers usually commercial business and allows
mainly for damages on varios property types caused by fire, flood,
windstorm, explosion, and others.

## Usage

``` r
data(CZ.property)
```

## Format

### CZ.property

Two run-off triangles (objects of the class `triangle`) with the
dimensions `17x17` with `17` origin years (from the period 2003 – 2019)
and `17` development periods (years again).

- origin:

  matrix rows with the occurrence year (origin)

- dev:

  matrix columns with the development period (development)

## Source

An anonymous major insurance company in the Czech Republic.

## Details

The data are structured in the the list object `CZ.property` with two
elements within the list—the run-off triangle `GrossPaid` containing
cumulative amounts of gross paid claims and the run-off triangle `RBNS`
with the cummulative amounts of the RNNS reserve. The amounts of given
in thousands of the Czech crows (CZK).
