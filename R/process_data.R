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
  data <- dplyr::select(
    DATASET,
    .data$count_point_id,
    .data$region_name,
    .data$region_ons_code,
    .data$local_authority_name,
    .data$local_authority_code,
    .data$constituency_name,
    .data$constituency_ons_code,
    .data$road_category_desc)
  data <- x %>%
    dplyr::left_join(data, by = c(count_point_id = "count_point_id")) %>%
    dplyr::rename(local_authority_ons_code = .data$local_authority_code)
  data <- dplyr::select(
    data,
    .data$count_point_id,
    .data$year,
    .data$region_id,
    .data$region_ons_code,
    .data$region_name,
    .data$local_authority_id,
    .data$local_authority_ons_code,
    .data$local_authority_name,
    .data$constituency_ons_code,
    .data$constituency_name,
    .data$easting,
    .data$northing,
    .data$latitude,
    .data$longitude,
    .data$road_name,
    .data$road_category,
    .data$road_category_desc,
    .data$road_type,
    .data$start_junction_road_name,
    .data$end_junction_road_name,
    .data$link_length_km,
    .data$link_length_miles,
    dplyr::everything(),
    -.data$sequence,
    -.data$ramp)
  data$road_type <- stringr::str_to_title(data$road_type)
  data
}

#' Process columns of download result
#'
#' @keywords internal

process_columns_download <- function(x) {
  data <- dplyr::select(
    DATASET,
    .data$count_point_id,
    .data$constituency_name,
    .data$constituency_ons_code,
    .data$road_category_desc)
  data <- x %>%
    dplyr::left_join(data, by = c(count_point_id = "count_point_id"))
  data <- data %>%
    dplyr::rename(local_authority_ons_code = .data$local_authority_code)
  data <- dplyr::select(
      data,
      .data$count_point_id,
      .data$year,
      .data$estimation_method,
      .data$region_id,
      .data$region_ons_code,
      .data$region_name,
      .data$local_authority_id,
      .data$local_authority_ons_code,
      .data$local_authority_name,
      .data$constituency_ons_code,
      .data$constituency_name,
      .data$easting,
      .data$northing,
      .data$latitude,
      .data$longitude,
      .data$road_name,
      .data$road_category,
      .data$road_category_desc,
      .data$road_type,
      .data$start_junction_road_name,
      .data$end_junction_road_name,
      .data$link_length_km,
      .data$link_length_miles,
      dplyr::everything(),
      -.data$estimation_method_detailed)
  data$road_type <- stringr::str_to_title(data$road_type)
  data
}


