# Functions to generate error messages

#' Process potential error messages
#'
#' @param geogrpahy The geography of the get_* function.
#' @param column_name The column name in the hidden dataframe corresponding
#' to the geography argument.
#' @param message Message to be displayed in errors.
#' @param year The 'year' arguement from the get_* function.
#' @param direction The 'direction' arugment from the get_* function.
#' @param raw The 'raw' argument from the get_* function.
#'
#' @keywords internal

process_error <- function(geography, column_name, message, year, direction, raw) {
  if (is.na(stringr::str_c(geography, collapse = ""))) {
    error <- error_geography(message)
  } else if (FALSE %in% (geography %in% trafficr:::data[[column_name]])) {
   error <- error_name(message)
  } else if (min(year) < 2000) {
    error <- error_year()
  } else if (typeof(direction) != "logical") {
    error <- error_direction_boolean()
  } else if (typeof(raw) != "logical") {
    error <- error_raw_boolean()
  } else if (direction == TRUE & raw == TRUE) {
    error <- error_direction_raw()
  } else {
    error <- "No error"
  }
}

#' Error geography
#'
#' @param x The type of geography in the get_* function.
#'
#' @keywords internal

error_geography <- function(x) {
  stringr::str_glue("Supply the name(s) of a {x}.")
}

#' Error name
#'
#' @param x The name of a geography in the get_* function.
#'
#' @keywords internal

error_name <- function(x) {
  stringr::str_glue("Supply the name(s) of a {x}.")
}

#' Error year
#'
#' @keywords internal

error_year <- function() {
  stringr::str_glue("The argument 'year' cannot be earlier than 2000.")
}

#' Error direction boolean
#'
#' @keywords internal

error_direction_boolean <- function() {
  stringr::str_c("The argument 'direction' must be either TRUE or FALSE.")
}

#' Error raw boolean
#'
#' @keywords internal

error_raw_boolean <- function() {
  stringr::str_c("The arguent 'raw' must be either TRUE or FALSE.")
}

#' Error direction raw
#'
#' @keywords internal

error_direction_raw <- function() {
  stringr::str_c("The arguments 'direction' and 'raw' cannot both be TRUE.")
}
