##########################################################
############ Statistical analyses with R #################
##########################################################

# This script contains two main parts:
# 1. Descriptive Analyses with R
# 2. Some simple testing procedures

# Before we start we need a data set to work on:

chocolate <- read.csv("D:/Dokumente und Einstellungen/Sonja/Desktop/useR/scRipt/data/chocolate.csv")
    # Adjust this path to the directory you use; Attention: write "/" or "\\"; do not write "\"
attach(chocolate)
    # this command simplifies access to the variables in the data
    # remember to detach the data in the end of the script

# chocolate.csv is a simulated dataset with 100 observations.
# It contains the following variables:
consumption.1
    # daily consumption of chocolate in everyday life
consumption.2
    # daily consumption of chocolate on a meeting, where participants usually eat more chocolate
fair.trade
    # prefers fair trade chocolate
high.cocoa
    # prefers chocolate with high cocoa content
weight
    # weight of person

######################################
### 1. Descriptive Analyses with R ###
######################################


# 1.1 Mean
mean(consumption.1)

# 1.2 Standard deviation and variance
sd(consumption.1)
var(consumption.1)

# 1.3 Minimum, maximum & range
# A minimum can be computed on a single variable using the 'min()'-command.
min(consumption.1)
# The maximum, via 'max()', operates the same way.
max(consumption.1)
# For a data frame 'min()' (or 'max()') will show the minimum (or maximum) value of the entire dataset - 
# NOT from each individual variable.
min(chocolate)
max(chocolate)
# Almost the same: The command 'range()', returning minimum and maximum
range(consumption.1)
range(chocolate)

# 1.4 Median, Quartiles, Percentiles
# There is a special command for the median 
median(consumption.1)
# Corresponding percentiles can be found using the 'quantile(VAR,c(PROB1, PROB2))'-command.
quantile(consumption.1, c(.25, .50, .75))
quantile(consumption.1, c(.05, .95))

# 1.5 Correlation and Covariance
# For two variables:
cor(consumption.1, consumption.2)
cov(consumption.1, consumption.2)
# For a data frame:
cor(chocolate)
cov(chocolate)
    #for kendall- and spearman-correlations, type: ?cor

# 1.6 Frequencies and Proportions
table(consumption.1) #Frequencies for 1 variable
prop.table(table(consumption.1)) #Proportions
cumsum(table(consumption.1)) #Cumulative Sums

table(fair.trade, high.cocoa) #Frequencies for 2 variables
prop.table(table(fair.trade, high.cocoa)) #Proportions
addmargins(table(fair.trade, high.cocoa)) #Sums in margins

# 1.7 Stem and Leaf Plot
# Stem and Leaf Plots combine graphical and numeric aspects
stem(weight)


### Exercise: ###
#Compare consumption.1 and consumption.2 using commands like mean(), median(), sd(), range() and table()

##############################################################

#########################################
### 2. Some simple testing procedures ###
#########################################

# We will focus on using the t-Test in various ways.
# Below there are some additional testing procedures if you are interested.

# 2.1 t-Tests

# First have a look at the help file.
?t.test
    #You might use the help file when you do not understand the commands 

## One-Sample t-Test
# Research Question: Is there a significant deviation from the average daily chocolate consumption in Germany (approx. 25g)?
t.test(consumption.1, mu = 25)
    # this test gets significant (see p-value)
    # you can also find a t-value, df, the confidence intervall and the mean of the variable in the output

## t-Test for paired data
# Research Question: It the average chocolate consumption in every-day life significantly lower than in holidays?
t.test(consumption.1, consumption.2, alternative = c("less"), paired = TRUE)
    # just put both vectors inside the function
    # specify the necessary options
    # this test also gets significant

## t-Test for two independent samples
# Research Question: Differ the two groups prefering vs. not prefering chocolate with high cocoa content significantly in their means of consumption.1?
# Usually we use the following syntax:
    # t.test(dependent variable ~ independent variable)
    # the help tells us that this command expects the independent variable to be a factor
    # so we create a new variable, that is the factor-version of high.cocoa
    high.cocoa.f <- as.factor(high.cocoa)

t.test(consumption.1 ~ high.cocoa.f, var.equal = TRUE)
    # this is the "original" t-Test assuming variance homogeneity (option: var.equal = TRUE)
    # we will use a Levene Test to test this assumption

# Levene Test
install.packages("car")
library("car")
?leveneTest
leveneTest(consumption.1 ~ high.cocoa.f)
    # as this test gets significant, we should do a t-Test for unequal variances

# t-Test for unequal variances or "Welch Test""
t.test(consumption.1 ~ high.cocoa.f)
    # as you see, R uses the Welch Test by default
    # also this test gets significant


# 2.2 Correlation
# Here is one way to test if a correlation is significant.
cor.test(consumption.1, consumption.2)

# 2.3 Chi-squared Test
# Here are two versions for the Chi-squared Test for contingency tables 
# It tests if the observations are independent.
chisq.test(table(high.cocoa, fair.trade)) #with continuity correction
chisq.test(table(high.cocoa, fair.trade), correct=FALSE) #without continuity correction

##################################################################

# Summary

# last but not least: The command "summary"
# This command adopts to many objects:

summary(consumption.1)
summary(table(high.cocoa, fair.trade))
summary(chocolate)


### ... and do not forget to detach the data... 

detach(chocolate)

