##==============================================================================
##Using_RGCAM_PP.R
## This Script uses the rgcam toolbox to post process raw GCAM model output to 
## create plot maps, time series data and extract tables to be used for comparison,
## data analysis and/or publications
## Output: Maps and Time Series plots and data tables
## Please contact Sitara Baboolal (sitara.d.baboolal@dartmouth.com) regarding 
## questions about this script and its uses.

## this script uses the RGCAM toolbox by JGCRI (https://github.com/JGCRI/rgcam) 
## to read raw GCAM output (.basex) files
##==============================================================================
## Copyright 2022 Sitara Baboolal
## This file is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This file is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this file.  If not, see <http://www.gnu.org/licenses/>.
##==============================================================================
#
# before running this script please see requirements.txt to ensure you have all 
# necessary packages are installed
#

## Load libraries
library(devtools)
library(rgcam)
library(rmap)
#library(gcammaptools)
library(dplyr)
#library(tidyr)
library(ggplot2)
library(stringr)

# Clear away any existing variables or figures.  
rm(list = ls())
graphics.off()

# Set paths and generate tables !!NEW USER EDIT!! ----------------------------------
#Check working directory
print(paste0("Current working directory is - ",getwd()))

#Set working directory
setwd("~/Desktop/GCAM_Local_PostPross/Post_Processing") 

#Define directories (Paths to GCAM outputs and query files ) 
dbPath <- ("output") #path to database
dbFile <- paste0("database_basexdb") #name of database - GCAM output
scenario <- paste0("Reference") #name of scenario
queryFile<- paste0(dbPath, "/queries/sample_queries.xml") #Query file full path and name

#IF Queries already done and data tables already made
#q_tables<- loadProject("project_files/q_tables.proj")

# IF not then generate query tables
conn2 <- localDBConn(paste0(dbPath),paste0(dbFile))
q_tables_r <- addScenario(conn2, "q_tables_r.proj", 'Reference', paste0(queryFile))
q_tables = q_tables_r


# Mapping Regional Data ---------------------------------------------------
######################### FUNCTION ########################################
plot.multimap = function(data = q_tables, yrs = c("2025", "2050", "2075", "2100"),
                         param = 'Population by region', num.of.col = 2,
                         scen = 'Reference', showLegend = TRUE, saveMap = TRUE){
  
  #################
  # data = q_tables
  # yrs = seq(2025,2100,by=25)
  # param = 'Population by region'
  # num.of.col = 2
  # scen = 'Reference'
  # showLegend = TRUE
  # saveMap = TRUE
  #################
  
  # Separate Table by years and query of interest. Output will be a list of each year
  # getQuery(q_tables, 'Population by region', 'Reference') %>% 
  #   filter(year == paste0("2025"))->new_table_2025
  new_table = lapply(yrs, function(yr){q_tables[[scen]][[param]] %>% filter(year == yr)})
  
  # Combine the lists into one table, extract the unit, and subset the columns
  data_tab = do.call(rbind.data.frame, new_table)
  units = data_tab$Units[1]
  data_tot = select(data_tab, c(region, year, value))
  
  rmap::map(data = data_tot,
            underLayer = rmap::mapGCAMReg32,
            subRegion ="region",
            ncol=2,
            labelSize = 3,
            labelColor = "red",
            labelFill = "white",
            labelAlpha = 0.8,
            labelBorderSize = 0.1,
            legendShow = showLegend,
            legendTitle = paste0(param, " (", str_to_title(units), ")"), 
            legendType = "continuous",
            background = "white",
            save = saveMap,
            nameAppend = paste0("_", gsub(" ", "_", param), yrs[1], "_", yrs[length(yrs)], "by", diff(yrs)[1]))
}
######################### END FUNCTION #####################################

##USER EDIT##
##################
# yrs = seq(2025,2100,by=25)
# param = 'Population by region'
# num.of.col = 2
# scen = 'Reference'
####################
#Examples of maps

# Run the plot.multimap function for 2025 to 2100 for every 25 years
plot.multimap(data = q_tables, yrs = seq(2025,2100,by=25),
              param = 'regional biomass consumption', num.of.col = 2,
              scen = 'Reference', showLegend = TRUE, saveMap = TRUE)

# Run the plot.multimap function for 2020 to 2100 for every 10 years
plot.multimap(data = q_tables, yrs = seq(2020,2100,by=10),
              param = 'Population by region', num.of.col = 2,
              scen = 'Reference', showLegend = TRUE, saveMap = TRUE)

