############################################################
################### Using Data Sets ########################
############################################################

# Outline and Introduction

# Usually you represent data sets in data frames or matrices.
# First the use of data frames is demonstrated.
# There are several ways to get data, e.g.
# 1. Read one that is stored already on the computer
# 1a. data format that is compatible with R (*.csv)
# 1b. data format from other software like SPSS (*.sav)
# 2. Use one from a specific package
# 3. Create your own ones
# This script illustrates these points and gives you some hints
# about handling data frames: 
# 4. Expand existing data frames
# 5. Save data frames
# 6. Indexing data frames
# 7. Attaching data frames
# In the end there are some remarks 
# on matrices:
# 8. Create matrices
# 9. Work with matrices

############################################################

# 1. Read one that is stored already on the computer
# 1a. data format that is compatible with R (*.csv)

#Step A: set working directory: Path to folder containing data frame
setwd("D:/Dokumente und Einstellungen/Sonja/Desktop/useR/scRipt/data")
      ###adjust path to whatever you have
      #alternative version:
        setwd("D:\\Dokumente und Einstellungen\\Sonja\\Desktop\\useR\\scRipt\\data")
      #do NOT use setwd("D:\Dokumente und Einstellungen\Sonja\Desktop\useR\scRipt\data")
      #double backslash or single slash are ok.

#Step B: read in data and assign it
object.types <- read.table("example_data.csv",header=TRUE,sep=",")
    object.types
      #the data set has a header and single cells are seperated by commas
      #more information see ?read.table
      #alternative version especially for *.csv-files are read.csv and read.csv2 
        object.types <- read.csv("example_data.csv")
          object.types
      #read.csv2 is for data sets with usual German notation

#Alternative version: do step A and step B in one single step
object.types <- read.table("D:/Dokumente und Einstellungen/Sonja/Desktop/useR/scRipt/data/example_data.csv",header=TRUE,sep=",")
      ###adjust path to whatever you have

############################################################

# 1. Read one that is stored already on the computer
# 1b. data format from other software like SPSS (*.sav)

#first install and open package foreign
install.packages("foreign")
library("foreign")
      #this library allows you to read and save different file formats

#open and assign SPSS-data
spss.data <- read.spss("KlauerSkalen.sav", to.data.frame=TRUE)
      #this sometimes results in some warnings but works anyway
    spss.data
      #remember to set the working directory if not done before or include the path

############################################################

# 2. Use one from a specific package

#many packages include dataframes to demonstrate commands
#you can get an overview over datasets
data()
  #list of data sets in loaded packages

#you can load a specific data set
library("boot") 
    #load package
data(gravity) 
    #load dataset
gravity
    #it is automatically assigned to the name gravity
    #if you need more information: have a look at the help file
      ?gravity 

#some packages are a collection of data frames
library("datasets")
  #maybe you would like to have a look on some of them
    data()
    ?AirPassengers

############################################################

# 3. Create your own ones 
### Comment: It is uncomfortable to create big data frames in R.
### Consider to use other software and import it afterwards.

#Step A: you need some vectors of equal length
number <- c(1, 2, 3)
letter <- c("A", "B", "C")
vowel <- c(TRUE, FALSE, FALSE)

#Step B: put them togehter as a data frame
one2three <- data.frame(number, letter, vowel)
one2three

#Variant: Using a special vector as row names
in.place <- c("1st", "2nd", "3rd")
ABC <- data.frame(letter, vowel, row.names = in.place)
ABC

############################################################

# 4. Expand existing data frames

#Remember the first example
object.types

#Now add a column: which group works on which topic

#Create a vector
  group <- c(1, 1, 2, NA, 2, NA)
#Then add it to the existing data frame
  object.types <- data.frame(cbind(object.types, group))
  object.types

############################################################

#5. Save data sets

#You can use the commands write.table, write.csv or write.csv2
write.csv(object.types, file = "object_group.csv")
    #you have to enter the object to save and the file name
    #if you have not set the working directory, fill in the whole path and file name

