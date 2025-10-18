pkgname <- "ProfileLadder"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
base::assign(".ExTimings", "ProfileLadder-Ex.timings", pos = 'CheckExEnv')
base::cat("name\tuser\tsystem\telapsed\n", file=base::get(".ExTimings", pos = 'CheckExEnv'))
base::assign(".format_ptime",
function(x) {
  if(!is.na(x[4L])) x[1L] <- x[1L] + x[4L]
  if(!is.na(x[5L])) x[2L] <- x[2L] + x[5L]
  options(OutDec = '.')
  format(x[1L:3L], digits = 7L)
},
pos = 'CheckExEnv')

### * </HEADER>
library('ProfileLadder')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("as.profileLadder")
### * as.profileLadder

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: as.profileLadder
### Title: S3 Method Class 'profileLadder'
### Aliases: as.profileLadder

### ** Examples

data(CameronMutual)
print(CameronMutual) 

x <- as.profileLadder(CameronMutual)

print(x)
plot(x)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("as.profileLadder", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("incrExplor")
### * incrExplor

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: incrExplor
### Title: Exploration of Run-Off Triangle Increments
### Aliases: incrExplor

### ** Examples

data(CameronMutual) 

## default Markov Chain states with (roughly) equally occupied bins 
incrExplor(CameronMutual)

## five Markov Chain states (with roughly equally occupied bins)
incrExplor(CameronMutual, states = 5)

## explicitly defined breaks for five increment bins while the Markov states
## are obtained as medians of the increments within each bin
incrExplor(CameronMutual, breaks = c(20, 500, 1000, 2000))

## explicitly defined breaks for five bins and the Markov states
## are given as the maximum increments within each bin
incrExplor(CameronMutual, breaks = c(20, 500, 1000, 2000), method = "max")

## manually defined breaks for the bins and the corresponding states 
## exactly one state must be within each break
incrExplor(CameronMutual, breaks = c(20, 500, 1000), 
                          states = c(10, 250, 800, 1500))




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("incrExplor", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("mcBreaks")
### * mcBreaks

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: mcBreaks
### Title: Access Markov Chain Breaks for Run-Off Triangle Increments
### Aliases: mcBreaks

### ** Examples

## DEFAULT performance of the incrExplor() function and the MACRAME algorithm
output1 <- incrExplor(CameronMutual)
output2 <- mcReserve(CameronMutual)

## Extracting the DEFAULT break points from both outputs
mcBreaks(output1)
mcBreaks(output2)

## Extracting the corresponding break points for 4 Markov states
mcBreaks(incrExplor(CameronMutual, states = 4))




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("mcBreaks", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("mcReserve")
### * mcReserve

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: mcReserve
### Title: MACRAME Based Development Profile Reserve
### Aliases: mcReserve

### ** Examples

## run-off (upper-left) triangle with NA values
data(MW2014, package = "ChainLadder")
print(MW2014) 

## MACRAME reserve prediction with the DEFAULT Markov chain setting 
mcReserve(MW2014, residuals = TRUE)

## complete run-off triangle with 'unknown' truth (lower-bottom run-off triangle)  
## with incremental residuals (true increments minus predicted ones)  
data(CameronMutual)
mcReserve(CameronMutual, residuals = TRUE)

## the same output in terms of the reserve prediction but back-fitted residuals 
## are provided instead (as the run-off triangle only is provided)
data(observed(CameronMutual))
mcReserve(observed(CameronMutual), residuals = TRUE)

## MACRAME reserve prediction with the underlying Markov chain with five 
## explicit Markov chain states
mcReserve(CameronMutual, residuals = TRUE, states = c(200, 600, 1000))




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("mcReserve", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("mcStates")
### * mcStates

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: mcStates
### Title: Access Markov Chain States in the MACRAME Algorithm
### Aliases: mcStates

### ** Examples

## MACRAME reserve prediction with the DEFAULT Markov chain setup 
output <- mcReserve(CameronMutual)

## Extracting the corresponding Markov states
mcStates(output)

#' ## Extracting the corresponding states when explicit breaks are used
mcStates(mcReserve(CameronMutual, breaks = c(1000, 2000, 3000)))




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("mcStates", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("mcTrans")
### * mcTrans

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: mcTrans
### Title: Access Markov Chain Transition Matrix in the MACRAME Algorithm
### Aliases: mcTrans

### ** Examples

## MACRAME reserve prediction with the DEFAULT Markov chain setup 
output <- mcReserve(CameronMutual)

## Extracting the corresponding break points
mcTrans(output)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("mcTrans", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("observed")
### * observed

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: observed
### Title: Observed Run-Off Triangle Layout vs. Predicted (Unknown) Layout
### Aliases: observed

### ** Examples

## observed/unobserved layout for the run-off triangle with 5 origins
print(observed(5))
print(!observed(5))

## fully observed run-off triangle with typically unknown (future) payments
## included in the lower-right triangular part for evaluation purposes
data(CameronMutual) ## the full data matrix
observed(CameronMutual) ## cummulative run-off triangle
observed(CameronMutual, cum = FALSE) ## incremental run-off triangle




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("observed", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("parallelReserve")
### * parallelReserve

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: parallelReserve
### Title: Parallel Based Development Profile Reserve
### Aliases: parallelReserve

### ** Examples

## run-off (upper-left) triangle with NA values (bottom-right part)
data(MW2014, package = "ChainLadder")
print(MW2014) 
parallelReserve(MW2014, residuals = TRUE)

## completed run-off triangle with 'unknown' truth (lower-bottom part)  
## for the estimation purposes only the upper-left triangle is used 
data(CameronMutual)
parallelReserve(CameronMutual, residuals = TRUE)

## the previous output is identical (in term of the reserve prediction) 
## but back-fitted residuals are provided in the output instead 
print(observed(CameronMutual))
parallelReserve(observed(CameronMutual), residuals = TRUE)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("parallelReserve", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("permuteReserve")
### * permuteReserve

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: permuteReserve
### Title: Permutation Bootstrap Reserve (PARALLAX, REACT, MACRAME)
### Aliases: permuteReserve

### ** Examples

## REACT algorithm and the permutation bootstrap reserve 
data(CameronMutual)
output <- parallelReserve(CameronMutual, method = "react")
summary(permuteReserve(output, B = 100))

## MACRAME algorithm with a pre-specified number of states using the same MC 
## states and the same break for each permuted run-off triangle
output <- mcReserve(CameronMutual, states = 5)
plot(permuteReserve(output, B = 100, adjustMC = FALSE))

## Permutation bootstrap applied to a completed run-off triangle 
## obtained by a parametric Over-dispersed Poisson model (from ChainLadder pkg)
library("ChainLadder")
output <- permuteReserve(glmReserve(MW2008), B = 100)
summary(output, triangle.summary = TRUE)






base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("permuteReserve", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plot.mcSetup")
### * plot.mcSetup

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plot.mcSetup
### Title: Visualization of the Run-Off Triangle Increments for the Markov
###   Chain
### Aliases: plot.mcSetup

### ** Examples

## run-off triangle increments within the default bins
x <- incrExplor(CameronMutual)
plot(x)

## run-off triangle increments and user-defined number of bins
x <- incrExplor(CameronMutual, states = 5)
plot(x)

## run-off triangle increments within the user-specified bins
x <- incrExplor(CameronMutual, breaks = c(500, 1000, 1500))
plot(x)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plot.mcSetup", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plot.permutedReserve")
### * plot.permutedReserve

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plot.permutedReserve
### Title: Plotting the Output of the Permutation Bootstrap
### Aliases: plot.permutedReserve

### ** Examples

## reserve estimated by MACRAME and the corresponding visualization
x <- mcReserve(CameronMutual)
plot(permuteReserve(x, B = 100))




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plot.permutedReserve", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plot.profileLadder")
### * plot.profileLadder

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plot.profileLadder
### Title: Plotting Development Profiles
### Aliases: plot.profileLadder

### ** Examples

## completed run-off triangle with the 'unknown' (future) payments
print(triangle <- GFCIB$bodilyInjury[1:15, 1:15])
plot(mcReserve(triangle))

## completed run-off triangle with unknown future
print(observed(triangle))
plot(mcReserve(observed(triangle)))

## the run-off triangle with future payments without MACRAME completion
plot(as.profileLadder(triangle))






base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plot.profileLadder", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("print.mcSetup")
### * print.mcSetup

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: print.mcSetup
### Title: Print Objects of the S3 Class 'mcSetup'
### Aliases: print.mcSetup

### ** Examples

data(CameronMutual)
x <- incrExplor(CameronMutual)
print(x) 




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("print.mcSetup", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("print.permutedReserve")
### * print.permutedReserve

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: print.permutedReserve
### Title: Print Objects of the S3 Class 'permutedReserve'
### Aliases: print.permutedReserve

### ** Examples

## reserve point prediction by the PARALLAX method
output <- parallelReserve(CameronMutual)

## reserve distribution prediction by the permutation bootstrap
x <- permuteReserve(output, B = 100)

## summary of the results
print(x) 




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("print.permutedReserve", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("print.profileLadder")
### * print.profileLadder

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: print.profileLadder
### Title: Print Objects of the S3 Class 'profileLadder'
### Aliases: print.profileLadder

### ** Examples

data(CameronMutual)
## full run-off triangle printed with the fancy mode
x <- as.profileLadder(CameronMutual)
print(x) 

## run-off triangle with unobserved future payments 
x <- as.profileLadder(observed(CameronMutual))
print(x) 

## the same run-off triangle using a standard printing method 
options(profileLadder.fancy = FALSE)
print(x)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("print.profileLadder", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("set.fancy.print")
### * set.fancy.print

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: set.fancy.print
### Title: Set Custom Color Styles for 'profileLadder' Output
### Aliases: set.fancy.print

### ** Examples

## fancy print option for the run-off triangle 
print(as.profileLadder(observed(CameronMutual)), fancy.print = TRUE)

## standard print option for the run-off triangle
print(as.profileLadder(observed(CameronMutual)), fancy.print = FALSE)

## PARALLAX based run-off triangle completion (fancy print)
options(profileLadder.fancy = TRUE)
parallelReserve(CameronMutual)

## PARALLAX based run-off triangle completion (standard print)
options(profileLadder.fancy = FALSE)
parallelReserve(CameronMutual)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("set.fancy.print", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("summary.mcSetup")
### * summary.mcSetup

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: summary.mcSetup
### Title: Summary Method for the S3 Class Object 'mcSetup'
### Aliases: summary.mcSetup

### ** Examples

data(CameronMutual)
summary(CameronMutual)

## default summary output
summary(incrExplor(CameronMutual))

## summary output for user-modified settings
summary(incrExplor(CameronMutual, states = 5, method = "mean"))




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("summary.mcSetup", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("summary.permutedReserve")
### * summary.permutedReserve

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: summary.permutedReserve
### Title: Summary Method for the S3 Objects 'permutedReserve'
### Aliases: summary.permutedReserve

### ** Examples

data(CameronMutual)
summary(CameronMutual)

## summary for the point reserve prediction
summary(parallelReserve(CameronMutual))

## summary for the overall reserve distribution
summary(permuteReserve(parallelReserve(CameronMutual)))




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("summary.permutedReserve", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("summary.profileLadder")
### * summary.profileLadder

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: summary.profileLadder
### Title: Summary Method for Objects of the S3 Class Method
###   'profileLadder'
### Aliases: summary.profileLadder

### ** Examples

data(CameronMutual)
summary(CameronMutual)

## standard summary output
summary(mcReserve(CameronMutual))

## summary output with plotOption = TRUE
summary(mcReserve(CameronMutual), plotOption = TRUE)

## summary output with (standard) residuals and plotOption = TRUE
summary(mcReserve(CameronMutual, residuals = TRUE), plotOption = TRUE)

## summary output with (back-fitted) residuals and plotOption = TRUE
summary(mcReserve(observed(CameronMutual), residuals = TRUE), plotOption = TRUE)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("summary.profileLadder", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
