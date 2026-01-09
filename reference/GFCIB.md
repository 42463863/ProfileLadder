# Guarantee Fund of the Czech Insurers' Bureau Data

Illustrative datasets provided by the Guarantee Fund of the Czech
Insurers' Bureau (GFCIB) for the mandatory car insurance in the Czech
Republic. The quarterly based payments are aggregated in four run-off
triangles with the paid amounts for four separate lines of business:
bodily injury, material damage, technical provision, and annuities.

## Usage

``` r
data(GFCIB)
```

## Format

### GFCIB

Four run-off triangles (objects of the class `triangle`) with the
dimensions `60x60` with `15` origin years (provided on a quarterly basis
in individual rows) and `60` development periods/quarters (columns)

- origin:

  matrix rows with the occurrence quartal (origin)

- dev:

  matrix columns with the development period (development)

## Source

The Czech Insurers’ Bureau <https://www.ckp.cz>

## Details

The data are structured in the the list object `GCCIB` with four
elements—one for each line of business: `\$bodilyInjury`,
`\$materialDamage`, `\$provisions`, and `\$annuity`. The run-off
triangles are all aggregated over the period from the first quartal of
2008 (`Q1`) till the last quartal of 2022 (`Q4`).
