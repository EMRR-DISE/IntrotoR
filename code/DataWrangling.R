#let's figure out which dataset we want to use

library(tidyverse)
library(lubridate)

# Battey, M. and S. Perry. 2023. Interagency Ecological Program: Discrete water quality
# monitoring in the Sacramento-San Joaquin Bay-Delta, collected by the Environmental Monitoring Program,
# 1975-2022 ver 10. Environmental Data Initiative.
# https://doi.org/10.6073/pasta/147b9a29bc682b3d94a9c4db7ee30d2c (Accessed 2024-05-13).

WQ = read_csv("https://portal.edirepository.org/nis/dataviewer?packageid=edi.458.10&entityid=cf231071093ac2861893793517db26f3")

WQ2022 = filter(WQ, year(Date) %in% c(2020, 2021, 2022))

unique(WQ2022$Station)

#let's try P8 and D7

WQ_p8d7 = filter(WQ2022, Station %in% c("P8", "D7"))

ggplot(WQ_p8d7, aes(x = Station, y = TKN)) + geom_boxplot()

ggplot(WQ_p8d7, aes(x = Station, y = Chla)) + geom_boxplot()


ggplot(WQ_p8d7, aes(x = Station, y = Secchi)) + geom_boxplot()


ggplot(WQ_p8d7, aes(x = Station, y = SpCndSurface)) + geom_boxplot()

#it might be less intimidating if there were fewer columns.

WQ_p8d7s = select(WQ_p8d7, Station, Date,
                 Chla, Pheophytin, TotAlkalinity, DissAmmonia, DissNitrateNitrite, DOC, TOC,
                 DON, TotPhos, DissOrthophos, TDS, TSS, TKN, Depth, Secchi, Microcystis,
                 SpCndSurface, WTSurface)
#export for later inporting

write.csv(WQ_p8d7s, "data/WQ_P8D7.csv", row.names = F)
