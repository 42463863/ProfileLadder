# Vehicles damages within a conventional full Casco insurance

Illustrative dataset provided by the major insurance company in the
Czech Republic. The dataset contains private and commercial business
sold to policy holders based in the Czech Republic and covers the
damages to the vehicles within a framework of the conventional full
Casco insurance.

## Usage

``` r
data(CZ.casco)
```

## Format

### CZ.casco

Two run-off triangles (objects of the class `triangle`) with the
dimensions `17x17` with `17` origin years (from the period 2003 – 2019)
and `17` development periods (years again).

- origin:

  matrix rows with the occurrence year (origin)

- dev:

  matrix columns with the development period (development)

## Source

Annonymous major insurance company in the Czech Republic

## Details

The data are structured in the the list object `CZ.casco` with two
elements—the run-off triangle `GrossPaid` containing cumulative amounts
of gross paid claims, and another cummulative run-off triangle `RBNS`
providing the amounts of the RNNS reserve. The amounts of given in
thousands of the Czech crows (CZK).
