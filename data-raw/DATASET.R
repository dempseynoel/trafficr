## code to prepare `DATASET` dataset goes here

DATASET <- readr::read_csv("count-points-constituencies.csv")

usethis::use_data(
  DATASET,
  internal = TRUE,
  overwrite = TRUE)
