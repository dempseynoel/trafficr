# Functions to get data from the DfT Road Traffic API

#' Get road traffic data for a constituency
#'
#' \code {get_traffic_constituency} gets the average annual daily flow
#' of road raffic recorded on all count points within a given GB Parliamentary
#' constituency since the year 2000. Results are returned as a tibble.
#'
#' @param constituency A character string of the GB parliamentary constituency
#' of interest written within a pair of single or double qoutes.
#' @param year A numeric no smaller than 2000.
#' @param direction A boolean which if TRUE shows the average annual daily flow
#' of road traffic by direction of travel. It is set FALSE by default.
#' @param raw A boolean which if TRUE shows the actual manual counts taken at
#' count point locations. Raw counts are collected by trained enumerators and
#' are used to feed into calculating the average daily flow estimates.
#' It is set to FALSE by default.
#'
#' @return A tibble showing the average annual daily flow of traffic for
#' a given constituency.
#'
#' @examples
#' get_traffic_constituency(constituency = "St Ives")
#' get_traffic_constituency(constituency = c("St Ives", "Ashford"), year = 2000)
#' get_traffic_constituency(constituency = "St Ives", year = 2000:2005)
#' get_traffic_constituency(constituency = "St Ives", year = c(2000, 2010, 2018))
#' get_traffic_constituency(constituency = "St Ives", direction = TRUE)
#' get_traffic_constituency(constituency = "St Ives", year = 2000, raw = TRUE)

get_traffic_constituency <- function(
  constituency = NA,
  year = NA,
  direction = FALSE,
  raw = FALSE) {

  error <- process_error(
    constituency,
    "constituency_name",
    "GB Parliamentary constituency",
    year,
    direction,
    raw)

  if (error != "No error") {
    stop(error)
  }

  count_points <- process_constituency(constituency)
  filters <- process_filters(count_point_id = count_points, year = year)
  direction_raw <- process_direction_raw(direction, raw)
  api_url <- process_pagination(
    stringr::str_glue("{URL_API_FEED}{direction_raw}{filters}"))
  result <- process_columns_api(process_dir_codes(process_api_url(api_url)))
  result
}

#' Get road traffic data for a local authority
#'
#' \code {get_traffic_authority} gets the average annual daily flow
#' of road raffic recorded on all count points within a given GB local
#' authority since the year 2000. Results are returned as a tibble.
#'
#' @param authority A character string of the GB local authority
#' of interest written within a pair of single or double qoutes.
#' @param year A numeric no smaller than 2000.
#' @param direction A boolean which if TRUE shows the average annual daily flow
#' of road traffic by direction of travel. It is set FALSE by default.
#' @param raw A boolean which if TRUE shows the actual manual counts taken at
#' count point locations. Raw counts are collected by trained enumerators and
#' are used to feed into calculating the average daily flow estimates.
#' It is set to FALSE by default.
#'
#' @return A tibble showing the average annual daily flow of traffic for
#' a given local authority.
#'
#' @examples
#' get_traffic_authority(authority = "Swansea")
#' get_traffic_authority(authority = c("Swansea", "Lambeth"), year = 2000)
#' get_traffic_authority(authority = "Swansea", year = 2000:2005)
#' get_traffic_authority(authority = "Swansea", year = c(2000, 2010, 2018))
#' get_traffic_authority(authority = "Swansea", direction = TRUE)
#' get_traffic_authority(authority = "Swansea", year = 2000, raw = TRUE)

get_traffic_authority <- function(
  authority = NA,
  year = NA,
  direction = FALSE,
  raw = FALSE) {

  error <- process_error(
    authority,
    "local_authority_name",
    "GB local authority",
    year,
    direction,
    raw)

  if (error != "No error") {
    stop(error)
  }

  authority <- process_authority(authority)
  filters <- process_filters(local_authority_id = authority, year = year)
  direction_raw <- process_direction_raw(direction, raw)
  api_url <- process_pagination(
    stringr::str_glue("{URL_API_FEED}{direction_raw}{filters}"))
  result <- process_columns_api(process_dir_codes(process_api_url(api_url)))
  result
}

