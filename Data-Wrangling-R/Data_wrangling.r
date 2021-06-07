# #### Data Wrangling in R ####
# #### PART 1: WELCOME TO R STUDIO ####
# This is the interface you are going to get used to
# This is a comment and not part of a code, use '#' for a comment, or keyboard shortcut 'shift+ctrl+c'

# THIS IS A LEVEL 1 HEADER #################################

## This Is a Level 2 Header ================================

### This is a level 3 header. ------------------------------

# You can change the visualisation by going on Tools>Global Options

# #### Basic Operations ####

# ==== Calculations ====
1+1 # Use 'ctrl+Enter' to run the code on the selected line
8*5
11/6
# The output of the calculations should appear in the Console below

## ==== Creating sequences With Functions ====
1:250 #Print numbers between 1 and 250 across several lines
#To Clear the console press ctrl+l
100:1 #Print numbers from 100 to 1
seq(10)#Print numbers from 1 to 10
seq(30, 0, by = -3)#Print numbers from 30 to 0 every 3
# You can use any variation of numbers/limits in the seq() function

# ==== Print ====
print('Hello World!') #Prints 'Hello World' in the console basically a string variable
print(1+1)
print('1+1')

# ==== Variables ====
x <- 1:5 # Put the numbers between 1-5 in the variable x
x # Displays the values we have set in x
Y <- 1+1
Y
y <- 5*5
y

# 'Alt+-' shortcut for <- 
# R is case sensitive, 'y' is not the same as 'Y'

y <- c(6,7,8,9,10) #puts numbers between 6-10 in y. Note, this will replace y as 5*5
y
# Assign the same value to multiple vectors
a <- b <- c <- 3

# ---- Variable Calculations ----
x+y #sum the x sequence plus the y sequence
x*2 #multiply for 2 each number in x

# To remove variables from the environment
rm(x) # Remove an object 'x'
rm (a, b) # Remove multiple variables
rm (list = ls()) # Remove all

# #### Packages ####
# list of packages available by subject
browseURL("https://cran.r-project.org/web/views/")

# list of packages available by name
browseURL("https://cran.r-project.org/web/packages/available_packages_by_name.html")

library() # List the available packages
search() # List the mounted packages

## ==== Install Packages ====
# you can use: tools>Install packages
# or directly
install.packages("ggplot2")
install.packages("tidyverse") # Note that ggplot2 is included in tidyverse
?install.packages

## ==== Mount packages ====
library(ggplot2)
library(tidyverse)
# to get info on the packages and browse available examples
browseVignettes(package = "ggplot2" )
browseVignettes() # this would open all available vignettes of all installed packages in your browser

update.packages() # Updates packages, running install.packages("ggplot2") will also update the specific ggplot2 package

# ==== To unload packages ====
# unflag or reboot (everytime you close the system the non default packages get unloaded)
detach ("package:tidyverse", unload = TRUE)

#### PART 2: CLASSES OF DATA IN R ####
library("tidyverse")

# ==== Vector ====
# One dimensional collection of data
y <- c(6,7,8,9,10)
is.vector(y)

x <- c("b","d","a","f","h")
is.vector(x)

# ==== Matrix ====
# Bi-dimensional collection of data

m1 <- matrix(c(T, T, F, F, T, F), nrow = 2)
m1

m2 <- matrix(c("a", "b", 
               "c", "d"), 
             nrow = 2,
             byrow = T)
m2

# A matrix has data all of the same type

m3 <- matrix(c(1, "b", 
               "c", "d"), 
             nrow = 2,
             byrow = F)
m3

# ==== Array ====
# Multidimentional collection of data 
# Give data, then dimensions (rows, columns, tables)
a1 <- array(c(1:24), c(4, 3, 2))
a1

# ==== Data Frame ====

# Can combine vectors of the same length
# different type variables (similar to a table in spreadsheet)
Numeric   <- c(1, 2, 3)
Character <- c("a", "b", "c")
Logical   <- c(T, F, T)

df1 <- cbind(Numeric, Character, Logical)
df1  # Coerces all values to most basic data type

df2 <- as.data.frame(cbind(Numeric, Character, Logical))
df2  # Makes a data frame with three different data types

# Clear Workspace
rm(list = ls())
cat("\014")  # shortcut 'ctrl+l'

# ==== Default Datasets ====

# Load base packages manually
library(datasets)  # For example datasets
?datasets
library(help = "datasets")

# iris data
?iris
iris
head(iris)

# UCBAdmissions
?UCBAdmissions
UCBAdmissions

# viewing dataframes as tables

tibble(iris)

iris_table <- tibble(iris)
iris_table

# #### PART 3: IMPORTING AND MANIPULATING DATA ####

# In order to work with your own data, you will need to import it into R
library(tidyverse)
read_csv("Data/Election_Results_Basic.csv") # The read_csv() function in 'tidyverse' is the easiest way to do this

Elec <- read_csv("Data/Election_Results_Basic.csv") # Rather than just seeing a single output, you can assign the data to a variable

View(Elec) # To view the dataframe, or click on the object in the global environment

Data <- read_csv("Data/Election_data.csv")

# Finding Specific Data

Elec[,3] # Select column
Elec[5,] # Select row
Elec[431,1] # Select cell

Elec[,'result'] # The name of columns can also be used
as_tibble(Elec$result) # Viewing as a table makes it easier to visualise, though removing as_tibble() will still show the data

# Extracting Specific Data

Row_431 <- Elec[431,]
Scotland_Data <- subset(Data, Data$country=='Scotland')

# Change data class

class(Elec$result)
Elec$result <- as_factor(Elec$result)
is.factor(Elec$result)

# ==== Tidying Data ====
# To calculate the winning party in each constituency, we can select the column with the largest vote share

Data$first_party <- colnames(Data[,8:20])[max.col(Data[,8:20], ties.method = "first")]


# Or to calulate voter turnout as a percentage, we can compare total votes cast against the electorate

Data$turnout <- ((Data$valid_votes+Data$invalid_votes)/Data$electorate)*100

# Now we can combine these new data with our original Election Results dataframe using merge

Elec <- Elec %>% mutate(constituency_name = toupper(constituency_name)) # The shared columns are case sensitive
Merged_elec <- merge(Elec[,c(1,3)], Data[,c(1,3,22,23)], by.x="constituency_name", by.y="const")

# We can rearange the order of the columns to keep it tidier

Merged_elec <- Merged_elec[,c(1,3,4,5,2)]
Merged_elec[,1] <- str_to_title(Merged_elec[,1])

# Rows can be arranged to convey the highest or lowest value of certain columns
Merged_elec %>% arrange(turnout) # Using arranged in dplyr (part of tidyverse package)
Merged_elec %>% arrange(desc(turnout)) # Or from highest to lowest (arrange(Merged_elec, -turnout)) will produce the same result

# Create a new variable and extract the mean turnout for each country in the UK
Elec_Turnout_country <- Merged_elec[,c(1,2,4)] %>%
  arrange(desc(turnout)) # Create a new variable

Elec_Turnout_country <- Elec_turnout[,2:3] %>% 
  group_by(country) %>%
  summarize_each(funs(mean)) %>%
  arrange(desc(turnout))

Breakout<-  Data  %>% 
  group_by(country, region) %>% 
  summarize(Number = n(), mean= round(mean(valid_votes),2))%>%
  arrange(country, desc(mean))


#### END ####