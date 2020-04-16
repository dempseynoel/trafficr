# Functions for processing requested geography

#' Process constituency name
#'
#' @keywords internal

process_constituency <- function(constituency = NA) {
  if (is.na(process_concatenate(constituency)) == FALSE) {
    data <- trafficr:::data
    count_point_id <- dplyr::filter(data, constituency_name %in% constituency) %>%
      dplyr::select(count_point_id)
    count_point_id <- stringr::str_c(count_point_id$count_point_id, collapse = ",")
  } else {
    count_point_id <- NA
  }
}

#' Process authority name
#'
#' @keywords internal

process_authority <- function(authority = NA) {
  if (is.na(process_concatenate(authority)) == FALSE) {
    data <- trafficr:::data
    authority_id <- dplyr::filter(data, local_authority_name %in% authority) %>%
      dplyr::select(local_authority_id)
    authority_id <- stringr::str_c(unique(authority_id$local_authority_id), collapse = ",")
  } else {
    authority_id <- NA
  }
}

#' Process region name
#'
#' @keywords internal

process_region <- function(region = NA) {
  if (is.na(process_concatenate(region)) == FALSE) {
    data <- trafficr:::data
    region_id <- dplyr::filter(data, region_name %in% region) %>%
      dplyr::select(region_id)
    region_id <- stringr::str_c(unique(region_id$region_id), collapse = ",")
  } else {
    region_id <- NA
  }
}

#' Process road name
#'
#' @keywords internal

process_road <- function(road = NA) {
  if (is.na(process_concatenate(road)) == FALSE) {
    data <- trafficr:::data
    road <- dplyr::filter(data, road_name %in% road) %>%
      dplyr::select(road_name)
    road <- stringr::str_c(unique(road$road_name), collapse = ",")
  } else {
    road <- NA
  }
}

#' Process concatenation of multiple locations
#'
#' @keywords internal

process_concatenate <- function(x) {
  stringr::str_c(x, collapse = "")
}
