library(tidyverse)

head(df_wq)

df_wq[1,2]

df_wq[2,1]

df_wq[1,]

df_wq[,1]

df_wq[,2:4]

df_wq[1:4,2:4]

df_wq[,c(2,4)]

df_wq[,c(2,6)]

df_wq['DissAmmonia'] %>% head() %>% round(1)

round(head(df_wq['DissAmmonia']),1)

# %>% # pipe operator

df_wq['DissAmmonia'] %>% head()

df_wq$DissAmmonia

str(df_wq['DissAmmonia'])

str(df_wq$DissAmmonia) # usually we want to use the dollar sign

df_wq$`DissAmmonia` # use backticks if your column name includes spaces in it


df_wq %>% dplyr::select(Station:Pheophytin) %>% head()

df_wq %>% select(c(Station,Pheophytin)) %>% head()

df_chlapheo <- df_wq %>% select(Station:Pheophytin)

glimpse(df_chlapheo)

# checking error

df_wq %>% select(c(Station,Pheophytin)) %>% head()

# subset by rows

unique(df_wq$Station)

df_wq$Station %>% unique()

# filter function!

df_p8 <- df_wq %>% filter(Station == 'P8')

head(df_p8)

unique(df_p8$Station)


5 == 5

5 == 6


# == and !=

df_wq %>% filter(Station == 'P8')

df_d7 <- df_wq %>% filter(Station != 'P8') # ! means negate

unique(df_d7$Station)

# & and or

# want P8 AND the date 2020-01-16

df_wq %>% filter(Station == 'P8' & Date == '2020-01-16')

df_wq %>% filter(Station == 'P8' | Date == '2020-01-16')


# want to select Date is 2020-01-16 OR 2020-01-22 (or 01/16/2020 OR 01/22/2020)

df_test <- df_wq %>% filter(Station == 'P8' & Date == '2020-01-16')

df_test

df_test <- 5

df_test

class(df_wq)

# Reading in Data

df_wq <- read.csv('data/WQ_P8D7.csv')

str(df_wq)
class(df_wq)

df_wq <- read_csv('data/WQ_P8D7.csv')


str(df_wq)
class(df_wq)

class(df_wq)

df_wq <- df_wq %>% as_tibble()

class(df_wq)

"hi i'm perry" == "hi im perry"

'hi im perry'

# all chla > 2

# >: greater than, <: less than

df_wq %>% filter(Chla >= 6)

df_wq %>% filter(Chla <= 6)

# ! is the negate operator -- works on any logical statement!

df_wq %>% filter(!(Chla <= 6))

df_wq %>% filter(Chla >= 5 & Chla <= 6)


# in operator

vec_dates <- c('2020-02-14','2020-03-06','2020-06-11','2021-03-05','2021-04-05') # 2/14/2020

df_wq %>% filter(Date %in% vec_dates)

str(df_wq$Date[1])

# selecting data where Chla is either less than 5 or greater than 6?

df_wq %>% filter(Chla <= 5 | Chla >= 6)

df_wq %>% filter(Chla >= 5 & Chla <= 6)


df_wq %>%
  filter(Chla >= 5 & Chla <= 6) %>%
  select(Station:Chla)


# change our date type

df_test <- df_wq %>% mutate(Date = as.Date(Date, format = '%Y-%m-%d'))

# 1/26/2020

'%d/%m/%Y'

glimpse(df_wq)


# subset NA ---------------------------------------------------------------

typeof(NA)

typeof("NA")

unique(df_wq$DON)

any(is.na(df_wq$DON))

is.na(df_wq$DON) %>% any()

df_wq %>%
  filter(is.na(df_wq$DON)) %>%
  select(Station, Date, DON)

df_wq %>%
  filter(!is.na(df_wq$DON)) %>%
  select(Station, Date, DON)



# mutate data -------------------------------------------------------------

glimpse(df_wq)

df_wq %>%
  mutate(Lab = 'BSA') %>%
  glimpse()

df_wq %>%
  mutate(ChlPheo = Chla + Pheophytin) %>%
  select(Station, Date, Chla, Pheophytin, ChlPheo) %>%
  head()

df_wq %>%
  mutate(StatDate = paste(Station, Date, sep = '    ')) %>%
  select(Station, Date, StatDate) %>%
  head() %>%
  relocate(StatDate, .before = Station)

df_wq %>%
  mutate(Chla = Chla+20)

df_wq

df_test <- df_wq %>%
  mutate(Chla = Chla+20)

df_test

str(df_wq)

df_test <- df_wq %>%
  mutate(Chla = as.numeric(Chla),
         Station = as.factor(Station)) %>%
  select(Station)

str(df_test)

df_wq %>% select(Station) %>% str()





df_wq %>%
  mutate(StatDate = paste(Station, Date, sep = '    ')) %>%
  select(Station, Date, StatDate) %>%
  head() %>%
  relocate(StatDate, .before = Station)



df_test <- df_wq %>%
  mutate('New Col' = paste(Station,Date, sep = '____')) %>%
  select(Station, Date, 'New Col')

df_test %>% select(-'New Col')

"2021"

remove(df_d7)
remove(df_p8)


df_wq <- read_csv('data/WQ_P8D7.csv')

df_editdates <- read_csv('data/WQ_P8D7_editdates.csv')
