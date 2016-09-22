##### ACS project #####

ss14husa <- read.csv("data/ss14husa.csv")
save(ss14husa,file="data/dat.Rdata")
rm(ss14husa)
load("data/dat.Rdata")


