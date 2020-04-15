# trafficr
trafficr offers a suite of functions for accessing road traffic data stored in the UK's Department for Transport (DfT) [Road Traffic Open Data API](https://roadtraffic-docs.dft.gov.uk/#road-traffic-open-data).

## Overview
The DfT has created an open API to their data on road traffic in the UK. The DfT collects street-level road traffic data for every junction-to-junction link on the motorway and 'A' road network, and for some minor roads in Great Britain. Traffic data is broken down by vehicle type, road category and geographic area.

The street-level road traffic estimates provide the number of vehicles that pass 'count points’ on Britain's roads. They are estimated for each link of Great Britain's major road network, and for a sample of locations on Great Britain’s minor road network. When this data is put together they can be used to estimate the:

**Average annual daily flow**: the number of vehicles that travel past (in both directions) the location on an average day of  the year

**Average annual daily flow by direction**: the number of vehicles that travel past the location on an average day of the year, by direction of travel

'Raw' counts of the data are also provided which gives the number of vehicles that travelled past the count point location on the given day of the count, by direction of travel, for each hour 7am to 7pm.

For more information on the methodology of how road traffic data is collected refer to the DfT's [guidance](https://roadtraffic.dft.gov.uk/about).

## Usage
```r 
trafficr::fetch_traffic_constituency(constituency = NA, year = NA, direction = FALSE, raw = FALSE)
```
Fetches the average annual daily flow of road raffic recorded on all count points within a given GB Parliamentary constituency since the year 2000. Results are returned as a tibble. 

- constituency: A character string of the GB Parliamentary constituency / constituencies of interest written within a pair of single or double qoutes.
- year: A numeric indicating which year of data is needed. Year cannot be smaller than 2000.
- direction: A boolean which if TRUE shows the average annual daily flow of road traffic by direction of travel. It is set FALSE by default.
- raw: A boolean which if TRUE shows the actual manual counts taken at count point locations. Raw counts are collected by trained enumerators and are used to feed into calculating the average daily flow estimates. It is set to FALSE by default.

The constituency which a count point is located is not described in the API. The trafficr package uses the longitude/latitude of count points and allocates them to a constituency based on current boundaries.

```r
trafficr::fetch_traffic_authority(authority = NA, year = NA, direction = FALSE, raw = FALSE)
```
Fetches the average annual daily flow of road raffic recorded on all count points within a given GB local authority since the year 2000. Results are returned as a tibble.

- authority: A character string of the GB local authority / authorities of interest written within a pair of single or double qoutes.
- year: A numeric indicating which year of data is needed. Year cannot be smaller than 2000.
- direction: A boolean which if TRUE shows the average annual daily flow of road traffic by direction of travel. It is set FALSE by default.
- raw: A boolean which if TRUE shows the actual manual counts taken at count point locations. Raw counts are collected by trained enumerators and are used to feed into calculating the average daily flow estimates. It is set to FALSE by default.

```r
trafficr::fetch_traffic_region(region = NA, year = NA, direction = FALSE, raw = FALSE)
```
Fetches the average annual daily flow of road raffic recorded on all count points within a given GB region since the year 2000. Results are returned as a tibble.

- region: A character string of the GB region / regions of interest written within a pair of single or double qoutes.
- year: A numeric indicating which year of data is needed. Year cannot be smaller than 2000.
- direction: A boolean which if TRUE shows the average annual daily flow of road traffic by direction of travel. It is set FALSE by default.
- raw: A boolean which if TRUE shows the actual manual counts taken at count point locations. Raw counts are collected by trained enumerators and are used to feed into calculating the average daily flow estimates. It is set to FALSE by default.

```r
trafficr::fetch_traffic_all(direction = FALSE)
```
Fetches the average annual daily flow of road raffic recorded on all count points within Great Britain since the year 2000. Results are returned as a tibble.

- direction: A boolean which if TRUE shows the average annual daily flow of road traffic by direction of travel. It is set FALSE by default.

```r
trafficr::fetch_traffic_region_historic()
```
Fetches the annual total volume of road traffic across each GB region since 1993. Results are returned as a tibble.

Data is downloaded from a seperate CSV file available on the same site as the API.

```r
trafficr::fetch_traffic_authority_historic()
```
Fetches the annual total volume of road traffic across each GB local authority 1993. Results are returned as a tibble.

Data is downloaded from a seperate CSV file available on the same site as the API.

## Examples

```r
fetch_traffic_constituency(constituency = "St Ives")
fetch_traffic_constituency(constituency = c("St Ives", "Ashford"), year = 2000)
fetch_traffic_constituency(constituency = "St Ives", year = 2000:2005)
fetch_traffic_constituency(constituency = "St Ives", year = c(2000, 2010, 2018))
fetch_traffic_constituency(constituency = "St Ives", direction = TRUE)
fetch_traffic_constituency(constituency = "St Ives", year = 2000, raw = TRUE)

fetch_traffic_authority(authority = "Swansea")
fetch_traffic_authority(authority = c("Swansea", "Lambeth"), year = 2000)
fetch_traffic_authority(authority = "Swansea", year = 2000:2005)
fetch_traffic_authority(authority = "Swansea", year = c(2000, 2010, 2018))
fetch_traffic_authority(authority = "Swansea", direction = TRUE)
fetch_traffic_authority(authority = "Swansea", year = 2000, raw = TRUE)

fetch_traffic_region(region = "London")
fetch_traffic_region(region = c("London", "South West"), year = 2000)
fetch_traffic_region(region = "London", year = 2000:2005)
fetch_traffic_region(region = "London", year = c(2000, 2010, 2018))
fetch_traffic_region(region = "London", direction = TRUE)
fetch_traffic_region(region = "London", year = 2000, raw = TRUE)

fetch_traffic_all(direction = TRUE)
```

## Testing
The DfT Road Traffic Open Data API is currently in Beta. As the API may change I have decided not to do any formal unit testing. You should satisfy yourself that the functions behave in the way that you expect if you wish to use this package for research purposes.

## Installation
Install from GitHub using devtools.
```r
install.packages("devtools")
devtools::install_github("dempseynoel/trafficr")
```
