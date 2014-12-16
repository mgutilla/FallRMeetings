###############
## Slide 2
###############

## If necessary, use setwd() to get to the right directory
ebola <- read.table("country_timeseries.csv", sep = ",",
                    header = TRUE)
ebola[1:3, 1:5]

###############
## Slide 3
###############

## Try out the print() function
print(1:3)

## Try out the paste() function
paste("Brooke", "Anderson")
paste("Brooke", "Anderson", sep = ".")

###############
## Slide 4
###############

## Try out more with the paste() function
rankings.name <- c("First", "Second", "Third")
rankings.num <- c(1:3)
paste(rankings.name, "is what we call #", rankings.num)

###############
## Slide 6
###############

## Try out a very basic loop
for(i in 1:3){
        print("For this loop, i is:")
        print(i)
}

###############
## Slide 7
###############

## Another pretty basic loop
for(i in 1:3){
        print(paste("For this loop, i is", i))
}

###############
## Slide 8
###############

## Reminder on indexing
my.family <- c("Reeves", "Brooke", "Cord")
my.family[1]

###############
## Slide 9
###############

## Use indexing in a loop
for(i in 1:3){
        print(my.family[i])
}

###############
## Slide 10
###############

## Try setting i yourself to figure out what a loop's doing
i <- 1
print(my.family[i])

i <- 2
print(my.family[i])

###############
## Slide 13
###############

## Create vectors of countries with ebola data and column names
## for the columns with cases
Country <- c("Guinea", "Liberia", "SierraLeone", "Nigeria",
             "Senegal", "UnitedStates", "Spain", "Mali")
case.colnames <- paste("Cases", Country, sep = "_")
case.colnames

###############
## Slide 14
###############

## Set up a dataframe to use to store answers from your loop
ebola.cases <- data.frame(country = Country,
                          nonmissing.obs = NA)
ebola.cases

###############
## Slide 15
###############

## On each loop run, you want to get the mean of a certain column
## For example, for the first run of the loop, i will equal 1, and you'll
## want to get the mean of the column "Cases_Guinea" from the ebola dataset

## You want to get:
mean(ebola[ , "Cases_Guinea"], na.rm = TRUE)

## You can use indexing to get:
i <- 1
case.colnames[i]

## Then
mean.cases <- mean(ebola[ , case.colnames[i]], na.rm = TRUE)
mean.cases

###############
## Slide 16
###############

## Now you can use indexing to put this value in the dataframe
## you set up, ebola.cases.
head(ebola.cases, 2)

ebola.cases[i, "nonmissing.obs"] <- 1
head(ebola.cases, 2)

###############
## Slide 17
###############

## Put the mean you calculated into the dataframe
ebola.cases[i, "nonmissing.obs"] <- mean.cases
head(ebola.cases, 2)

###############
## Slide 18
###############

## Now put this all together to create a loop
Country <- c("Guinea", "Liberia", "SierraLeone", "Nigeria",
             "Senegal", "UnitedStates", "Spain", "Mali")
case.colnames <- paste("Cases", Country, sep = "_")
ebola.cases <- data.frame(country = Country,
                          nonmissing.obs = NA)

for(i in 1:length(Country)){
        mean.cases <- mean(ebola[ , case.colnames[i]], na.rm = TRUE)
        ebola.cases[i, "nonmissing.obs"] <- mean.cases
}

###############
## Slide 19
###############

## Now check out your dataframe
head(ebola.cases)

#####################################################################
## "Try It Yourself" answers
#####################################################################

#######################
## Answers for Slide 11
#######################

####
## Create a vector of the column names for data on cases in the ebola dataset:
####

## The most basic way:
Country <- c("Guinea", "Liberia", "SierraLeone", "Nigeria",
             "Senegal", "UnitedStates", "Spain", "Mali")
case.colnames <- paste("Cases", Country, sep = "_")

## You could also use regular expressions in R to pull just the 
## column names with "Cases_" in the name:
case.colnames <- grep("Cases_", colnames(ebola), value = TRUE)
## (Regular expressions are a kind of complex but very powerful 
## tool to help you save time and effort. They're also useful in
## other computer programming languages like Python and Perl.)
## Once you've done this, you can use another regular expression
## function, `sub()`, to pull out the country names to create
## the Country vector
Country <- sub("Cases_", "", case.colnames)

