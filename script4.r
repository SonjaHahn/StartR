#########################################
### Linear Models, Formulae and Lists ###
#########################################

#1. Preparation (data loading)
#2. Regression with 1 independent variable
#3. ANOVA with 1 independent variable (Analysis of Variance)
#4. Regression with various independent variables
#5. Creating Lists
#6. Indexing Lists

#########################################

### 1. Preparation: Load data mtcars

data(mtcars)
View(mtcars)
?mtcars

# This data set contains information about different cars.
# This script uses mpg (Miles/gallon, consumption) as dependent variable.
# The independent variables are
    # disp: Displacement (Hubraum)
    # cyl: Number of cylinders
    # wt: Weight
    # qsec: Speed (Quater mile time)
    # am: Transmission (automatic/manual)


#########################################

### 2. Regression and ANOVA with 1 independent variable

# Lets try to predict consumption from displacement

## Fit a linear model
lm(mpg ~ disp, data = mtcars)
  #we get only little information about coefficients

#Fit the model, assign it and get more information
first.model <- lm(mpg ~ disp, data = mtcars)
  summary(first.model)

#There are additional commands you might want to use
coefficients(first.model) 
    #again the coefficients
fitted(first.model) 
    #predicted values
residuals(first.model) 
    #residuals
mtcars$mpg


## Henderson and Velleman (1981) suggest to use a more complex model
# Here is one with a quadratic and a cubic term
second.model <- lm(mpg ~ disp + I(disp^2) + I(disp^3), data = mtcars)
second.model <- lm(mpg ~ poly(disp, 3, raw=TRUE), data = mtcars)
summary(second.model) 
    #Output like regression

#########################################

###3. ANOVA with 1 independent variable

# The research question behind this part is: 
# Is there a significant difference in mean consumption 
# when comparing cars with different numbers of cylinders?

# First compare means
with(mtcars, tapply(mpg, cyl, mean))

# A factor as dependent variable results in an ANOVA
third.model <- lm(mpg ~ as.factor(cyl), data = mtcars)
summary(third.model)
# The next output even looks like ANOVA
anova(third.model)

# Attention: The next output looks like ANOVA, but is not ANOVA
anova(lm(mpg ~ cyl, data = mtcars))

#########################################

###4. Regression with various independent variables
# Hocking (1976) suggests to use the following two/three variables as predictors

# 2 variables Without interaction
fourth.model <- lm(mpg ~ wt + qsec, data = mtcars)
summary(fourth.model)

# 2 variables including interaction (various variants)
fifth.model <- lm(mpg ~ wt + qsec + wt:qsec, data = mtcars)
fifth.model <- lm(mpg ~ wt*qsec, data = mtcars)
fifth.model <- lm(mpg ~ (wt + qsec)^2, data = mtcars)
summary(fifth.model)

# Here are some models without, with second order and with third order interactions
summary(lm(mpg ~ wt + qsec + am, data = mtcars))
summary(lm(mpg ~ (wt + qsec + am)^2, data = mtcars))
summary(lm(mpg ~ (wt + qsec + am)^3, data = mtcars))

#########################################

###5. Creating lists

my.results <- list(coefficients(first.model), fitted(first.model), residuals(first.model))
my.results
str(my.results)

### 6. Indexing lists

#Any list
my.results[[1]]
my.results[[1]][2]

#List with labels
more.results <- summary(first.model)
str(more.results)
more.results$coefficients
more.results$coefficients[2, 1]
more.results$r.squared





