### crosswalk quickstart guide ####
# EmmaLi Tsai
# Feb 14th, 2025
#
################################################################################
# workspace set-up
################################################################################
# functions for pulling in SABs & census variable sheet
library(googlesheets4)
library(aws.s3)
# function dependencies:
library(tidyverse)
library(sf)
library(tidycensus)

# enable caching for the census
options(tigris_use_cache = TRUE)

# reading in function
source("./functions/state_sab_crosswalk_refactored.R")

################################################################################
# reading in EPA's SABs & our crosswalked data
################################################################################
file_loc <- tempfile()
download.file("https://tech-team-data.s3.us-east-1.amazonaws.com/service_area_boundaries/epa-sabs/epic-epa-sabs-public_dec_24.zip",
              destfile = paste0(file_loc, ".zip"))
unzip(zipfile = paste0(file_loc, ".zip"), exdir = file_loc) 
file.remove(paste0(file_loc, ".zip"))

# read EPA SABs from the temporary file location:
epa_sabs <- st_read(paste0(file_loc, "/epic-epa-sabs-public/epa-sabs.geojson"))
# read our crosswalk data from the temporary file location: 
xwalk_data <- read.csv(paste0(file_loc, "/epic-epa-sabs-public/epa-sabs-crosswalk-acs2021.csv"))

# unlink! 
unlink(file_loc)


# if you want to combine our xwalk with the EPA SABS: 
epa_xwalk <- merge(epa_sabs, xwalk_data, by = "pwsid")

################################################################################
# using our crosswalk function  
################################################################################
# reading in your census vars and calculations from a google sheet
gs4_deauth()
gs4_auth()
# this is our public census variable spreadsheet, but you should link the one 
# with your own census variables 
URL <- "https://docs.google.com/spreadsheets/d/1UvFjxOm1Q06ZEDXr98Pt0uvLFabsGA8IT8eEJrQN9pg/edit?gid=0#gid=0"
census_var_sheet <- read_sheet(URL, sheet = "census_var_table") %>%
  janitor::clean_names() 

# grabbing our population served count, which is used for tier 2 data 
epa_sabs_xwalk_function <- epa_xwalk %>% 
  select(pwsid, population_served_count)

# runnin'
my_xwalk <- sab_crosswalk(epa_sabs_xwalk_function, "2021", census_var_sheet)
