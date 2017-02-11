# choropleths -------------------------------------------------------------
library(tidyverse)
library(choroplethr)
library(choroplethrMaps)

# select just 2013 and rename for choropleth functions
vet_2013 <- vet_pop_county %>% select("region" = FIPS, "value" = `2013`)
vet_2014 <- vet_pop_county %>% select("region" = FIPS, "value" = `2014`)
vet_2015 <- vet_pop_county %>% select("region" = FIPS, "value" = `2015`)
vet_2016 <- vet_pop_county %>% select("region" = FIPS, "value" = `2016`)




# choropleth of various years
county_choropleth(vet_2013)
county_choropleth(vet_2014)
county_choropleth(vet_2015)
county_choropleth(vet_2016)




county_choropleth(vet_pop_change)

vet_pop_gain_top25 <- vet_pop_change %>% 
    left_join(vet_pop_county, by = c("region" = "FIPS")) %>% 
    select(`County, St`, value) %>% 
    dplyr::arrange(desc(value)) %>% 
    dplyr::top_n(25) %>% 
    dplyr::arrange(value) %>% 
    mutate(county = factor(`County, St`, levels = .$`County, St`)) %>% 
    select(county, value)


ggplot(vet_pop_gain_top25) + geom_point(aes(value, county)) + scale_x_continuous(labels = scales::percent)


