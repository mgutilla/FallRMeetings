###############
## Slide 2
###############

## If necessary, use setwd() to get to the right directory
ebola <- read.table("country_timeseries.csv", sep = ",",
                    header = TRUE)
ebola[1:3, 1:5]

###############
## Slide 6
###############

## Make some new vectors
x <- c(1, 5, 7, 9, 10)
x

class.names <- c("Taylor", "Maggie", "Mimi", "Brianna", "Jon")
class.names

###############
## Slide 8
###############

## Make a new dataframe
class.data <- data.frame(name = class.names,
                         number = x)
class.data

###############
## Slide 11
###############

## Pull subsets from the class.names vector
class.names[1]
class.names[c(2, 3, 4)] 
class.names[2:4]

###############
## Slide 12
###############

## Pull subsets from the class.data dataframe
class.data[1,1]
class.data[1:3, 1:2]

###############
## Slide 13
###############

## Pull subsets from the class.data dataframe
class.data[1, ]
class.data[ , 1]

###############
## Slide 14
###############

## Pull subsets from the class.data dataframe
class.data[3:4, "number"]
class.data[3:4, c("name", "number")]

###############
## Slide 15
###############

## Pull a column from the class.data dataframe
head(ebola$Cases_Guinea)

###############
## Slide 19
###############

## Try out some functions
head(ebola)
head(ebola, n = 3)
ebola <- read.table("country_timeseries.csv", sep = ",",
                    header = TRUE)

###############
## Slide 22
###############

## Do a basic plot
x <- c(1, 2, 3)
y <- c(4, 5, 6)
plot(x, y)

###############
## Slide 22
###############

## Plot ebola cases in Guinea
plot(ebola$Day, ebola$Cases_Guinea)

###############
## Slide 24
###############

## Plot ebola cases in Guinea with some of the plot options
plot(ebola$Day, ebola$Cases_Guinea, main = "Guinea ebola cases",
     xlab = "Day in ebola data collection", ylab = "# of cases",
     type = "l", lwd = 2, col = "gray")

#####################################################################
## "Try It Yourself" answers
#####################################################################

#######################
## Answers for Slide 16
#######################

## Find out the column names for the dataframe
colnames(ebola)

## Pull out the "Date" column:
ebola$Date
ebola.Date <- ebola$Date # If you wanted to save this column as a 
                         # new vector named "ebola.Date"

## Get the ten most recent US cases
ebola$Cases_UnitedStates[1:10] #or
ebola[1:10, "Cases_UnitedStates"]
## More advanced: If you wanted to get the ten latest non-missing ones, you could 
## ask R to pull out the ten most recent that are non-missing like this:
US.ebola <- subset(ebola, !(is.na(Cases_UnitedStates)))
US.ebola[1:10, "Cases_UnitedStates"]

## Get the twenty earliest death counts in Liberia
nrow(ebola) #Find out how many rows are in the dataset
# For me, this was 94. I just pulled the ebola data today, though, so I may 
# have more observations than you
ebola$Deaths_Liberia[85:94] #or
ebola[85:94, "Deaths_Liberia"]
# A fancier way to do this, where it will still work even if more observations are
# added to the data, is to use the "nrow(ebola)" call directly in your indexing:
ebola[(nrow(ebola) - 9):(nrow(ebola)), "Deaths_Liberia"]
# To convince yourself of why this works, check what you get from:
(nrow(ebola) - 9)
(nrow(ebola))
(nrow(ebola) - 9):(nrow(ebola))

## Get a dataframe of the first five observations of date, cases, and deaths in Mali
ebola[1:5, c("Date", "Cases_Mali", "Deaths_Mali")]
## You can use the same ideas as before if you want to get the first five non-missing
## cases
Mali.ebola <- subset(ebola, !(is.na(Cases_Mali)))
Mali.ebola[ , c("Date", "Cases_Mali", "Deaths_Mali")]
## There are only four non-missing observations for Mali, so we don't need to index 1:5


#######################
## Answers for Slide 26
#######################

## Plot deaths in Liberia by day

## Most basic:
plot(ebola$Day, ebola$Deaths_Liberia)

## Try using a line instead
plot(ebola$Day, ebola$Deaths_Liberia, type = "l")

## Make a subset with non-missing data from Liberia
ebola.Liberia <- subset(ebola, !(is.na(Cases_Liberia)) & !(is.na(Deaths_Liberia)),
                        select = c("Date", "Day", "Cases_Liberia", "Deaths_Liberia"))
plot(ebola.Liberia$Day, ebola.Liberia$Cases_Liberia,
     type = "l", col = "gray", lwd = 2)
## Get a little fancier
plot(ebola.Liberia$Day, ebola.Liberia$Cases_Liberia,
     type = "l", col = "gray", lwd = 2,
     xlab = "Day in ebola tracking",
     ylab = "Count", 
     main = "Ebola in Liberia")
## Add a line for deaths in Liberia
lines(ebola.Liberia$Day, ebola.Liberia$Deaths_Liberia)  ## check out the lines function, `?lines`

## Plot the percent mortality in Liberia
perc.mort.Liberia <- ebola.Liberia$Deaths_Liberia / ebola.Liberia$Cases_Liberia
plot(ebola.Liberia$Day, perc.mort.Liberia, type = "l",
     xlab = "Day in ebola tracking", ylab = "% mortality",
     main = "Ebola fatality rate in Liberia")

## More advanced: You can also plot by date, but you need to change the class 
## of the "Date" column in ebola.Liberia to the date class
class(ebola.Liberia$Date)
## You can change the class using the "as." family of functions
## First, change it to a character:
ebola.Liberia$Date <- as.character(ebola.Liberia$Date)
## Now, you can change it to a date:
ebola.Liberia$Date <- as.Date(ebola.Liberia$Date, format = "%m/%d/%Y")
## The 'format' option tells R what format the date is in, using '%m' for month,
## '%d' for day in the month, and '%Y' for 4-digit year. Because R lets you 
## tell it the format of a date, it can bring in dates in a lot of different formats
## (e.g., "Jan 1, 2014", "01-Dec-99")

## Once R knows that ebola$Date is a date, you can plot with it:
plot(ebola.Liberia$Date, perc.mort.Liberia, type = "l",
     xlab = "Date, 2014", ylab = "% mortality",
     main = "Ebola fatality rate in Liberia")

## More advanced: You can also use functions in the 'ggplot2' package to create
## very nice plots.

## Uncomment this and run if you don't have ggplot2 installed yet
#install.packages('ggplot2')
library(ggplot2)
ggplot(ebola.Liberia, aes(x = Date, y = Deaths_Liberia)) + geom_line() +
        xlab("Date, 2014") + ylab("Death count")

## Just for fun, try out some different ggplot themes

## Uncomment this and run if you don't have ggthemes installed yet
#install.packages('ggthemes', dependencies = TRUE)
library(ggthemes)
p <- ggplot(ebola.Liberia, aes(x = Date, y = Deaths_Liberia)) + geom_line() +
        xlab("Date, 2014") + ylab("Death count") 
p + theme_economist() + scale_colour_economist() ## Looks like graphs in The Economist
p + theme_excel() + scale_colour_excel() ## Looks like Excel
p + theme_solarized() + scale_colour_solarized("blue")
p + theme_tufte() ## Edward Tufte's style
