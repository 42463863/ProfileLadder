#' Print objects of S3 class \code{profileLadder}
#'
#' Function to print the results of a call to the \code{parallelReserve()} and \code{mcReserve} functions.
#'
#' @param x an object of the class \code{profileLadder} resulting from a call to the 
#' \code{parallelReserve()} or \code{mcReserve} function
#' @param ... further arguments passed to printfurther arguments passed to \code{print}
#' 
#' @return an object of the class \code{profileLadder} -- a list with the following elements: 
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
  if (all(is.na(x$completedProfiles))){### no completed/estimated profiles available
    if (all(is.na(x$trueComplete))){### no full/true triangle available
      print(x$inputTriangle)
    } else {
      print(x$trueComplete)
    }
  } else {
    print(x$completedProfiles)
  }
  invisible(x)
}