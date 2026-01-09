# Internet Provider Monthly Income Data

An illustrative dataset—a matrix (of the dimensions 12`x`12) with a
monthly-based income (in EUR) of a local internet data provider with the
income structured by the customers subscribing within the given month
(in 2023) reported in the rows and monthly-based payments reported in
columns. The data matrix represents the incremental type of the run-off
triangle.

## Usage

``` r
data(xNetSubscribe)
```

## Format

### xNetSubscribe

A simple `12x12` (trangular) matrix of the class `triangle` with twelve
consecutive months (January 2023 – December 2023) when new customers
subscribed to the stream service (rows) and monthly-based payments
(columns)
