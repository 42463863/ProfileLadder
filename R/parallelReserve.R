#' Parallel based development profile reserve 
#'
#' The function takes a cumulative (or incremental) run-off triangle (partially or completely observed)
#' and returns the reserve estimate obtained by the PARALLAX or REACT algorithm (see Maciak, Mizera, and Pešta (2022) for more details).
#' If the full square is provided as the input then the algorithm still consider only the partially observed run-ff 
#' triangle for the reserve estimation but, in addition, incremental residuals (true increments minus predicted increments) are returned 
#' for validation purposes. If the run-off triangle is provided,  then algorithm provides back-fitted (incremental) residuals istead 
#' (see Maciak, Mizera, and Pešta (2022) for details).
#'
#' @param chainLadder cumulative or incremental run-off triangle (the triangle must be of class \code{triangle} or \code{matrix}) 
#' in terms of a square matrix with a fully observed upper-left triangular part 
#' (if the lower-right part is also provided the function will also return residuals)
#' @param method prediction method: PARALLAX (\code{default}) or REACT (\code{method = "react"}) 
#' @param cum logical (TRUE for cumulative triangle, FALSE for incremental)
#' @param residuals logical to indicate whether raw (incremental) residuals should be provided or not. If the run-off triangle is complete than the residuals
#' are obtained in terms of true increments minus predicted increments. If the bottom-right part is missing the residuals are provided in terms of the backfitting approach (see Maciak, Mizera, and Pesta (2022) for further details).
#' 
#' @returns A list with with the following elements: 
#' \item{reserve}{numeric vector with four values: Total paid amount (i.e., the sum of the last observed diagonal in a cumulative run-off triangle); Total estimated amount (i.e., the sum of the last column 
#' in the completed cumulative triangle); Estimated reserve (i.e., the sum of the last column in the completed cumulative triangle minus the sum of the last observed diagonal in \code{chainLadder}); True reserve 
#' if a completed (true) \code{chainLadder} is provided in the output (i.e., the sum of the last column in \code{chainLadder} minus the sum of the last diagonal in \code{chainLadder})}
#' \item{method}{algorithm used for the reserve estimation}
#' \item{completedProfiles}{completed run-off triangle (the lower-right triangle in \code{fullTriangle})}
#' \item{inputTriangle}{the run-off triangle considered for the reserve estimation}
#' \item{trueCompleted}{run-off triangle completed into a full square (if available at the output)---the upper-left part was used by the algoritm to estimate the reserve}
#' \item{residuals}{a triangle with residuals (for \code{residuals = T}):  If the residuals are given in the upper-left triangle than backfitted (incremental) residuals are provided 
#' and if the residuals are given in the lower-right triangle, standard (incremental) residuals are provided}
#'  
#' @seealso [permuteReserve()], [mcReserve()]
#'  
#' @examples
#' #run-off (upper-left) triangle with NA values
#' \donttest{print(MW2014) 
#' parallelReserve(MW2014, residuals = TRUE)
#' }
#' 
#' ## completed run-off triangle with 'unknown' truth (lower-bottom triangle) where 
#' ## for the estimation purposes only the upper-left triangle is used 
#' data(CameronMutual)
#' parallelReserve(CameronMutual, residuals = TRUE)
#' 
#' ## the previous output is identical (in term of the reserve prediction) but
#' ## back-fitted residuals are provided in the output instead 
#' print(observed(CameronMutual))
#' parallelReserve(observed(CameronMutual), residuals = TRUE)
#' 
#' 
#' @import raw
#' 
#' @references Maciak, M., Mizera, I., and Pešta, M. (2022). Functional Profile Techniques for Claims Reserving. ASTIN Bulletin, 52(2), 449-482. DOI:10.1017/asb.2022.4
#'
#' @export
parallelReserve <- function(chainLadder, method = "parallax", cum = T, residuals = F){
  ### input data checks
  if (method != "parallax" & method != "react"){stop("Not a correct prediction method = c('parallel', 'react') selected.")}
  if (!any(class(chainLadder) %in% c("triangle", "matrix"))){stop("The input data must be of class 'triangle' or 'matrix'.")}
  if (dim(chainLadder)[1] != dim(chainLadder)[2]){stop("The input data do not form a run-off triangle (square matrix).")}
  
  
  n <- nrow(chainLadder) ### number of occurrence/development years
  last <- n * (1:n) - 0:(n - 1) ### last diagonal
  observed <- outer(1:n, 1:n, function(i, j) j <= (n + 1 - i)) ### observed/unobserved layout 
  
  if (!is.numeric(chainLadder[observed])){stop("The input values are not numeric.")}
  
  if (cum == T){
    if (sum(chainLadder[last]) < sum(chainLadder[,1])){warning("The input run-off triangle seems to be not of the cumultative type!")}
  } else {
    if (sum(chainLadder[last]) > sum(chainLadder[,1])){warning("The input run-off triangle seems to be of a cumulative type!")}
    chainLadder <- ChainLadder::incr2cum(chainLadder)
  }
  
  if (sum(is.na(chainLadder[observed])) > 0){stop("The run-off triangle is not fully observed (missing values).")}
  
  if (sum(as.numeric(is.na(chainLadder[!observed]))) > 0){### backfitted residuals for triangular input
    backfitting <- T
  }else{### standard residuals for full data input (triangle completed into a square)
    backfitting <- F
  }
  
  if (method == "parallax"){
    methodType <- "PARALLAX"
    
    ### completing the run-off triangle
    completed <- chainLadder 
    ### auxiiary function for imputing values 
    impute_values <- function(i, j, x){
      diffVector <- x[1:(n - i + 1 - j), i - 1 + j] - x[n - i + 2, i - 1 + j]
      if (x[n - i + 2, i - 1] == 0) {
        return(0)
      } else {
        minIndex <- which.min(abs(diffVector))
        return(x[n - i + 2, i - 1 + j] + mean(x[minIndex, i + j] - x[minIndex, i - 1 + j]))
      }
    }
    
    for (j in 0:(n - 2)){
      index_pairs <- expand.grid(i = 2:(n - j), j = j)
      completed[row(completed) + col(completed) == n + 2 + j] <- mapply(impute_values, index_pairs$i, index_pairs$j, list(x = completed))
    }
    
    ### overall predicted reserve 
    reserve <- sum(completed[,n]) - sum(completed[last])
    
    ### backfitting for residuals
    if (residuals == TRUE){
      if (backfitting == TRUE){
        resids <- matrix(rev(as.vector(completed)), nrow = n, byrow = F)
        
        for (j in 0:(n - 2)){
          index_pairs <- expand.grid(i = 2:(n - j), j = j)
          resids[row(completed) + col(completed) == n + 2 + j] <- mapply(impute_values, index_pairs$i, index_pairs$j, list(x = resids))
        }
        
        resids <- matrix(rev(as.vector(resids)), nrow = n, byrow = F)
        
        resids <- ChainLadder::cum2incr(completed) - ChainLadder::cum2incr(resids)
        resids[!observed] <- NA
      } else {
        resids <- ChainLadder::cum2incr(chainLadder) - ChainLadder::cum2incr(completed)
        resids[observed] <- NA
      }}
  } ### end of PARALLAX method 
  
  if (method == "react"){
    methodType <- "REACT"
    
    ### completing the run-off triangle
    completed <- chainLadder
    ### auxiiary function for imputing values
    impute_values <- function(i, j, x){
      diffValue <- x[n - i + 2, i - 1 + j] - x[n - i + 1, i - 1 + j] 
      if (x[n - i + 2, i - 1] == 0) {
        return(0)
      } else {
        return(x[n - i + 1, i + j] + diffValue)
      }
    }
    
    for (j in 0:(n - 2)){
      index_pairs <- expand.grid(i = 2:(n - j), j = j)
      completed[row(completed) + col(completed) == n + 2 + j] <- mapply(impute_values, index_pairs$i, index_pairs$j, list(x = completed))
    }
    
    ### overall predicted reserve 
    reserve <- sum(completed[,n]) - sum(completed[last])
    
    
    ### backfitting for residuals
    if (residuals == TRUE){
      if (backfitting == TRUE){
        resids <- matrix(rev(as.vector(completed)), nrow = n, byrow = F)
        
        for (j in 0:(n - 2)){
          index_pairs <- expand.grid(i = 2:(n - j), j = j)
          resids[row(completed) + col(completed) == n + 2 + j] <- mapply(impute_values, index_pairs$i, index_pairs$j, list(x = resids))
        }
        
        resids <- matrix(rev(as.vector(resids)), nrow = n, byrow = F)
        
        resids <- ChainLadder::cum2incr(completed) - ChainLadder::cum2incr(resids)
        resids[!observed] <- NA
      } else {
        resids <- ChainLadder::cum2incr(chainLadder) - ChainLadder::cum2incr(completed)
        resids[observed] <- NA
      }}
  } ### end of REACT method
  
  ### OUTPUT section
  reserveOutput <- c(sum(chainLadder[last]), sum(completed[,n]), sum(completed[,n]) - sum(completed[last]), sum(chainLadder[,n]) - sum(chainLadder[last]))
  names(reserveOutput) <- c("Paid Amount", "   Estimated Ultimate", "   Estimated Reserve", "   True Reserve")
  
  inputTriangle <- chainLadder
  inputTriangle[!observed] <- NA
  
  output <- list()
  output$reserve <- reserveOutput
  output$method <- paste(methodType, " method (functional profile completion)", sep = "")
  output$completedProfiles <- ChainLadder::as.triangle(completed)
  output$inputTriangle <- ChainLadder::as.triangle(inputTriangle)
  output$trueComplete <- ChainLadder::as.triangle(chainLadder)
  if (residuals == TRUE){output$residuals <- resids} else {output$residuals <- NULL}
  
  class(output) <- c('list', 'profileLadder')
  return(output)
} ### end of parallelReserve function