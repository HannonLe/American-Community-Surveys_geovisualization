##### ACS project #####

if(!require(data.table)) install.packages("data.table")
if(!require(dplyr)) install.packages("dplyr")

library(data.table)
library(dplyr)

# we use ACS 2014 Household data
ss14husa <- fread("data/ss14husa.csv")
ss14husb <- fread("data/ss14husb.csv")
hus14 <- rbind(ss14husa, ss14husb)
rm(ss14husa,ss14husb)
hus14_origin <- hus14 # make a copy of the original version of data in the work space

names(hus14)
str(hus14)

# Now discovery & brain storm time!
# the data is too big, take 10000 random sample
set.seed(235)
hus14_sp <- hus14[sort(sample(1:nrow(hus14), 100, replace = F)),]

# PUMA code list:
# Public use microdata area code (PUMA) based on 2010 Census definition 00100..70301 .Public use microdata area codes
PUMA_code <- read.csv("data/2010_PUMA_Names.txt")

# select variable of our interest
names(hus14)
str(hus14)
head(select(hus14_sp,
            PUMA,ST,WGTP,NP,TYPE,ACCESS,ACR,BATH,BDSP))

### PROGRESS: looking at the document page 5/138




