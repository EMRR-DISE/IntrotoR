#let's figure out which dataset we want to use

library(tidyverse)

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
std_cols <- c(
  "Station",
  "Date",
  "Chla",
  "Pheophytin",
  "TotAlkalinity",
  "DissAmmonia",
  "DissNitrateNitrite",
  "DOC",
  "TOC",
  "DON",
  "TotPhos",
  "DissOrthophos",
  "TDS",
  "TSS",
  "TKN",
  "Depth",
  "Secchi",
  "Microcystis",
  "SpCndSurface",
  "WTSurface"
)

WQ_p8d7s = select(WQ_p8d7, any_of(std_cols))
#export for later importing

write.csv(WQ_p8d7s, "data/WQ_P8D7.csv", row.names = F)

# Export data from 2019 for P8 and D7 for bind_rows example
WQ %>%
  filter(year(Date) == 2019, Station %in% c("P8", "D7")) %>%
  select(any_of(std_cols)) %>%
  write_csv("data/WQ_2019.csv")

# Export data from 2019-2022 for C3A for bind_rows exercise
WQ %>%
  filter(year(Date) %in% 2019:2022, Station == "C3A") %>%
  select(any_of(std_cols)) %>%
  write_csv("data/WQ_C3A_2019_2022.csv")

# Export weather observation data from 2019-2022 for P8, D7, and C3A for left_join exercise
WQ %>%
  filter(year(Date) %in% 2019:2022, Station %in% c("P8", "D7", "C3A")) %>%
  select(Station, Date, Weather, AirTemp, WindVelocity) %>%
  write_csv("data/Weather_Obs_P8_D7_C3A_2019_2022.csv")

# Dayflow data from 1997-2023 for left_join example
df_dayflow <- read_csv("https://data.cnra.ca.gov/dataset/06ee2016-b138-47d7-9e85-f46fae674536/resource/21c377fe-53b8-4bd6-9e1f-2025221be095/download/dayflow-results-1997-2023.csv")

# Restrict to Delta Inflow and Outflow from 2019-2023 and export data
df_dayflow %>%
  transmute(Date = mdy(Date), Inflow = TOT, Outflow = OUT) %>%
  filter(year(Date) >= 2019) %>%
  write_csv("data/Dayflow_2019_2023.csv")

