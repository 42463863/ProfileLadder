#' S3 Method class \code{profileLadder}
#'
#' A function to make the work with the functional development profiles within run-off triangles 
#' more easy and straightforward (particularly when plotting the functional profiles)
#'
#' @param x an object of the class \code{matrix} or \code{triangle}
#' 
#' @return an object of the class \code{profileLadder} -- a list with the following elements: 
#' \item{reserve}{basic summary of the run-off triangle and the true and the estimated reserve 
#' (if available -- \code{NA} values returned otherwise)}
#' \item{method}{type of the triangle (run-off/complete) or the type of the estimation method used
#' to complete the functional development profiles (PARALLAX, REACT, or MACRAME)}
#' \item{completedProfiles}{completed development profiles estimated by the PARALLAX, REACT, or MACRAME algorithm}
#' \item{inputTriangle}{standard (triangular shaped)  run-off triangle}
#' \item{trueComplete}{true completed development profiles of teh run-off triangle (if available) -- value \code{NA} returned otherwise}
#' 
#' @seealso [parallelReserve()], [mcReserve()], [permuteReserve()], [plot.profileLadder()]
#' 
#' @examples
#' data(CameronMutual)
#' print(CameronMutual) 
#' 
#' x <- as.profileLadder(CameronMutual)
#' 
#' print(x)
#' plot(x)
#' 
#' @rdname as.profileLadder
#' @export
as.profileLadder <- function(x){
  if (any(class(x) == "triangle") | any(class(x) == "matrix")){### 
    if (dim(x)[1] != dim(x)[2]){stop("The object 'x' dimensions do not correspond")}
    
    n <- nrow(x) ### number of occurrence/development years
    last <- n * (1:n) - 0:(n - 1) ### last diagonal
    observed <- outer(1:n, 1:n, function(i, j) j <= (n + 1 - i)) 
    
    reserveOutput <- c(sum(x[last]), NA, NA, sum(x[,n]) - sum(x[last]))
    names(reserveOutput) <- c("Paid Amount", "   Estimated Ultimate", "   Estimated Reserve", "   True Reserve")
    
    output <- list()
    output$reserve <- reserveOutput
    if (all(is.na(x[!observed])) == F){### completed triangle
      output$method <- "Run-off triangle (complete/fully observed)"
    } else {
      output$method <- "Run-off triangle" 
    }
    print(output$reserve)
    message(output$method)
    
    output$completedProfiles <- NA
    output$inputTriangle <- ChainLadder::as.triangle(observed(x))
    if (all(is.na(x[!observed(n)]))){
      output$trueComplete <- NA
      print(output$inputTriangle)
    } else {
      output$trueComplete <- ChainLadder::as.triangle(x)
      print(output$trueComplete)
    }
    output$residuals <- NULL 
    
    class(output) <- c('list', 'profileLadder')
    return(invisible(output))
  } else {
    if (all(class(x) != "profileLadder")){stop("The object 'x' is not compatible with the 'profileLadder' class")}
    print(x$reserve)
    print(x$method)
    if (is.na(x$completedProfiles)){
      if (all(is.na(x$trueComplete))){
        print(x$inputTriangle)
      } else {print(x$trueComplete)}
    } else {print(x$completedProfiles)}
  
    return(invisible(x))
  }
}