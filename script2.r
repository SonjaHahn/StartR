################################
#### Structure and Pitfalls ####
################################

# You are free to add your own comments


### Command mean with different vectors ###

mean(c(3, 4, -5, 7, -10)) 
mean(c(TRUE, FALSE, TRUE, TRUE))

mean(c("Sonja", "David")) 
  #does not work: wrong mode


### Option na.rm for command mean ###

mean(c(3, 4, -5, 7, -10, NA)) 
    #does not work with missing value
mean(c(3, 4, -5, 7, -10, NA), na.rm=TRUE) 
    #option to remove missing values first
?mean 
    #There you can see the defaults of the options

#alternative 1:
  mean(x=c(3,4,-5,7,-10,NA),na.rm=TRUE) #being very explicit
#alternative 2:
  mean(c(3,4,-5,7,-10,NA),0,TRUE) #mind to keep the order!


### Nesting commands mean and abs ###

mean(abs(c(3,4,-5,7,-10))) 
  #first compute absolute values, then mean

#alternative: using an assignment
  absolute.values <- abs(c(3,4,-5,7,-10))
  mean(absolute.values) #you need 2 lines

#different order - different result
  abs(mean(c(3,4,-5,7,-10))) 
    #first compute mean, then the absolute value


### Pitfalls ###

## 1. Case sEnsitivity
Absolute.Values
absolute.values
mean(c(3, 4, -5, 7, -10, NA), na.rm = true)

## 2. Be careful with assignemnts
absolute.values <- abs

#alternative: old version for assignments
  absolute.values = abs 

#this is the result:
  absolute.values
  absolute.values(-3)

#mean = c(1, 2, 3) 
    #here you would overwrite a function