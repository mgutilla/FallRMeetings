##########################################################################
## The main lecture content
##########################################################################

## Check your working directory now:
getwd()

## If you're in the right directory, you should see our data file 
## if you list the files in the directory:
list.files()

## Basic approach

## Now we can read the data into R. It's a very basic command:
ebola <- read.table("country_timeseries.csv", sep = ",",
                    header = TRUE)

## Check out the beginning of the new object you just made from this data,
## 'ebola'
ebola[1:3, 1:5]

## Learn more about 'read.table' and 'read.fwf' by looking at their help files
?read.table
?read.fwf

## There are a number of functions you can use to check out your data. 
## For example, try:

head(ebola)
tail(ebola)
summary(ebola)
str(ebola)
ebola[1,]

## Now we'll try getting the data straight from from GitHub using tools in the
## RCurl package.

## If you don't have the package yet, you'll need to install it--
## uncomment this command and run it:
#install.packages("RCurl")

## To be able to use the functions in RCurl in your R session, you'll 
## need to call it:
library(RCurl)

## Now all it takes to read the data in is:
github.page <- getURL("https://raw.githubusercontent.com/cmrivers/ebola/master/country_timeseries.csv")
ebola.2 <- read.csv(text = github.page)

## Check out this new object-- you'll see it gives us the exact same object
ebola.2[1:3, 1:5]

##########################################################################
## The challenges
##########################################################################

## Challenge 1

## For the GEOJSON data:
#install.packages("rjson")
library(rjson)
url.ebola.centers <- getURL("https://raw.githubusercontent.com/BrcMapsTeam/Ebola_2014_West_Africa_geojsons/master/Ebola_medical_centres_open_closed_pending.geojson")
ebola.centers <- fromJSON(url.ebola.centers)

## Check out the data you got in
str(ebola.centers)
names(ebola.centers)
names(ebola.centers$features[[1]])
ebola.centers$features[[1]]$geometry
## Now you would need to figure out the structure of this data to figure 
## out how to usefully use it in R... 

## For the Google Docs spreadsheet:
## I could not find a quick way to pull it straight form Google Docs 
## (although I'm thinking there must be a way...),
## so I downloaded the file to my computer as "EbolaCenters.csv"
ebola.centers <- read.csv("EbolaCenters.csv", skip = 12, 
                          header = TRUE, na.strings = "")

## Now check out the data
ebola.centers[1:10, 1:5]
summary(ebola.centers[,1:10])
str(ebola.centers)

## Clean up the column names
colnames(ebola.centers) <- gsub("X.", "", colnames(ebola.centers))
ebola.centers[1:10, 1:5]

## How many centers are in each county? In each region?
table(ebola.centers$country)
table(ebola.centers$adm1)

## Challenge 2

## I have not been able to figure out how to do this yet...

## It looks like the 'ape' package can be used to work with NEXUS data (.nex)
#install.packages("ape")
library(ape)
df <- read.nexus.data(file = "ebolavirus_cds.nex")

## But it seems like our file might be a bit different from what this function
## is looking for ... 