# Individual maps
plot.multimap(data = q_tables, yrs = 2025,
              param = 'Population by region', num.of.col = 1,
              scen = 'Reference', showLegend = TRUE, saveMap = TRUE)


# CO2 emissions by sector editing -----------------------------------------------------------
CO2sector = q_tables[["Reference"]][["CO2 emissions by sector"]]
colnames(CO2sector)[colnames(CO2sector) == 'sector'] <- "subsector"
write.csv(CO2sector,"CO2 emissions by sector.csv", row.names = FALSE)

# Read in the subsector/ sector lookup table
aggCO2sectors = read.csv("../output/queries/aggregatedCO2sectors.csv", header=TRUE)

# Use aggCO2sectors as lookup table to map the sectors to the subsectors
# Create empty column
CO2sector$sector = NA
for(i in 1:length(aggCO2sectors$sector)){
  CO2sector$sector[CO2sector$subsector == aggCO2sectors$subsector[i]] = aggCO2sectors$sector[i]
}

# Are there any missing subsectors? If so rename  the sector unknown
unique(CO2sector$subsector[which(is.na(CO2sector$sector))])
CO2sector$sector[which(is.na(CO2sector$sector))] = "unknown"

# Separate the CO2 data by sector
sectors = unique(CO2sector$sector)
bysector <- lapply(sectors, function(X){CO2sector[which(CO2sector$sector == X), ]})
names(bysector) = sectors

#CO2 Emission by Sector Tables
indus = (bysector[["industry"]])
build = (bysector[["building"]])
trans = (bysector[["transportation"]])
elec = (bysector[["electricity"]])

##Total global
# indus %>%
#   group_by(subsector, region, year, value)%>%
#   mutate(value=sum(value)) %>%
#   ungroup() %>%
#   dplyr::select(subsector, region, year, value) %>%
#   distinct()->indus
# 
# ######################### FUNCTION ########################################
# # Adds a Global region which is the sum of all the regions in d
# add_global_sum <- function(d) {
#   names_keep <- names(d)[ !(names(d) %in% c("region", "value")) ]
#   agg_formula <- as.formula(paste("value ~", paste(names_keep, collapse=" + ")))
#   d.global <- aggregate(agg_formula, d, FUN=sum)
#   d.global$region <- "Global"
#   d.global <- d.global[, names(d)]
#   d <- rbind(d, d.global)
#   return(d)
# }
# ######################### END FUNCTION #####################################
# indus <- add_global_sum(indus)


#Plotting aggregated subsets time series for CO2 by sector and region
##########stacked area chart##################

## All Sub sectors per region
dat=getQuery(q_tables, 'CO2 emissions by sector', 'Reference') %>% 
  filter(region =="Africa_Eastern")
ggplot(dat, aes(x=year, y=value, color=sector)) + 
  geom_line()+
  ggtitle("CO2 emissions by sector - Africa Eastern") +
  xlab("Year") + ylab("Co2 Emission (MtC)")+
  guides(color=guide_legend(title="CO2 Emissions Subsectors"))+
  theme(legend.key.size = unit(.5, 'cm'), #change legend key size
        legend.key.height = unit(.5, 'cm'), #change legend key height
        legend.key.width = unit(.5, 'cm'), #change legend key width
        legend.title = element_text(size=10), #change legend title font size
        legend.text = element_text(size=5)) #change legend text font size

ggsave("CO2 emissions by Subsectors - Africa Eastern.png",
       device = NULL,
       path = "outputs/TimeSeries",
       scale = 1,
       width = 20,
       height = 10,
       units = "cm",
       dpi = 300,
       limitsize = TRUE,
       bg = NULL)

## Sub sectors Separated by Sectors per region
ggplot(indus%>% filter(region=="Africa_Eastern") , aes(x=year, y=value, color=subsector)) + 
  geom_line()+
  ggtitle("CO2 emissions for Industry Sector - Africa Eastern") +
  xlab("Year") + ylab("Co2 Emission (MtC)")+
  guides(color=guide_legend(title="Subsectors in Industry Sector"))+
  theme(legend.key.size = unit(.5, 'cm'), #change legend key size
        legend.key.height = unit(.5, 'cm'), #change legend key height
        legend.key.width = unit(.5, 'cm'), #change legend key width
        legend.title = element_text(size=10), #change legend title font size
        legend.text = element_text(size=5)) #change legend text font size
ggsave("CO2 emissions for Industry Sector - Africa Eastern.png",
       device = NULL,
       path = "outputs/TimeSeries",
       scale = 1,
       width = 20,
       height = 10,
       units = "cm",
       dpi = 300,
       limitsize = TRUE,
       bg = NULL)
