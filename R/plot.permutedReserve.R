#' Plotting the output of the permutation bootstrap
#'
#' The function provides a graphical visualization of the results obtained from 
#' the permutation bootstrap (see Maciak, Mizera, and Pesta (2022) for further 
#' details) applied to the output of one of the estimation algorithm---PARALLAX 
#' or REACT implemented in the \code{parallelReserve()} function or MACRAME 
#' implemented in the \code{mcReserve()} function. 
#'
#' @param x an object of the class \code{permutedReserve} -- i.e., the output 
#' of the \code{permuteReserve()} function
#' @param density logical to indicate whether a simple boxplot is supposed to be 
#' plotted (DEFAULT \code{density = TRUE}) or some more complex histogram with 
#' a nonparametrix density estimate of the reserve distribution should be plotted 
#' instead (\code{density = TRUE})
#' @param ... other graphical parameters to plot
#' 
#' @return The function returns either the boxplot of the permuted bootstrap 
#' reserves (\code{density = FALSE}) or it returns a histogram with a nonparametric 
#' estimate of the overall (permuted bootstrapped) reserve (\code{density = TRUE}). 
#' Some additional quantities (such as the true reserve or the estimated reserve 
#' amount are provided in the plot)
#' 
#' @seealso [permuteReserve()]
#' 
#' @examples
#' ## reserve estimate by MACRAME and boxplot of the permuted bootstrapped reserves
#' x <- mcReserve(CameronMutual)
#' plot(permuteReserve(x))
#' 
#' ## histogram of and the estimated reserve distribution
#' plot(permuteReserve(x), density = TRUE)
#' 
#' @rdname plot.permutedReserve
#' @export
plot.permutedReserve <- function(x, density = FALSE, ...){
    
    reserve <- x$estimatedReserve
    pReserve <- x$pReserves
    method <- gsub("\\(", "", strsplit(x$method, " ")[[1]][3])
    B <- as.numeric(strsplit(x$time[1], " = ")[[1]][2])
    n <- as.numeric(strsplit(x$time[2], " = ")[[1]][2])
  
    if (density == FALSE){
      offSet <- (max(pReserve) - min(pReserve))/30
      ylimits <- c(0.98 * min(c(pReserve, reserve[3], reserve[4]), na.rm = T), 
                   1.02 * max(c(pReserve, reserve[3], reserve[4]), na.rm = T))
      graphics::boxplot(pReserve, main = paste(method, " (B = ", B, ")", sep = ""), 
                        cex = 0.8, ylim = ylimits, xlab = "Boxplot: Permutation bootstrap")
      graphics::lines(rep(mean(pReserve), 2) ~ c(0.6, 1.4), col = "black", lwd = 3, lty = 2)
      graphics::text(0.5, mean(pReserve) + offSet, "Boot. Avg.", col = "black", pos = 4, cex = 0.8)
      
      if (!is.na(reserve[4])){
        if (reserve[4] > reserve[3]){
          graphics::abline(reserve[4], 0, col = "darkred", lwd = 2)
          graphics::text(0.5, reserve[4] + offSet, 
                         "True reserve", col = "darkred" , pos = 4, cex = 0.8)
          
          graphics::abline(reserve[3], 0, col = "darkblue", lwd = 2, lty = 2)
          graphics::text(0.5, reserve[3] - offSet, 
                         paste(method, " reserve", sep =""), col = "darkblue" , 
                         pos = 4, cex = 0.8)
        } else {
          graphics::abline(reserve[4], 0, col = "darkred", lwd = 2)
          graphics::text(0.5, reserve[4] - offSet, 
                         "True reserve", col = "darkred" , pos = 4, cex = 0.8)
          
          graphics::abline(reserve[3], 0, col = "darkblue", lwd = 2, lty = 2)
          graphics::text(0.5, reserve[3] + offSet, 
                         paste(method, " reserve", sep =""), col = "darkblue" , 
                         pos = 4, cex = 0.8)
        }
      } else {
        graphics::abline(reserve[3], 0, col = "darkblue", lwd = 2, lty = 2)
        graphics::text(0.5, reserve[3] + offSet, 
                       paste(method, " reserve", sep =""), col = "darkblue" , 
                       pos = 4, cex = 0.8)
      }
    }
    if (density == TRUE){
      dEst <- stats::density(pReserve)
      xLim <- c(min(dEst$x), max(dEst$x))
      yLim <- max(dEst$y)
      graphics::hist(pReserve, xlab = "Permuted (bootstrap) reserves", ylab = "", 
                     main = "Permutation reserve distribution", 
                     breaks = max(n, B/n), xlim = xLim, ylim = c(0, 1.2 * yLim), 
                     freq = F, cex = 0.8)
      graphics::polygon(dEst$x, dEst$y, 
                        col = grDevices::adjustcolor( "red", alpha.f = 0.1))
      graphics::lines(dEst, col = "red", lwd = 2)
      if (!is.na(reserve[4])){
        graphics::lines(rep(reserve[4], 2), c(0,1.1 * yLim), 
                        col = "darkred", lwd = 3)
        graphics::lines(rep(reserve[3], 2), c(0, 1.1 * yLim), 
                        col = "darkblue", lwd = 3, lty = 2)
        graphics::legend("topright", legend = c("True reserve", 
                                                paste(method, "reserve", sep = " "), 
                                                "Permuted bootstrap density"), 
                                     col = c("darkred", "darkblue", "red"), pch = 22, 
                                     pt.bg = c("darkred", "darkblue", "red"), 
                                     fill = "lightgray", border = "lightgray", 
                                     box.lwd = 0, box.col = "white", bg = "white")
      } else {
        graphics::lines(rep(reserve[3], 2), c(0, 1.1 * yLim), 
                        col = "darkblue", lwd = 3, lty = 2)
        graphics::legend("topright", legend = c(paste(method, "reserve", sep = " "), 
                                                "Permuted bootstrap density"), 
                                     col = c("darkblue", "red"), pch = 22, 
                                     pt.bg = c("darkred", "darkblue", "red"), 
                                     fill = "lightgray", border = "lightgray", 
                                     box.lwd = 0, box.col = "white", bg = "white")
      }
    }
}









