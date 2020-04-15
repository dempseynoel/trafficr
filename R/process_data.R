# Functions for processing dataframes

#' Process travel direction codes
#'
#' @keywords internal

process_dir_codes <- function(result) {
  if ("direction_of_travel" %in% colnames(result)) {
    result$direction_of_travel <- dplyr::recode(
      result$direction_of_travel,
      C = "Combined",
      N = "North",
      E = "East",
      S = "South",
      W = "West")
    result
  } else {
    result
  }
}

#' Process columns of api result
#'
#' @keywords internal

process_columns_api <- function(x) {
  data <- dplyr::select(trafficr:::data,
    count_point_id,
    region_name,
    region_ons_code,
    local_authority_name,
    local_authority_code,
    constituency_name,
    constituency_ons_code,
    road_category_desc)
  data <- x %>%
    dplyr::left_join(data, by = c(count_point_id = "count_point_id")) %>%
    dplyr::rename(local_authority_ons_code = local_authority_code)
  data <- dplyr::select(data,
    count_point_id,
    year,
    region_id,
    region_ons_code,
    region_name,
    local_authority_id,
    local_authority_ons_code,
    local_authority_name,
    constituency_ons_code,
    constituency_name,
    easting,
    northing,
    latitude,
    longitude,
    road_name,
    road_category,
    road_category_desc,
    road_type,
    start_junction_road_name,
    end_junction_road_name,
    link_length_km,
    link_length_miles,
    dplyr::everything(),
    -sequence,
    -ramp)
  data$road_type <- stringr::str_to_title(data$road_type)
  data
}

#' Process columns of download result
#'
#' @keywords internal

process_columns_download <- function(x) {
  data <- dplyr::select(trafficr:::data,
    count_point_id,
    constituency_name,
    constituency_ons_code,
    road_category_desc)
  data <- x %>%
    dplyr::left_join(data, by = c(count_point_id = "count_point_id"))
  data <- data %>%
    dplyr::rename(local_authority_ons_code = local_authority_code)
  data <- dplyr::select(data,
      count_point_id,
      year,
      estimation_method,
      region_id,
      region_ons_code,
      region_name,
      local_authority_id,
      local_authority_ons_code,
      local_authority_name,
      constituency_ons_code,
      constituency_name,
      easting,
      northing,
      latitude,
      longitude,
      road_name,
      road_category,
      road_category_desc,
      road_type,
      start_junction_road_name,
      end_junction_road_name,
      link_length_km,
      link_length_miles,
      dplyr::everything(),
      -estimation_method_detailed)
  data$road_type <- stringr::str_to_title(data$road_type)
  data
}


