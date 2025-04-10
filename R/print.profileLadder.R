#' Print objects of the S3 class \code{profileLadder}
#'
#' Function to organize and print the outputs provided by the function 
#' \code{parallelReserve()} and the function \code{mcReserve}
#'
#' @param x an object of the class \code{profileLadder} resulting from a call 
#' of one of the functions \code{parallelReserve()}, \code{mcReserve}, or
#' \code{as.profileLadder()}
#' @param ... further arguments passed to \code{print}
#' 
#' @return an object of the class \code{profileLadder} -- a list with 
#' the following elements: 
#' \item{method}{}
#' 
#' @seealso [as.profileLadder()], [parallelReserve()], [mcReserve()]
#' 
#' @examples
#' data(CameronMutual)
#' x <- as.profileLadder(CameronMutual)
#' print(x) 
#' 
#' @rdname print.profileLadder
#' @export
print.profileLadder <- function(x, ...){
  print(x$reserve)
  message(x$method)
  if (all(is.na(x$completed))){### no imputed profiles available
    if (all(is.na(x$trueComplete))){### no full/true triangle available
      print(x$inputTriangle)
    } else {
      print(x$trueComplete)
    }
  } else {
    print(x$completed)
  }
  invisible(x)
}