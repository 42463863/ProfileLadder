#' Exploratory function for run-off triange increments
#'
#' The function takes a cumulative or incremental run-off triangle (partially or completely observed)
#' and provides some basic exploratory and graphical inspection of the observed incremental payments. 
#' The function serves as a useful tool for a user-based insight when manualy defining the states of 
#' the Markov Chain that drives the reserve prediction in the MACRAME algorithm implemented in the function \code{mcReserve()}.  
#'
#' @param triangle cumulative or incremental run-off triangle (on object of a class \code{triangle} or \code{matrix}) 
#' specified in terms of a partially observed (run-off triangle) or a fully observed (completed triangle) matrix. 
#' Only the left-upper triangular part (run-off trangle) is used to provide the output analysis of the incremental payments
#' @param method method form \code{c("median", "mean", "max", "min")} used to summarize the run-off truangle 
#' increments within a set of bins---each bin with increments within the bin is represented by a corresponding state value (obtained by the \code{method} choice)
#' of the underlying Markov chain (\code{DEFAULT = "median"})
#' @param plotOption logical to indicate whether graphical output should be provided (\code{TRUE}) or not (\code{FALSE} -- DEFAULT) 
#' @param out integer value (or a vector of integer values) to indicate which columns of the run-off triangle should be excluded 
#' from the exploratory analysis. By DEFAULT, the first incremental 
#' payments---i.e., the first column of the run-off triangle---are not considered (\code{out = 1}). If \code{out = 0} no colums are 
#' exluded and the whole run-off triangle is analyzed by \code{incrExplor()}. For a set of specific columns to be excluded, 
#' one can specify, for instance, \code{out = c(1,2,3)} which will exlude first three columns from the exploratory analysis
#' @param states either an integer value to indicate an explicit number of the Markov chain states to be used 
#' or  a vector of explicit Markov chain states can be provided. The DEFAULT option (\code{states = NULL})
#' provides an automatic definition of the Markov chain states as proposed in Maciak, Mizera, and Pešta (2022)
#' @param breaks numeric vector of explicit (unique and monotonously increasing) break points to define the bins for the run-off triangle increments. 
#' If \code{states} is equal to an integer number (i.e., the explicit number of the Markov chain states is requested by \code{states})
#' then the value of \code{breaks} is ignored. If both, \code{states} and \code{breaks} are specified (i.e., numeric vectors are provided for both)
#' then the set of states in \code{states} must be defined in a way that exactly one state belongs to exactly one bin defined by the break
#' points specified by \code{breaks}
#' 
#' @returns A list with the following elements:
#' \item{incrTriangle}{an object of the class \code{triangle} with the incremental run-off triangle}
#' \item{triangleType}{type of the input run-off triangle provided for the input \code{triangle} (cumulative or incremental)}
#' \item{defaultStates}{the set of explicit states as used (by DEFAULT) by the \code{mcReserve()} function}
#' \item{defaultBreaks}{the set of explicit breaks as used (by DEFAULT) by the \code{mcReserve()} function}
#' \item{increments}{basic empirical characteristics of the increments of the input run-off triangle (without the first origin payments---the values in the 
#' first column of the run-off triangle). Two sets of increments are provided: the raw incremental payments in the first row and 
#' the standardized increments (i.e., row increments divided by the maximal increment exluding the columns specified by the \code{out} parameter)}
#' \item{userDefined}{a list with all relevant information regarding the USER modified input (numeric vector \code{increments} with considered increments;
#' numeric value in \code{outColumns} denoting the excluded 
#' columns in the run-off triangle; \code{method} used to summarize the increments in the bins; numeric vector with the resulting Markov chain states in \code{states} and 
#' a numeric vector with the corresponding breaks in \code{breaks} defining the bins for the run-off triangle increments)}
#' 
#' @seealso [mcReserve()]
#' 
#' @examples
#' data(CameronMutual) 
#' ## default Markov Chain states with equally occupied bins with the increments
#' incrExplor(CameronMutual)
#' 
#' ## number of Markov Chain states (with equally occupied bins for the increments) is 5  
#' incrExplor(CameronMutual, states = 5)
#' 
#' ## explicitly defined breaks for five increment bins while the set of states is defined
#' ## as a median of the increments within each bin
#' incrExplor(CameronMutual, breaks = c(20, 500, 1000, 2000))
#' 
#' ## explicitly defined breaks for five bins with the run-off triangle increments and
#' ## the states are obtained as a maximum increment within each bin
#' incrExplor(CameronMutual, breaks = c(20, 500, 1000, 2000), method = "max")
#' 
#' ## manually defined break for the bins and the corresponding states where in each bin
#' ## exactly one state must be present 
#' incrExplor(CameronMutual, breaks = c(20, 500, 1000), states = c(10, 250, 800, 1500))
#' 
#' @references Maciak, M., Mizera, I., and Pešta, M. (2022). Functional Profile Techniques for Claims Reserving. ASTIN Bulletin, 52(2), 449-482. DOI:10.1017/asb.2022.4
#' 
#' 
#' @export
incrExplor <- function(triangle, method = c("median", "mean", "max", "min"), plotOption = FALSE, out = 1, states = NULL, breaks = NULL){
  ### input data checks
  if (!any(class(triangle) %in% c("triangle", "matrix"))){stop("The input data must be of class 'triangle' or 'matrix'.")}
  if (dim(triangle)[1] != dim(triangle)[2]){stop("The input data do not form a run-off triangle (square matrix).")}
  
  n <- nrow(triangle) ### number of occurrence/development years
  last <- n * (1:n) - 0:(n - 1) ### last diagonal
  observed <- outer(1:n, 1:n, function(i, j) j <= (n + 1 - i)) ### observed/unobserved layout 
  triangle[!observed] <- NA 
  
  ### cumulative or incremental
  if (sum(triangle[last]) > sum(triangle[,1])){### cumulative triangle
    triangleType <- "Cumulative"
    incrTriangle <- ChainLadder::cum2incr(triangle)
    paidAmount <- sum(triangle[last])
  } else {### incremental triangle
    triangleType <- "Incremental"
    incrTriangle <- triangle
    paidAmount <- sum(triangle[observed])
  }
  
  ##############################################################################
  ### analysis of the increments

  ### 1. DEFAULT analysis (as Maciak, Mizera, and Pesta (2022))
  ### maximum increment beside columns in out
  maxIncr <- max(incrTriangle[,-1], na.rm = T)
  
  ### all allowed increments
  incrs <- sort(incrTriangle[,-1])
  uniqueIncr <- unique(incrs)
  
  ### incremental triangle without columns in out
  incrTriangle1C <- incrTriangle[, -1]
  
  ### breaks
  xGrid <- 1:n
  yGrid2 <- incrs[ceiling((1:(length(xGrid) - 1) * n * (n - 1)) / (2 * length(xGrid))) + 1] 
  yGrid2 <- c(-Inf, unique(yGrid2), Inf)
  
  ### states
  states2 <- sapply(1:(length(yGrid2) - 1), function(k){stats::median(incrTriangle1C[incrTriangle1C >= yGrid2[k] & incrTriangle1C < yGrid2[k + 1]], na.rm = TRUE)})
  
  ### optional adjustment (if no increments in the bin)
  defaultBreaks <- yGrid2[c(!is.na(states2), T)]
  defaultBreaks[1] <- -Inf
  defaultStates <- states2[!is.na(states2)]
  
  
  ### 2. USER defined parameters (out/states/breaks)
  if (!all(out %in% 0:n)){stop("Parameter 'out' is out of the bounds")} 
  if (length(out) > n/2){stop("The number of deleted colums by the 'out' parameter is two high")}
  
  
  if (all(out != 0)){## some columns are deleted
    ### maximum increment beside columns in out
    out <- out[out != 0]
    maxIncrU <- max(incrTriangle[,-out], na.rm = T)
  
    ### all allowed increments
    incrsU <- sort(incrTriangle[,-out])
    uniqueIncrU <- unique(incrsU)
    
    ### incremental triangle without columns in out
    incrTriangle1CU <- incrTriangle[, -out]
  } else {### no columns are deleted
    ### maximum increment beside columns in out
    maxIncrU <- max(incrTriangle, na.rm = T)
    
    ### all allowed increments
    incrsU <- sort(incrTriangle)
    uniqueIncrU <- unique(incrsU)
    
    ### incremental triangle without columns in out
    incrTriangle1CU <- incrTriangle
  }
  
  if (all(method == c("median", "mean", "max","min")) & length(out) == 1 & out[1] == 1 & is.null(states) & is.null(breaks)){userInput <- F}
  else {### USER defined modifications
    userInput <- T
    if (is.null(states) & is.null(breaks)){### value of out is modified (out != 1) 
      setup <- 1
    } else {
      if (is.numeric(states) & length(states) == 1){### 2. number of states is provided (ignores the breaks parameter)
        if (round(states, 0) != states){stop("Integer value for the number of states must be provided")}
        if (states > length(uniqueIncrU)/4){stop(paste("The number of provided states is too high. Maximum allowed number of states is ", floor(length(uniqueIncrU)/4),".", sep= ""))}
        setup <- 2 
      } else {### vector of states is provided or NULL AND breaks are provided or NULL 
        if (is.numeric(states) & length(states) > 1 & is.null(breaks)){### 3. explicit set (numeric vector) of states is provided (breaks is NULL)
          if (length(states) != length(unique(states))){stop("The numeric vector of states must provide a set of unique states")} 
          if (length(states) > length(uniqueIncrU)/4){stop(paste("The number of provided states is too high. Maximum allowed number of states is ", floor(length(uniqueIncrU)/4),".", sep= ""))}
          if (min(states) <= min(uniqueIncrU) | max(states) > max(uniqueIncrU)){stop(paste("The set of states is out of bounds. Minimum observed incremenet is  ", min(uniqueIncrU)," and maximum observed increment is ", max(uniqueIncrU),".", sep= ""))}
          setup <- 3
        } else {### states explicit or NULL and explicit breaks  
          if ((class(breaks) != "numeric") | length(breaks) == 1){stop("Parameter 'breaks' should provide a numeric vector of valid (unique) breaks.")}
          if (breaks[1] != -Inf){breaks <- c(-Inf, breaks)}
          if (breaks[length(breaks)] != Inf){breaks <- c(breaks, Inf)}
          if (is.null(states)){### 4. states are NULL & breaks are provided
            if (length(unique(breaks)) != length(breaks)){stop("The vector of breaks must provide a unique set of breaks")}
            if (any(diff(breaks) < 0)){stop("The vector of breaks must provide a monotone (increasing) sequence points.")}
            setup <- 4
          } else {### 5. states and break are explicit numeric vectors
            if ((length(breaks) - 1) != length(states)){stop("The number of breaks and the number of states do not correspond ('length(states)' should be equal 'length(breaks) + 1')")}
            if (sum(table(cut(states, breaks, right = F)) != 0) != length(states)){stop("The vector of states should represent intervals given by the 'breaks' parameter.")}
            setup <- 5
          }
        }
      }
    }
      
    ### yGrid / breaks
    if (setup == 1){yGridU <- incrsU[ceiling((1:(n - 1) * length(incrsU)) / n) + 1]}
    if (setup == 2){yGridU <- incrsU[ceiling((1:(states - 1) * length(incrsU)) / states) + 1]}
    if (setup == 3){yGridU <- sort(states)[-length(states)] + diff(sort(states))/2}
    if (setup %in% 4:5){yGridU <- breaks}
    
    ### complete unique grid
    if (yGridU[1] != -Inf){yGridU <- c(-Inf, yGridU)}
    if (yGridU[length(yGridU)] != Inf){yGridU <- c(yGridU, Inf)}
    yGridU <- unique(yGridU)
    
    ### states
    if (setup %in% c(1,2,4)){
      ### definition of the states by the method 
      if (!any(method %in% c("median", "mean", "min", "max"))){stop("Incorrect method selected. Method must be from c('median', 'mean', 'min', 'max')")}
      ### median state
      if (any(method %in% c("median", "mean", "min", "max"))){statesU <- sapply(1:(length(yGridU) - 1), function(k){stats::median(incrTriangle1CU[incrTriangle1CU >= yGridU[k] & incrTriangle1CU < yGridU[k + 1]], na.rm = TRUE)})}
      ### mean state
      if (all(method == "mean")){statesU <- sapply(1:(length(yGridU) - 1), function(k){mean(incrTriangle1CU[incrTriangle1CU >= yGridU[k] & incrTriangle1CU < yGridU[k + 1]], na.rm = TRUE)})}
      ### min state
      if (all(method == "min")){statesU <- sapply(1:(length(yGridU) - 1), function(k){min(incrTriangle1CU[incrTriangle1CU >= yGridU[k] & incrTriangle1CU < yGridU[k + 1]], na.rm = TRUE)})}
      ### max state
      if (all(method == "max")){statesU <- sapply(1:(length(yGridU) - 1), function(k){max(incrTriangle1CU[incrTriangle1CU >= yGridU[k] & incrTriangle1CU < yGridU[k + 1]], na.rm = TRUE)})}
    } else {
      statesU <- states
    }
    
    ### optional adjustment (if no increments in the bin)
    yGridU <- yGridU[c(!is.na(statesU), T)]
    yGridU[1] <- -Inf
    statesU <- statesU[!is.na(statesU)]
  }
  
  ### plotting the results 
  if (plotOption == T){
    ### OS system specification
    sys_info <- Sys.info()
    if (sys_info["sysname"] == "Windows") {
      grDevices::windows(width = 20, height =15)  # Use the windows() function for Windows OS
      scaleFac <- 0.45
    } else if (sys_info["sysname"] == "Darwin") {
      grDevices::quartz(width = 12, height =8)   # Use the quartz() function for macOS
      scaleFac <- 0.75
    } else {
      grDevices::x11(width = 15, height =10)      # Use the x11() function for Linux or other OS
      scaleFac <- 1
    }
    
    ### plot 1
    graphics::par(mfrow = c(2,2))
    graphics::hist(incrs, breaks = n, col = "lightblue", xlab = "Run-off triangle increments", freq = F, main = "(I) Histogram: Incremental triangle[ , -1]", xlim = c(min(incrs), max(incrs)))
    graphics::lines(stats::density(incrs), col = "red", lwd = 2)
    
    ### plot 2
    plot(0,0, pch = "", xaxt='n', yaxt='n', frame.plot = F, xlab = "", ylab = "", xlim = c(0,1), ylim = c(0,1), main = "(II) Summary: Incremental triangle[,-1]")
    ### basic characteristics
    graphics::text(-0.05,0.97, "Run-off increments summary", font = 2, pos = 4, cex = scaleFac * 1.4)
      statValues <- c(round(as.numeric(summary(incrs))), round(stats::sd(incrs)), length(incrs))
      valuesNames <- c("Min", "1st Q.", "Median", "Mean", "3rd Q.", "Max", "Std.Er.", "Total")
      graphics::text(seq(0.35, 0.9, length = 8), rep(0.94,7), labels = valuesNames, col = "darkblue", cex = scaleFac * 1.1, pos = 1, font = 2)
      graphics::text(seq(0.35, 0.9, length = 8), rep(0.89,7), labels = statValues, col = "black", cex = scaleFac * 1, pos = 1, )
      graphics::lines(c(0.5, 0.9), c(0.79, 0.79), col = "darkred")
    ### first increments  characteristics
    graphics::text(-0.05,0.75, "First year (origin) increments", font = 2, pos = 4, cex = scaleFac * 1.4)
      statValues <- c(round(as.numeric(summary(triangle[,1]))), round(stats::sd(triangle[,1])), n)
      valuesNames <- c("Min", "1st Q.", "Median", "Mean", "3rd Q.", "Max", "Std.Er.", "Total")
      graphics::text(seq(0.35, 0.9, length = 8), rep(0.72,7), labels = valuesNames, col = "darkblue", cex = scaleFac * 1.1, pos = 1, font = 2)
      graphics::text(seq(0.35, 0.9, length = 8), rep(0.67,7), labels = statValues, col = "black", cex = scaleFac * 1, pos = 1, )
      graphics::lines(c(0.5, 0.9), c(0.57, 0.57), col = "darkred")
    ### First year stability
    graphics::text(-0.05,0.53, "First year stability (trend)", font = 2, pos = 4, cex = scaleFac * 1.4)
      m <- summary(stats::lm(triangle[,1] ~ seq(1,n, length = n)))
      statValues <- c(format(round(m$coeff[2,1], 2), nsmall = 2), format(round(m$coeff[2,2], 2), nsmall = 2), format(round(m$coeff[2,4], 4), nsmall = 4))
      valuesNames <- c("Regression trend/slope", "Std.Er.", "Significance")
      graphics::text(c(0.47,0.705, 0.86), rep(0.50,7), labels = valuesNames, col = "darkblue", cex = scaleFac * 1.1, pos = 1, font = 2)
      graphics::text(c(0.47,0.705, 0.86), rep(0.45,7), labels = statValues, col = "black", cex = scaleFac * 1, pos = 1)
      graphics::lines(c(0.5, 0.9), c(0.35, 0.35), col = "darkred")
    ### input information 
    graphics::text(-0.05,0.27, "Input triangle summary", font = 2, pos = 4, cex = scaleFac * 1.4)
    graphics::text(-0.05, 0.21, paste(triangleType, " triangle | Origin/development periods: ", n, "x", n, " | Total paid amount: ", paidAmount, sep = ""), col = "darkblue", cex = scaleFac * 1, pos = 4, font = 2)
    ### USER defined increments summary 
    if (userInput == T & sum(out) != 1){  
      graphics::text(-0.05,0.12, paste("USER selected increments [columns out = c(", paste(as.character(out), collapse = ","), ")]", sep = ""), font = 2, pos = 4, cex = scaleFac * 1.2, col = "darkred")
      statValues <- c(round(as.numeric(summary(incrsU))), round(stats::sd(incrsU)), length(incrsU))
      valuesNames <- c("Min", "1st Q.", "Median", "Mean", "3rd Q.", "Max", "Std.Er.", "Total")
      graphics::text(seq(0.35, 0.9, length = 8), rep(0.10,7), labels = valuesNames, col = "darkblue", cex = scaleFac * 1.1, pos = 1, font = 2)
      graphics::text(seq(0.35, 0.9, length = 8), rep(0.04,7), labels = statValues, col = "black", cex = scaleFac * 1, pos = 1, )
    }
      
    ### plot 3
    plotLabels <- names(table(cut(incrs, breaks=defaultBreaks, right = F, dig.lab = 6)))
    tableNum <- table(cut(incrs, breaks=defaultBreaks, right = F, dig.lab = 6))
    names(tableNum) <- 1:length(tableNum)
    defaultPlot <- graphics::barplot(tableNum, xaxt='n', xlab = paste("Run-off triangle increments (", length(defaultStates), " disjoint bins)", sep = ""), ylab = "Frequency of increments",
                                          main = "(III) DEFAULT bins/breaks for increments and MC states")
    graphics::axis(side=1,at=defaultPlot[2 * 1:ceiling(length(plotLabels)/2) - 1], labels = plotLabels[2 * 1:ceiling(length(plotLabels)/2) - 1], cex =  0.6)
    graphics::text(defaultPlot, rep(max(tableNum/5),n), labels = "MC state\n value", col = "darkred", cex = scaleFac * 0.9, pos = 1)
    graphics::text(defaultPlot, rep(max(tableNum/10),n), labels = round(defaultStates, 0), col = "darkblue", cex = scaleFac * 1.4, pos = 1, font = 2)
    
    ### plot 4
    if (userInput == T){
      plotLabelsU <- names(table(cut(incrsU, breaks=yGridU, right = F, dig.lab = 6)))
      tableNumU <- table(cut(incrsU, breaks=yGridU, right = F, dig.lab = 6))
      names(tableNumU) <- 1:length(tableNumU)
      
      userPlot <- graphics::barplot(tableNumU, xaxt='n', xlab = paste("Run-off triangle increments (", length(statesU), " disjoint bins)", sep = ""), ylab = "Frequency of increments",
                          main = "(IV) USER based: method/out/states/breaks")
      graphics::axis(side=1,at=userPlot[2 * 1:ceiling(length(plotLabelsU)/2) - 1], labels = plotLabelsU[2 * 1:ceiling(length(plotLabelsU)/2) - 1], cex = 0.6)
      graphics::text(userPlot, rep(max(tableNumU/5),n), labels = "MC state\n value", col = "darkred", cex = scaleFac * 0.9, pos = 1)
      graphics::text(userPlot, rep(max(tableNumU/10),n), labels = round(statesU, 0), col = "darkblue", cex = scaleFac * 1.4, pos = 1, font = 2)
    } else {
      plot(0,0, pch = "", xaxt='n', yaxt='n', frame.plot = F, xlab = "", ylab = "", xlim = c(0,1), ylim = c(0,1), main = "(IV) USER based: method/out/states/breaks")
      graphics::text(-0.05, 0.8, "No USER specified modifications.", pos = 4, font = 2, cex = scaleFac * 1.2)
      graphics::text(-0.05, 0.75, "(only the DEFAULT output provided).", pos = 4, font = 1, cex = scaleFac * 1, col = "darkred")
      
      graphics::text(-0.05, 0.5, "For a USER modified exploration of the run-off triangle incremental payments in this panel,", pos = 4, font = 1, cex = scaleFac * 1)
      graphics::text(-0.05, 0.43, "different settings can be used to define specific bins for the incremental payments, the method, ", pos = 4, font = 1, cex = scaleFac * 1)
      graphics::text(-0.05, 0.36, "how the increments within each bin are summarized to obtain the states, or to provide explicit", pos = 4, font = 1, cex = scaleFac * 1)
      graphics::text(-0.05, 0.29, "set of the states for underlying (homogenous) Markov chain.", pos = 4, font = 1, cex = scaleFac * 1)
      graphics::text(-0.05, 0.22, "(the following parameters can be used:                                           and                )", pos = 4, font = 1, cex = scaleFac * 1)
      graphics::text(0.40 -0.05 , 0.22, "  'method', 'out', 'states',          'breaks'", pos = 4, font = 2, cex = scaleFac * 0.95, col = "darkblue")
      
    }
  }
  
  ### summary of increments for output
  summaryExt <- function(x, d){return(c(round(summary(x),d), round(stats::sd(x), d), length(x)))}
  increments <- rbind(summaryExt(incrs, 0), summaryExt(incrs/maxIncr, 4))
  if (userInput == T){
    increments <- rbind(increments, summaryExt(incrsU, 0), summaryExt(incrsU/maxIncrU, 4))
    row.names(increments) <- c("DEFAULT raw", "DEFAULT std.", "USER raw", "USER std.")
  } else {
    row.names(increments) <- c("DEFAULT raw", "DEFAULT std.")
  }
  colnames(increments) <- c("Min", "1st Q.", "Median", "Mean", "3rd Q.", "Max", "Std.Er.", "Total")
  
  ## summary of user defined options for output
  if (userInput == T){
    userDefined <- list()
    userDefined$increments <- incrsU
    userDefined$outColumns <- out
    if (any(method %in% c("median", "mean", "min", "max"))){
      userDefined$method <- "DEFAULT (median)"
    } else {
      userDefined$method <- method
    }
    userDefined$states <- statesU
    userDefined$breaks <- yGridU
  } else {
    userDefined <- NULL  
  }
  
  ### OUTPUT 
  output <- list()
  output$incrTriangle <- ChainLadder::as.triangle(incrTriangle)
  output$triangleType <- triangleType
  output$defaultStates <- defaultStates
  output$defaultBreaks <- defaultBreaks
  output$increments <-increments
  output$userDefined <- userDefined
  
  return(output)
}
