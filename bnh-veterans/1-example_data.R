#' data loading and exploration script for Brunch and Hack - Supporting Our Veterans
#' 
#' data source: http://bit.ly/2ltReh6
#' 
#' 
#' Overall, the number of Veterans decreased by 931,189 from 2013 to 2016.


# package and data loading ------------------------------------------------

library(tidyverse)

# load example data set from http://bit.ly/2ltReh6 
vet_pop_county <- read_csv("bnh-veterans/vet_pop_county.csv") %>%
    filter(is.na(FIPS) == FALSE)
# calculate the percent change in vets per county and plot that
vet_pop_change <- vet_pop_county %>% mutate(percent_change = (`2016` - `2013`)/`2013`) %>% 
    select("region" = FIPS, "value" = percent_change)

# summarize by state ------------------------------------------------------
vet_pop_state <- vet_pop_county %>% separate(`County, St`, c("county", "state"), sep = ",") %>%
    group_by(state) %>% mutate(percent_change = (`2016` - `2013`)/`2013`) %>% 
    select(county, state, percent_change) %>% 
    summarize(percent_change = mean(percent_change))

# fix the NA resulting from Foreign Countries not having an ","
vet_pop_state$state[54] <- "Foreign Countries"


# summarize 