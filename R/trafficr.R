#' trafficr: Download road traffic data for the UK
#'
#' trafficr is a package for downloading data from the DfT Road Traffic
#' Statistics API.
#'
#' @docType package
#' @name trafficr
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @importFrom stats na.omit
NULL

# Tell R CMD check about new operators
if(getRversion() >= "2.15.1") {
  utils::globalVariables(c(".", ":="))
}
