# load the data first
library(here)
Globalgenderinequality <- read.csv("C:/Users/大豆/CASA/GIS/wk4/DATA4hw/HDR21-22_Statistical_Annex_GII_Table.csv")
GIIdata <- read.csv("C:/Users/大豆/CASA/GIS/wk4/DATA4hw/Composite_indices_complete_time_series.csv")
library(sf)
Worldshape <- st_read("C:/Users/大豆/CASA/GIS/wk4/DATA4hw/World_Countries_(Generalized)/World_Countries__Generalized_.shp")

#select the data from 2010 and 2019
library(dplyr)
GIIdata_2010_19<- GIIdata %>%
  dplyr::select (contains("gii_2010"),
                contains("gii_2019"),
                contains("country"))

#creating new column
Differen_2010_19 <-GIIdata_2010_19 %>%
  mutate(difference=(gii_2010 - gii_2019))%>%
  dplyr::select(difference,
                country)%>%
  
  arrange(desc(difference))

# join the data 
library(janitor)
library(stringr)
giifinalmap <- Worldshape %>% 
  clean_names() %>% 
  left_join(., Differen_2010_19, by = c("country" = "country"))
