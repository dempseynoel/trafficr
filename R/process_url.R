# Functions for processing API url

#' Process API filters
#'
#' @keywords internal

process_filters <- function(
  count_point_id = NA,
  region_id = NA,
  local_authority_id = NA,
  year = NA,
  count_method = NA,
  road_name = NA,
  road_category = NA) {

  year <- process_num_char(year)
  filters <- na.omit(tibble::tibble(
    x = c(
      "count_point_id",
      "region_id",
      "local_authority_id",
      "year",
      "count_method",
      "road_name",
      "road_category"),
    y = c(
      count_point_id,
      region_id,
      local_authority_id,
      year,
      count_method,
      road_name,
      road_category)))
  filters$y <- stringr::str_remove_all(filters$y, pattern = " ")
  filters <- stringr::str_c(
    purrr::map2(filters$x, filters$y, function(param, value) {
      stringr::str_glue("filter[{param}]={value}")}),
    collapse = "&")
}

#' Process count point direction
#'
#' @keywords internal

process_direction_raw <- function(direction, raw) {
  if (direction == TRUE & raw == FALSE) {
    api_url <- stringr::str_glue("{AADF_DIRECTION}")
  } else if (direction == FALSE & raw == TRUE) {
    api_url <- stringr::str_glue("{RAW_COUNTS}")
  } else {
    api_url <- stringr::str_glue("{AADF}")
  }
}

#' Process maximum page number of pagination
#'
#' @keywords internal

process_max_page <- function(api_url) {
  jsonlite::fromJSON(api_url) %>%
    purrr::pluck("meta", "last_page")
}

#' Process pagination of API
#'
#' @keywords internal

process_pagination <- function(api_url) {
  page_numbers <- 1:process_max_page(api_url)
  api_urls <- purrr::map(page_numbers, function(page_number) {
    stringr::str_glue("{api_url}&page%5Bnumber%5D={page_number}")
  })
}

#' Process URL of API
#'
#' @keywords internal

process_api_url <- function(api_url) {
  results <- purrr::map(api_url, function(url) {
    point_data <- jsonlite::fromJSON(url) %>%
      purrr::pluck("data")
  })
  results <- dplyr::bind_rows(results)
  tibble::as_tibble(results)
}

#' Process numeric to character string
#'
#' @keywords internal

process_num_char <- function(x) {
  x <- as.character(stringr::str_c(x, collapse = ","))
}

#' Process maximum year
#'
#' @keywords internal

process_max_year <- function() {
  max_page <- process_max_page(
    stringr::str_glue("{URL_API_FEED}{AADF}"))
  max_page <- jsonlite::fromJSON(
    stringr::str_glue("{URL_API_FEED}{AADF}&page%5Bnumber%5D={max_page}"))
  max_year <- max(max_page$data$year)
}
