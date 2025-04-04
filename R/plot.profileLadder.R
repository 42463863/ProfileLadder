#' Plotting development profiles 
#'
#' The function provides a graphical representation of the completed functional profiles provided by the PARALLAX, REACT, or MACRAME 
#' algorithm (see Maciak, Mizera, and Pesta (2022) for further details). The function takes an object of class 'profileLadder' --  the 
#' output of the \code{parallelReserve()} function or the \code{mcReserve()} function.
#'
#' @param x an object of the class \code{profileLadder} -- the output form \code{parallelReserve()}  or \code{mcReserve()}
#' @param xlab label for the x axis
#' @param ylab label for the y axis
#' @param main title of the plot
#' @param ... other graphical parameters to plot
#' @return A graph with the observed functional development profiles from the input run-off triangle, 
#' predicted functional segments (functional profile completions) by the corresponding estimation method (PARALLAX, REACT, or MACRAME)
#' and true (i.e., unknown future) profiles (if available)
#' 
#' @seealso [observed()], [parallelReserve()], [mcReserve()]
#' 
#' @examples
#' ## run-off triangle with 'unknown' (future) payments
#' data(CFBI)
#' print(triangle <- CFBI)
#' plot(mcReserve(triangle))
#' 
#' ## standard run-off triangle (with unknown future)
#' print(triangle <- observed(CFBI))
#' plot(mcReserve(triangle))
#'
#' 
#' @rdname plot.profileLadder
#' @export
plot.profileLadder <- function(x, xlab = "Development Year", ylab = "Cumulative Claims", main = "", ...){
  
  predictedReserve <- x$reserve[3]
  completedLadder <- x$completedProfiles
  chainLadder <- x$inputTriangle
  fullLadder <- x$trueComplete
  method <- unlist(strsplit(x$method, " "))[1]
  
  n <- nrow(chainLadder) ### number of occurrence/development years
  last <- n * (1:n) - 0:(n - 1) ### last diagonal
  observed <- outer(1:n, 1:n, function(i, j) j <= (n + 1 - i)) ### observed/unobserved layout
  
  ### completed triangle or not
  if (!all(is.na(completedLadder))){
    observedLadder <- chainLadder
    completedLadder[observed] <- NA 
    completedLadder[last] <- chainLadder[last]
    estimatedLadder <- T
  } else {estimatedLadder <- F}

  if (all(is.na(fullLadder))){### true/full chain-ladder not available
    completed <- F
  } else {completed <- T}
  
  maxMargin <- max(chainLadder, na.rm = T)
  minMargin <- min(chainLadder, na.rm = T)
  
  xMargin <- 1 - n/100
  yMargin <- maxMargin + (maxMargin - minMargin)/100
  
  layout1 <- t(matrix(rep(1:n, 2), ncol = 2))
  layout2 <- rbind(rep(minMargin, n), rep(maxMargin, n))
  
  if (completed == T){
    graphics::matplot(1:ncol(fullLadder), t(fullLadder), type = 'l', xlab = xlab, ylab = ylab, main = main, col = "darkblue", lty = 3, lwd = 1.5, ...)
    graphics::matlines(1:ncol(chainLadder), t(chainLadder), col = "darkblue", lwd = 2, lty = 1)
    
    graphics::points(1:n, chainLadder[last], pch =22, bg = "darkblue", cex = 1)
    graphics::points(rep(n,n), fullLadder[1:n,n], pch =22, bg = "darkgray", cex = 0.8)
    
    graphics::matlines(layout1, layout2, lty = 3, col = "black")
    
    if (estimatedLadder == T){
      graphics::matlines(1:ncol(completedLadder), t(completedLadder), col = "red", lwd = 1, lty = 1)
      graphics::points(rep(n,n), completedLadder[1:n,n], pch =21, bg = "darkred", cex = 1)
      
      graphics::legend("topleft", legend = c(paste("Total Paid Amount: ", round(sum(chainLadder[last],0)), sep = ""), 
                                          paste("True (unknown) reserve: ", round(sum(fullLadder[,n]) - sum(chainLadder[last]) ,0), sep = ""), 
                                          paste(method, " estimated reserve: ", round(predictedReserve ,0), sep = "")),  
             pch = 22, pt.bg = c("darkblue", "gray", "red"), fill = "lightgray", border = "lightgray", box.lwd = 0, box.col = "white", bg = "white")
    } else {
      graphics::legend("topleft", legend = c(paste("Total Paid Amount: ", round(sum(chainLadder[last],0)), sep = ""), 
                                          paste("True (unknown) reserve: ", round(sum(fullLadder[,n]) - sum(chainLadder[last]) ,0), sep = "")),  
             pch = 22, pt.bg = c("darkblue", "gray"), fill = "lightgray", border = "lightgray", box.lwd = 0, box.col = "white", bg = "white")
    }
  } else {
    graphics::matplot(1:ncol(chainLadder), t(chainLadder), type = 'l', xlab = xlab, ylab = ylab, main = main, col = "darkblue", lty = 1, lwd = 2, ...)
    graphics::points(1:n, chainLadder[last], pch =22, bg = "darkblue", cex = 1)
    
    graphics::matlines(layout1, layout2, lty = 3, col = "black")
    
    if (estimatedLadder == T){
      graphics::matlines(1:ncol(completedLadder), t(completedLadder), col = "red", lwd = 1, lty = 1)
      graphics::points(rep(n,n), completedLadder[1:n,n], pch =21, bg = "darkred", cex = 1)
      
      graphics::legend("topleft", legend = c(paste("Total Paid Amount: ", round(sum(chainLadder[last],0)), sep = ""), 
                                          paste(method, " estimated reserve: ", round(predictedReserve ,0), sep = "")),  
             pch = 22, pt.bg = c("darkblue", "red"), fill = "lightgray", border = "lightgray", box.lwd = 0, box.col = "white", bg = "white")
    } else {
      graphics::legend("topleft", legend = c(paste("Total Paid Amount: ", round(sum(chainLadder[last],0)), sep = "")),  
             pch = 22, pt.bg = c("darkblue"), fill = "lightgray", border = "lightgray", box.lwd = 0, box.col = "white", bg = "white")
    }
  }
}







  
  
