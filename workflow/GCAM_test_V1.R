#title: "Figures and analysis for GCAM output"
#Authors: Sitara Baboolal
#output: Maps and Time Series data

#_______
#before running this script please see requirements.txt to ensure you have all the nessesary packages are installed
#________

# Load libraries
library(devtools)
library(rgcam)
library(rmap)
#library(gcammaptools)
library(dplyr)
library(tidyr)
library(ggplot2)

#Check working directory
print(paste0("Current working directory is - ",getwd()))

#Set working directory
setwd("~/Desktop/GCAM_Local_PostPross/Post_Processing")

#Define constants
year <- 2050 #year to be processed
#These is the range 
prot_constraints <- seq(2025,2100,by=25)#These is the range of years to be processed

#Define directories- 
dbPath <- ("~/Desktop/GCAM_Local_PostPross/output") #path to database
dbFile <- paste0("database_basexdb")
#scenario <- paste0("Reference") #name of scenario
queryFile<- paste0("~/Desktop/GCAM_Local_PostPross/output/queries/queries_CO2EM.xml") #Query file full path and name

#IF Queries already done and data tables already made
#q_tables<- loadProject("project_files/q_tables.proj")

# IF not then generate tables
conn <- localDBConn(paste0(dbPath),paste0(dbFile))
q_tables <- addScenario(conn, "q_tables.proj", 'Reference', paste0(queryFile))

#_______________________________________________________________
#Separate Table by years and query of interest 
getQuery(q_tables, 'CO2 emissions by region', 'Reference') %>% 
  filter(year == paste0("2025"))->new_table_2025
getQuery(q_tables, 'CO2 emissions by region', 'Reference') %>% 
  filter(year == paste0("2050"))->new_table_2050
getQuery(q_tables, 'CO2 emissions by region', 'Reference') %>% 
  filter(year == paste0("2075"))->new_table_2075
getQuery(q_tables, 'CO2 emissions by region', 'Reference') %>% 
  filter(year == paste0("2100"))->new_table_2100

#Single table
#for (i in prot_constraints){
  
#getQuery(get(paste0("tables_",i,"prot")), 'CO2 emissions by region', 'Reference')) %>% 
#   filter(year == paste0(i), ))->new_table
  
#}

#Individual maps
#______________________________________________________________
data25 =select(new_table_2025, c(region, year, value))
mapx <- rmap::map(data = data25,
                  underLayer = rmap::mapGCAMReg32,
                  title='CO2 emissions by region - 2025',
                  subRegion ="region",
                  labelSize = 3,
                  labelColor = "red",
                  labelFill = "white",
                  labelAlpha = 0.8,
                  labelBorderSize = 0.1,
                  legendType = "freescale",
                  legendFixedBreaks=c(10,100,500,1000,1500,2000,3000,4000),
                  background="white",
                  nameAppend = "_CO2_EM_2025")

data50 =select(new_table_2050, c(region, year, value))
mapx <- rmap::map(data = data50,
                  underLayer = rmap::mapGCAMReg32,
                  title='CO2 emissions by region - 2050',
                  subRegion ="region",
                  labelSize = 3,
                  labelColor = "red",
                  labelFill = "white",
                  labelAlpha = 0.8,
                  labelBorderSize = 0.1,
                  legendType = "freescale",
                  legendFixedBreaks=c(10,100,500,1000,1500,2000,3000,4000),
                  background="white",
                  nameAppend = "_CO2_EM_2050")

data75 =select(new_table_2075, c(region, year, value))
mapx <- rmap::map(data = data75,
                  underLayer = rmap::mapGCAMReg32,
                  title='CO2 emissions by region - 2075',
                  subRegion ="region",
                  labelSize = 3,
                  labelColor = "red",
                  labelFill = "white",
                  labelAlpha = 0.8,
                  labelBorderSize = 0.1,
                  legendType = "freescale",
                  legendFixedBreaks=c(10,100,500,1000,1500,2000,3000,4000),
                  background="white",
                  nameAppend = "_CO2_EM_2075")

data100 =select(new_table_2100, c(region, year, value))
mapx <- rmap::map(data = data100,
                  underLayer = rmap::mapGCAMReg32,
                  title='CO2 emissions by region - 2100',
                  subRegion ="region",
                  labelSize = 3,
                  labelColor = "red",
                  labelFill = "white",
                  labelAlpha = 0.8,
                  labelBorderSize = 0.1,
                  legendType = "freescale",
                  legendFixedBreaks=c(10,100,500,1000,1500,2000,3000,4000),
                  background="white",
                  nameAppend = "_CO2_EM_2100")
