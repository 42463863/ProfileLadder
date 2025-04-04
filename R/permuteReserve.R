#' Permutation bootstrap reserve (PARALLAX, REACT, MACRAME)
#'
#' The function takes the output from the function \code{parallelReserve()} or \code{mcReserve} and provides the overall 
#' reserve distribution in terms of the permutation bootstrap proposed in Maciak, Mizera, and Pešta (2022).
#'
#' @param object an object of the class \code{profileLadder} (i.e., the output from the function \code{parallelReserve()} or \code{mcReserve()})
#' @param B of permutations to be performed (\code{DEFAULT = 500})
#' @param std logical to indicate whether the run-off triangle should be standardized by the first column increments (DEFAULT) or not (\code{std = FALSE}) 
#' @param quantile ...(DEFAULT \code{quantile = 0.995}) 
#' 
#' @returns A list with with the following elements: 
#' \item{method}{summary of the permutation bootstrap}
#' \item{estimatedReserve}{numeric vector with four values: Total paid amount (i.e., the sum of the last observed diagonal in a cumulative run-off triangle); Total estimated amount (i.e., the sum of the last column 
#' in the completed cumulative triangle); Estimated reserve (i.e., the sum of the last column in the completed cumulative triangle minus the sum of the last observed diagonal); True reserve 
#' if a completed (true) run-off triangle is available}
#' \item{pSummary}{numeric vector with our values: Average of \code{B} permutation bootstrap reserves; Standard error of \code{B} permutation bootstrap reserves; 
#' numeric value \code{BootCov\%} given as a percentage proportion between the standard error and the average; \code{BootVar.995} providing the 0.995 quantile of the permutation bootstrap reserves
#' relative to the permutation bootstrap mean reserve}
#' \item{pReserves}{a numeric vector of the length \code{B} with estimated (permuted) reserves for each row-permuted run-off triangle}
#' \item{time}{a numeric vector with the number of permutation resamples (\code{B}), the run-off triangle dimension (\code{n}) and 
#' the computation time consumed for the permutation bootstrap calculations}
#' 
#' @seealso [parallelReserve()], [mcReserve()]
#' 
#' @examples
#' ## REACT algorithm and the permutation bootstrap reserve 
#' data(CameronMutual)
#' 
#' output <- parallelReserve(CameronMutual, method = "react")
#' permuteReserve(output)
#' 
#' ## MACRAME algorithm with a pre-specified number of states and the permutation bootstrap reserve
#' output <- mcReserve(CameronMutual, states = 5)
#' permuteReserve(output)
#' 
#' 
#' @references Maciak, M., Mizera, I., and Pešta, M. (2022). Functional Profile Techniques for Claims Reserving. ASTIN Bulletin, 52(2), 449-482. DOI:10.1017/asb.2022.4
#' 
#' @export
permuteReserve <- function(object, B = 500, std = TRUE, quantile = 0.995){
  ### input data checks
  if (all(class(object) != "profileLadder")){stop("The input object must be of a class 'profileLadder'")}
  if (any(class(object) == "profileLadder") & all(is.na(object$completedProfiles))){stop("The input object must be a result of 'parallelReserve()' or 'mcReserve()'")}
  if (!is.numeric(B) | length(B) > 1){stop("The number of bootstrap permutations 'B' must be a numeric (integer) value")}
  if (round(B, 0) != B | B <= 0){stop("The number of boostrap permutations 'B' must be a positive integer value")} 
  if (B < 30){warning("The number of bootstrap permutations 'B' is too low")} 
  if (!is.numeric(quantile) | length(quantile) > 1){stop("The quantile value must be a single value in interval (0,1)")}
  if (quantile >= 1 | quantile <= 0){stop("The quantile value must be in interval (0,1)")}
  
  ### reserve summary
  reserve <- object$reserve 
  ### estimation method ()
  method <- unlist(strsplit(object$method, split = " "))[1]
  completed <- object$completedProfiles
  inputTriangle <- object$inputTriangle
  
  if (method == "MACRAME"){
    if (!is.null(object$MarkovChain)){
      states <- object$MarkovChain$states
      breaks <- object$MarkovChain$breaks
      std <- FALSE
    } else {
      states <- NULL
      breaks <- NULL
    }
  }

  n <- nrow(completed) ### number of occurrence/development years
  last <- n * (1:n) - 0:(n - 1) ### last diagonal
  observed <- outer(1:n, 1:n, function(i, j) j <= (n + 1 - i)) ### observed/unobserved layout 
  
  ### triangle standardization
  if (std == TRUE){
    firstPositive <- apply(completed, 1, function(row){return(row[row > 0][1])})
    firstPositive[is.na(firstPositive)] <- 0
    completed[firstPositive != 0, ] <- completed[firstPositive != 0, ] / firstPositive[firstPositive != 0]
  }
  
  
    permute <- function(matrix, method = NULL){
    pMatrix <- matrix[sample(1:n, n, replace = F), ]
    zeroRows <- apply(pMatrix, 1, function(row){return(all(row == 0))})
    pMatrix[!observed] <- NA
    
    ### back-rescaling (back-standardization)
    if (std == TRUE){
      pMatrix[!zeroRows, ] <- pMatrix[!zeroRows, ] * firstPositive[firstPositive != 0]
    }
    
    ### applying PARALLAX, REACT, MACRAME
    if (method == "PARALLAX"){return(parallelReserve(pMatrix, method = "parallax")$reserve[3])}
    if (method == "REACT"){return(parallelReserve(pMatrix, method = "react")$reserve[3])}
    if (method == "MACRAME"){
      if (is.null(states) & is.null(breaks)){return(mcReserve(pMatrix)$reserve[3])} else {
        return(mcReserve(pMatrix, states = states, breaks = breaks)$reserve[3])
      }
    }  
  }
    
  startTime <- Sys.time()
  pReserve <- replicate(B, permute(completed, method))
  endTime <- Sys.time() - startTime
    
    
    

  ### OUTPUT section
  estimatedReserve <- c(sum(inputTriangle[last]), sum(object$completedProfiles[,n]), sum(object$completedProfiles[,n]) - sum(object$inputTriangle[last]), reserve[4])
  names(estimatedReserve) <- c("Paid Amount", "   Estimated Ultimate", "   Estimated Reserve", "   True Reserve")
  
  BootCoV <- 100 * stats::sd(pReserve)/mean(pReserve)
  BootVar995 <- stats::quantile(pReserve, quantile)/mean(pReserve)
  
  pSummary <- c(mean(pReserve), stats::sd(pReserve), BootCoV, BootVar995)
  names(pSummary) <- c("Boot.Mean", "   Std.Er.", "   BootCov%", paste("   BootVar.", strsplit(as.character(format(quantile, nsmall = 3)), "\\.")[[1]][2], sep = ""))
  
 
  output <- list()
  output$estimatedReserve <- estimatedReserve  ## PARALLAX/REACT/MACRAME
  output$pSummary <- pSummary
  
  output$method <- paste("Permutation bootstrap (", method, " method)", sep = "")
  output$pReserves <- as.numeric(pReserve)

  
  time <- c(paste("B = ", round(B,0), sep = ""), paste("n = ", n, sep = ""), paste(round(endTime, 2), " sec.", sep = ""))
  names(time) <- c("Permutation number", "   Triangle dimension", "   Run time")
  output$time <- time
  
  message(paste(method, " based reserving", sep = ""))
  print(round(estimatedReserve, 3))
  
  message(paste("Permutation bootstrap (B = ", B, ")", sep = ""))
  print(round(pSummary, 3))
  
  class(output) <- c('list', 'permutedReserve')
  return(invisible(output))
} ### end of permuteReserve() function

