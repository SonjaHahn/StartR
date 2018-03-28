#######################################
### Graphics: Commands and Options ####
#######################################

#1. Data frame (loading and description)
#2. Some examples for commands
#3. Flexibility of plot command
#4. Options in plot commands
#5. Low level commands

### 1. Data frame (loading and description)

# In the following you will work on a dataset on chocolate consumption
setwd("D:/Dokumente und Einstellungen/Sonja/Desktop/useR/scRipt/data")
chocolate <- read.csv("chocolate.csv")
attach(chocolate)

# chocolate.csv is a simulated dataset with 100 observations.
# It contains the following variables:
consumption.1
    #daily consumption of chocolate in situation 1
consumption.2
    #daily consumption of chocolate in situation 2
fair.trade
    #prefers fair trade chocolate
high.cocoa
    #prefers chocolate with high cocoa content
weight
    #weight of person
    
### 2. Some examples for commands

# Plot commands allow you to survey your data

# Here are some examples for 1 variable:
hist(weight)
  #
boxplot(weight)
  #
barplot(table(fair.trade))
  #
pie(table(fair.trade))
  #
mosaicplot(table(high.cocoa))
  #

# And some examples for 2 variables
plot(consumption.1, consumption.2)
  #
barplot(c(mean(consumption.1), mean(consumption.2)))
  #
boxplot(list(consumption.1, consumption.2))
  #
mosaicplot(table(high.cocoa, fair.trade))
  #

# And one example for many variables
pairs(chocolate)
  #
chocolate.cont <- data.frame(consumption.1, consumption.2, weight)
pairs(chocolate.cont)
  #

### 3. Flexibility of plot command

#Most of the upper commands need a special object to work on
#The plot command adjusts to your object 
#(that does not mean that it adjust to your expectation, how the plot should look like)

#a single vector
plot(consumption.1)
  #

#two vectors
plot(consumption.1, consumption.2)
  #

#data frame or matrix
plot(chocolate.cont)
  #

#distribution/function
plot(dnorm)
  #
plot(dnorm, -3, 3) #with range
  #

#time series
plot(AirPassengers)
  #

#formulae/lm-object
one.regression <- lm(weight ~ consumption.1)
plot(one.regression)
  #

### 4. Options in plot commands

#When you got a plot and want to present it, you may want to alter some things
#Advice: Do it step by step: arrange the data, do the plot, alter the plot step by step

#Here are two examples

#Example 1: Scatterplot

plot(consumption.1, weight,                         #original plot
     xlab = "Chocolate consumption in g",           #axis: labels
     ylab = "Weight in kg",
     xlim = c(0, 250),                              #axis: range
     ylim = c(0, 120),
     main = "Chocolate consumption and weight",     #title
     pch = as.numeric(high.cocoa),                  #different shapes for points
     bty = "n"                                      #no box around graphic
     )
  #

#Example 2: Comparing different consumer groups

group.means <- tapply(consumption.2, data.frame(fair.trade, high.cocoa), mean)
group.means

barplot(group.means, 
        beside = TRUE,                                  #bars next to each other
        col = c("red", "green", "darkred", "darkgreen"),  #add colors (see color chart in folder materials)
        ylab = "Chocolate consumption",                 #labels for axes
        xlab = "Groups",
        ylim = c(0, 100),                               #range of y-axis
        legend.text = c("normal", "fair trade", "high cocoa", "both"), #legend text
        axisnames = FALSE,                              #no axis names
        space = c(0.2, 0.8)                             #space between grouped and not grouped bars
        )
  #

# 5. Low level commands

#Until now we worked with high level commands.
#High level commands produce (new) graphics.
#Low level commands add additional elements to existing graphics.

#Recall example 1 from above

plot(consumption.1, weight,                         #original plot
     xlab = "Chocolate consumption in g",           #axis: labels
     ylab = "Weight in kg",
     xlim = c(0, 250),                              #axis: range
     ylim = c(0, 120),
     main = "Chocolate consumption and weight",     #title
     pch = as.numeric(high.cocoa),                  #different shapes for points
     bty = "n"                                      #no box around graphic
     )

#Add regression line
one.regression <- lm(weight ~ consumption.1)
abline(one.regression)

#Add legend
legend(150, 40,                                                    #place
      pch = c(0, 1),                                               #different shapes for points
      legend = c("normal", "high cocoa"))                          #text

#Add an mathematical annotation
 text(150, 60,                                                      #position
      expression(italic(Y)==alpha[0]+alpha[1]*X+italic(epsilon)),     #expression
      adj = 0)                                                      #adjustment
?plotmath                #help on expressions

#Add an arrow
arrows(150, 65, 115, 90,                                            #from - to - coordinates
       length = 0.15)                                               #size


#Recall example 2 from above

barplot(group.means, 
        beside = TRUE,                                 #bars next to each other
        col = c("red", "green", "darkred", "darkgreen"),  #add colors
        ylab = "Chocolate consumption",                #labels for axes
        xlab = "Groups",
        ylim =c (0, 100),                              #range of y-axis
        #legend.text = c("normal", "fair trade", "high cocoa", "both"), #legend text
        axisnames = FALSE,                             #no axis names
        space = c(0.2, 0.8)                            #space between grouped and not grouped bars
        )

#Now place the legend more adequately and with smaller letters
legend(2.2, 100,                                             #place
  fil = c("red", "green", "darkred", "darkgreen"),           #colors
  cex = 0.8,                                                 #smaller letters
  legend = c("normal", "fair trade", "high cocoa", "both"))  #text

detach(chocolate)

### End of script ###





