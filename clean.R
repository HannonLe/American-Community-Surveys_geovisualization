###### clean data #####

library(stringr)
library(dplyr)

# conversion
conversion <- read.csv("data/conversion.csv",stringsAsFactors = F)

d <- conversion[-1,]
d$state <- as.numeric(str_replace(d$state, "0(?=\\d)", ""))
d$TotPopACS <- as.numeric(str_replace(d$TotPopACS, ",", ""))
d <- select(d, state, puma12, Fipco, TotPopACS) %>% arrange(state, puma12) # INFORMATION loss: use the first county column
d <- summarise(group_by(d, Fipco, puma12),state=mean(state),pop=sum(TotPopACS)) %>% arrange(state,puma12)

d2 <- summarise(group_by(d, state, puma12),pop_puma=sum(pop))
d3 <- left_join(d,d2,by=c("state"="state","puma12"="puma12")) %>% mutate(pop_pct=pop/pop_puma) %>% select(Fipco,state,puma12,pop_pct)

write.csv(d3,"data/pop_wgt_fips_in_puma12.csv",row.names = F)
rm(d,d2,d3)
