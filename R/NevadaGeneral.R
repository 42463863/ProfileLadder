#' Nevada General Insurance data 
#'
#' An illustrative dataset---a matrix (of the dimensions 10\code{x}10) with ten completed years of claims payment developments of 
#' the Nevada General Insurance company from the period 1988 -- 1997.  However, the data matrix only contains four non-zero 
#' origin/occurrence years (from the period 1994 -- 1997) being fully developed for ten consecutive development periods/years (in columns). 
#' The remaining matrix rows are all zeros. The resulting run-off triangle (the upper-left triangular part of the data matrix)
#' is, therefore, sparse and very uninformative. 
#' 
#' In practice, the upper-left triangle (the run-off triangle) is typically observed (known) while the bottom-right 
#' triangular part of the data matrix is treated as a future payments outcome (an "unknown" truth) that should be estimated/predicted. 
#' The Nevada General Insurance data matrix is fully observed to allow for some goodness-of-fit evaluations 
#' 
#' @name NevadaGeneral
#' 
#' @docType data
#' @usage data(NevadaGeneral)
#'
#' @format ## NevadaGeneral
#' A simple \code{10x10} matrix of a class \code{triangle} with ten origin years (rows) each being fully developed 
#' within ten consecutive development periods/years (columns)
#' 
#' \describe{
#'   \item{origin}{matrix rows with the occurrence year (origin)}
#'   \item{dev}{matrix columns with the development period (development)}
#' }
#' @source \url{https://www.casact.org/research/reserve_data/ppauto_pos.csv} 
#' (NAIC group code: 10007)
#' 
#' @references Meyers, G. G. and P. Shi (2011). Loss reserving data pulled from NAIC Schedule P. Available from 
#' \url{http://www.casact.org/research/index.cfm?fa=loss_reserves_data}
NULL