####
## Use a loop to print out the names of people in your group
## (I'll use people in my family.)
####

first.names <- c("Reeves", "Brooke", "Cord")
last.names <- rep("Anderson", times = 3)

for(i in 1:length(first.names)){ ## length(first.names) is just how many people are in your group
    print(paste(first.names[i], last.names[i], "is in our group"))    
}
## Note-- this exercise was just to practice simple loops; if you really wanted to
## print this out, you could also just use paste by itself, like:
print(paste(first.names, last.names, "is in our group")) 

####
## Print out 10 dice rolls
####

for(i in 1:10){
        die.roll <- sample(1:6, size = 1)
        print(paste("Die roll #", i, "is:", die.roll))
}
## Again, this exercise is mostly to practice a simple loop. If you
## wanted to get 10 random samples of die rolls, you could also just do:
sample(1:6, size = 10, replace = TRUE)

#######################
## Answers for Slide 20
#######################

####
## Use a loop get the range of each country's number of ebola 
## cases from our data. Put these values in a new dataframe with 
## the columns Country, Min.Cases, and Max.Cases.
####

## Create a vector called Country that lists all of our countries
Country <- c("Guinea", "Liberia", "SierraLeone", "Nigeria",
             "Senegal", "UnitedStates", "Spain", "Mali")

## Create a vector called case.colnames the gives the names of the 
## columns for all countries
case.colnames <- paste("Cases", Country, sep = "_")

## Create a dataframe called Case.Ranges that uses the Country vector 
## as a Country column and then also has columns for Min.Cases and Max.Cases. 
## To start, these will just be full of NAs.
Case.Ranges <- data.frame(country = Country,
                          Min.Cases = NA,
                          Max.Cases = NA)

## You can get the range of a vector using the `range()` function:
range(ebola[ , "Cases_Guinea"], na.rm = TRUE)

## Using indexing with i, you can also get this with
i <- 1
range(ebola[ , case.colnames[i]], na.rm = TRUE)

## Create a loop where i goes from 1 to the length of your Country vector.
## For each loop, use range(ebola, na.rm = TRUE) to get the range of cases for 
## that country. For each loop, use indexing to put this range (it will be two 
## values) in the right places in your Case.Ranges dataframe.
for(i in 1:length(Country)){
        case.range <- range(ebola[ , case.colnames[i]], na.rm = TRUE)
        Case.Ranges[i, c("Min.Cases", "Max.Cases")] <- case.range
}

####
## Use a loop to plot ebola cases by day for each of the countries.
##

Country <- c("Guinea", "Liberia", "SierraLeone", "Nigeria", ## same vector we've created before
             "Senegal", "UnitedStates", "Spain", "Mali")
case.colnames <- paste("Cases", Country, sep = "_")

## Most basic
for(i in 1:length(Country)){
        plot(ebola$Day, ebola[ , case.colnames[i]])
}

## Fancier
for(i in 1:length(Country)){
        plot(ebola$Day, ebola[ , case.colnames[i]],
             main = Country[i], 
             xlab = "Day in ebola tracking",
             ylab = paste("Cases in", Country[i]),
             cex = 1.5, pch = 21, bg = "red")
}

## Fanciest: 
## Put them all on the same graph and save as a pdf
pdf("EbolaCases.pdf", height = 2, width = 12) # This will save this pdf to your working directory
par(mfrow = c(1, length(Country)))
# Create labels for the graphs that have spaces for Sierra Leone 
# and the United States
Country.Labels <- sub("([a-z])([A-Z])", "\\1\\ \\2", Country, perl = TRUE) 
for(i in 1:length(Country)){
        plot(ebola$Day, ebola[ , case.colnames[i]],
             main = Country.Labels[i], 
             xlab = "Day in ebola tracking",
             ylab = paste("Cases in", Country.Labels[i]),
             cex = 0.8, pch = 21, bg = "red",
             ylim = range(ebola[ , case.colnames], na.rm = TRUE)) ## Give them all the same y range
}
dev.off() ## This closes your pdf device and, in essence, finishes up your plot