#' Get road traffic data for a region
#'
#' \code {get_traffic_region} gets the average annual daily flow
#' of road raffic recorded on all count points within a given GB region
#' since the year 2000. Results are returned as a tibble.
#'
#' @param region A character string of the GB region
#' of interest written within a pair of single or double qoutes.
#' @param year A numeric no smaller than 2000.
#' @param direction A boolean which if TRUE shows the average annual daily flow
#' of road traffic by direction of travel. It is set FALSE by default.
#' @param raw A boolean which if TRUE shows the actual manual counts taken at
#' count point locations. Raw counts are collected by trained enumerators and
#' are used to feed into calculating the average daily flow estimates.
#' It is set to FALSE by default.
#'
#' @return A tibble showing the average annual daily flow of traffic for
#' a given region.
#'
#' @examples
#' get_traffic_region(region = "London")
#' get_traffic_region(region = c("London", "South West"), year = 2000)
#' get_traffic_region(region = "London", year = 2000:2005)
#' get_traffic_region(region = "London", year = c(2000, 2010, 2018))
#' get_traffic_region(region = "London", direction = TRUE)
#' get_traffic_region(region = "London", year = 2000, raw = TRUE)

get_traffic_region <- function(
  region = NA,
  year = NA,
  direction = FALSE,
  raw = FALSE) {

  error <- process_error(
    region,
    "region_name",
    "GB region",
    year,
    direction,
    raw)

  if (error != "No error") {
    stop(error)
  }

  region <- process_region(region)
  filters <- process_filters(region_id = region, year = year)
  direction_raw <- process_direction_raw(direction, raw)
  api_url <- process_pagination(
   stringr::str_glue("{URL_API_FEED}{direction_raw}{filters}"))
  result <- process_columns_api(process_dir_codes(process_api_url(api_url)))
  result
}

#' Get all road traffic data
#'
#' \code {get_traffic_all} gets the average annual daily flow
#' of road raffic recorded on all count points within Great Britain since
#' the year 2000. Results are returned as a tibble.
#'
#' @param direction A boolean which if TRUE shows the average annual daily flow
#' of road traffic by direction of travel. It is set FALSE by default.
#'
#' @return A tibble showing the average annual daily flow of traffic for
#' all counts in Great Britain.
#'
#' @examples
#' get_traffic_all()
#' get_traffic_all(direction = TRUE)

get_traffic_all <- function(direction = FALSE) {

  traffic_download <- tempfile()

  if (direction == FALSE) {
    download.file(AADF_ALL, traffic_download, mode = "wb")
    unzip(traffic_download, "dft_traffic_counts_aadf.csv")
    result <- suppressWarnings(readr::read_csv("dft_traffic_counts_aadf.csv"))
  } else {
    download.file(AADF_ALL_DIRECTION, traffic_download, mode = "wb")
    unzip(traffic_download, "dft_traffic_counts_aadf_by_direction.csv")
    result <- suppressWarnings(readr::read_csv("dft_traffic_counts_aadf_by_direction.csv"))
  }
  result <- process_columns_download(result)
  result
}

#' Get historic regional road traffic data
#'
#' \code {get_traffic_region_historic} gets the annual total volume of road
#' traffic across each GB region since 1993. Results are returned as a tibble.
#'
#' @return A tibble showing the annual total volume of road traffic across
#' each GB region since 1993.
#'
#' @examples
#' get_traffic_region_historic()

get_traffic_region_historic <- function() {
  result <- readr::read_csv(REGION_HISTORIC, col_types = readr::cols()) %>%
    dplyr::rename(
      "region_ons_code" = ons_code,
      "region_name" = name,
      "road_category_desc" = road_category_id) %>%
    dplyr::select(
      year,
      region_id,
      region_ons_code,
      region_name,
      dplyr::everything())
  result$road_category_desc <- as.character(result$road_category_desc)
  result$road_category_desc <-  dplyr::recode(
      result$road_category_desc,
      "1" = "Trunk Motorway",
      "2" = "Principal Motorway",
      "3" = "Trunk A road",
      "4" = "Principal A road",
      "5" = "Minor B road",
      "6" = "Minor C or U road")
  result
}

#' Get historic authority road traffic data
#'
#' \code {get_traffic_authority_historic} gets the annual total volume of road
#' traffic across each GB local authority since 1993.
#' Results are returned as a tibble.
#'
#' @return A tibble showing the annual total volume of road traffic across
#' each GB local authority since 1993.
#'
#' @examples
#' get_traffic_authority_historic()

get_traffic_authority_historic <- function() {
  readr::read_csv(AUTHORITY_HISTORIC, col_types = readr::cols()) %>%
    dplyr::rename(
      "local_authority_name" = name,
      "local_authority_ons_code" = ons_code) %>%
    dplyr::select(
      year,
      local_authority_id,
      local_authority_ons_code,
      local_authority_name,
      dplyr::everything())
}
