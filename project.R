##### ACS project #####

if(!require(data.table)) install.packages("data.table")
if(!require(dplyr)) install.packages("dplyr")
if(!require(maps)) install.packages("maps")
if(!require(leaflet)) install.packages("leaflet")
if(!require(stringr)) install.packages("stringr")
if(!require(choroplethr)) install.packages("choroplethr")
if(!require(choroplethrMaps)) install.packages("choroplethrMaps")

library(data.table)
library(dplyr)
library(maps)
library(leaflet)
library(stringr)
library(choroplethr)
library(choroplethrMaps)

# we use ACS 2014 Household data
ss14husa <- fread("data/ss14husa.csv")
ss14husb <- fread("data/ss14husb.csv")
hus14 <- rbind(ss14husa, ss14husb)
rm(ss14husa,ss14husb)

names(hus14)
str(hus14)


# Now discovery & brain storm time!


# State name and code
state_code <- read.csv("data/statenames.csv")
state_code$name <- tolower(state_code$name)


# select variable of our interest
names(hus14)
str(hus14)
count(hus14, ST) # number of household by state
count(hus14, TYPE) # number of household by type
count(hus14, ACR)
count(hus14, BLD)
count(hus14, RNTP == "")
count(hus14, VALP == "")
count(hus14, VEH)
count(hus14, VACS == 5)
count(hus14, PUMA, ST)

# Variable of interest: column "VACS", option 5 "For seasonal/recreational/occasional use"
# possible relations with household income, number of olds, number of children, etc.(not available)
# possible relations with geographical location

Vacancy <- hus14 %>%
  filter(VACS == 5) %>% # For seasonal/recreational/occasional use
  filter(DIVISION != 0) %>% # exclude Puerto Rico
  filter(TYPE == 1) %>% # exclude GQs, only house units
  select(PUMA,ST,WGTP) # the survey WGTP is assigned according to population

# vacancy on state map

Vacancy_state <- Vacancy %>%
    group_by(ST) %>%
    summarise(sum_wgt=sum(WGTP)) %>%
    inner_join(., state_code,by=c("ST"="code")) %>%
    select(name,sum_wgt)

Vacancy_state$name <- tolower(Vacancy_state$name)
Vacancy_state$sum_wgt <- Vacancy_state$sum_wgt / summarise(group_by(hus14,ST),sum(WGTP))[,2] # percentage of recreational vancant household
Vacancy_state <- as.data.frame(Vacancy_state)
names(Vacancy_state) <- c("region","value")

state_choropleth(Vacancy_state,
                 title="Percentage of seasonal/recreational/occasional use household (by state)",
                 legend="Percentage",
                 num_colors  = 1)

# vacancy on county map

pop_wgt_fips_in_puma12 <- read.csv("data/pop_wgt_fips_in_puma12.csv") # pop percentage of multiple FIPS in each PUMA


Vacancy_county <- Vacancy %>%
    group_by(ST,PUMA) %>%
    summarise(sum_wgt=sum(WGTP)) %>%
    right_join(., distinct(select(hus14,ST,PUMA)), c("ST"="ST","PUMA"="PUMA")) %>%
    arrange(ST,PUMA)
Vacancy_county[is.na(Vacancy_county$sum_wgt),"sum_wgt"] = 0 # PUMAs that does not have VACS = 5 rows

hus14_county <- hus14 %>%
    select(ST,PUMA,WGTP) %>%
    group_by(ST,PUMA) %>%
    summarise(sum_wgt=sum(WGTP)) %>%
    arrange(ST,PUMA)

Vacancy_county <- Vacancy_county %>%
    left_join(pop_wgt_fips_in_puma12,by=c("ST"="state","PUMA"="puma12")) %>%
    mutate(sum_wgt_fips=sum_wgt*pop_pct) %>%
    select(ST,PUMA,Fipco,sum_wgt_fips) %>%
    group_by(Fipco) %>%
    summarise(sum_wgt_fips=sum(sum_wgt_fips))

hus14_county <- hus14_county %>%
    left_join(pop_wgt_fips_in_puma12,by=c("ST"="state","PUMA"="puma12")) %>%
    mutate(sum_wgt_fips=sum_wgt*pop_pct) %>%
    select(ST,PUMA,Fipco,sum_wgt_fips) %>%
    group_by(Fipco) %>%
    summarise(sum_wgt_fips=sum(sum_wgt_fips))


Vacancy_county$sum_wgt_fips <- Vacancy_county$sum_wgt_fips / hus14_county$sum_wgt_fips
rm(hus14_county)

names(Vacancy_county) <- c("region","value")

county_choropleth(Vacancy_county,
                 title="Percentage of seasonal/recreational/occasional use household (by county)",
                 legend="Percentage",
                 num_colors  = 1)

### zoom into specific states
county_choropleth(Vacancy_county,
                  title="Percentage of seasonal/recreational/occasional use household (by county)",
                  legend="Percentage",
                  num_colors  = 1,
                  state_zoom = "idaho")

county_choropleth(Vacancy_county,
                  title="Percentage of seasonal/recreational/occasional use household (by county)",
                  legend="Percentage",
                  num_colors  = 1,
                  state_zoom = "colorado")

county_choropleth(Vacancy_county,
                  title="Percentage of seasonal/recreational/occasional use household (by county)",
                  legend="Percentage",
                  num_colors  = 1,
                  state_zoom = "missouri")