# if you want to save other formats, you find some in the package foreign

############################################################

#6. Indexing data sets

#In this section you learn about how to extract single columns, rows and elements of a data frame.
#Before doing this, there are some commands to get an overview over a data frame.

#str() gives you an overview of an structue of any object
str(spss.data)
    #you can see that it is a data frame with 279 observations (rows) 9 variables (columns)
    #you can also see the mode and the first values of each row
    #more specific information can be found with commands like:
dim(spss.data)
    #information on dimensions
class(spss.data)
    #object type

#Have another example
one2three
str(one2three)
    #character vectors are by default converted to factors

#extract single elements
one2three[2, 1]
    #get the element in the 2nd row and the 1st column
one2three[c(1, 3), 3]
    #get the elements in the 1st and 3rd row in the 3rd column respectively

#extract a row
one2three[2,]
    #get the 2nd row

#extract a column
one2three[,2]
    #get the 2nd column
#Alternative: 
one2three$letter
    #use name of object, $ and the column name


############################################################

#7. Attaching data sets

#Let's get back to the spss.data
#This dataset contains various variables 
#To compute the mean of cft1 (cultural fair test at time point one) we could do
mean(spss.data$cft1)
    #in the brackets the vector "cft1"" is extracted, afterwards the mean is computed

#If you work a lot on one data set, it is nasty to write "spss.data$" in every command
#So you attach the data set
attach(spss.data)
   mean(cft1)

#Please be careful, by attaching data you might occupy many object names

#and remember to detach data set after finishing your calulations
detach(spss.data)
mean(cft1)  #does not work any more

############################################################

#8. Create matrices

#If you work with data containing only numbers 
#(or if you work with matrices for other reasons)
#matrices provide some additional features

#Create a matrix
#For a matrix you need a long vector and information on the dimensions
nobel.prize <- matrix(c(189, 68, 156, 189, 96, 86, 2, 1, 4, 10, 12, 15), ncol = 2)
nobel.prize
    #here we specified the number of columns, but you can also specify the number of rows or both

#You can also add some row and column names (here you have to use a list)
nobel.prize <- matrix(c(189, 68, 156, 189, 96, 86, 2, 1, 4, 10, 12, 15), ncol = 2,
            dimnames = list(c("Phy", "Eco", "Che", "Med", "Lit", "Pea"), c("men", "women")))
nobel.prize

#Comment: rbind and cbind offer you more options to create matrices, e.g. from various vectors
rbind(c(1,2,3),c(4,5,6))
cbind(c(1,2,3),c(4,5,6))

#convert matrices to data frames (e.g. when you want to add some non-numerical information)
nobel.data <- as.data.frame(nobel.prize)
class(nobel.data)

#and finally some indexing
#single element
nobel.prize[5,2]
nobel.prize["Lit","women"]
#rows
nobel.prize[5,]
nobel.prize["Lit",]
#columns
nobel.prize[,2]
nobel.prize[,"women"]

############################################################

#9. Work with matrices

#What happens when you apply the command mean to a matrix?
mean(nobel.prize)
    #this is one mean for the whole matrix
    #but maybe that is not what you wanted

#Maybe this
rowMeans(nobel.prize)
#or that
colMeans(nobel.prize)

# Alternative that is more flexible (but also a little bit slower):
apply(nobel.prize, 1, mean)
apply(nobel.prize, 1, range) #Range: Minimum and Maximum
apply(nobel.prize, 2, mean)
apply(nobel.prize, 2, range)
    #the first slot is for your matrix
    #the second slot is for the direction (1: rows, 2:columns)
    #in the third slot you can insert different functions (this makes it flexible)

#Some matrix operations (if you are interested...)
A <- matrix(c(1, 2, 3, 4), ncol = 2)
A
B <- matrix(c(3, 5, 2, 6), ncol = 2)
B

#Multiply
A%*%B
#Transpose
t(A)
#Invert
solve(A)






