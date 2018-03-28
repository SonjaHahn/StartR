##########################################################
###############Vectors and factors#######################
##########################################################

#1.How can I type in vectors?
#1a.Different ways of defining and exploring objects - examples
#1b.Generating vectors and indexation
#2.How to calculate with vectors
#3.Converting vectors
#4.Factors

##########################################################

#1. How can I type in vectors?

#As R works with the concept of objects, we need attributes to specify these the kind of information represented in the data.
#Every object has two intrinsic attributes: mode & length. 
#Length means nothing else than the number of elements of the object.
#The mode is the basic type of elements of the object (how R stores and organizes data). 
#The four main modes are: numeric, character, complex and logical (FALSE or TRUE).

#1a. different ways of defining objects - examples
#You have 2 main options to define objects: "=" or "->" ("<-")

#numeric
a <- c(1, 3, 5, 9)
b = c(10, 20, 30, 40)
a
b

#character, complex, logical
A <- "Wikileaks"
compar = TRUE
z <- 2+1i
mode(A); mode(compar); mode(z)

#With the commands 'length(...)' and 'str(...)' (shortform for structure) you can get most simple attribute information about the objects, as shown below with 'a' & 'A'.
str(a)
str(A)
length(a)
length(A)

#tip
###The ';' helps you to type more commands in one line.
###R differs in upper and lower case, so attention! ('A'vs.'a')
###'ls()' shows you all objects you already defined.
###'rm()' deletes particular objects. 
ls()
rm(z)
ls()


###########################################################

#1b.Generating vectors and indexation

#R has a number of facilities for generating commonly used sequences of numbers. 
#For example 1:15 is the vector c(1, 2, ..., 14, 15), as you can see below.
x<-1:15
x

#The function 'seq()' is a more general facility for generating sequences.
#The first two arguments specify the beginning and end of the sequence, 
    #the third, which may be named 'by=value' specifies the step size of the sequence.
y <- seq(1, 5, 0.5)
y

seq(-2, 2, by=0.4) -> s4 #Assignment in the other direction: Object name on the right hand side 
s4

#The function 'c()' in this context can take an arbitrary number of vector arguments.
c(20, 18, 16, 14, 12, 10)

#With the command 'rep()' you can create a vector repeating the first argument as often as the value of the second argument defines, 
  #This can be helpful e.g. for indicating group memberships.
rep(c(1, 2), 3) 

#Indexes help you to find a concrete value of a defined vector again, e.g. referring to vector 'y' defined above.
y
y[4] #4th element of vector y


###########################################################

#2.How to calculate with vectors 

###basic arithmetics 
# you can use operators for arithmetics also for vectors
# in this case, the 1st (2nd, 3rd...) element of one vector is combined in the indicated way with the 1st (2nd, 3rd...) element of the other factor
natural.numbers <- 1:4
natural.numbers
cycling.vector <- rep(c(2, 3), 2)
cycling.vector

#four basic operators
natural.numbers + cycling.vector
natural.numbers - cycling.vector
natural.numbers * cycling.vector
natural.numbers / cycling.vector

#Priorities - like in every scientific calculator
natural.numbers+2*cycling.vector
natural.numbers+(2*cycling.vector)
(natural.numbers+2)*cycling.vector

###Exponents, squareroots, rounding
natural.numbers^cycling.vector
roots <- sqrt(natural.numbers)
roots
round(roots)
round(roots, digits=2)

#"recycling" 
#This means that when two vectors differ in length the operations are done for every element of the longer vector while re-cycling (beginning again) the shorter one
vector.6.elements <- 1:6
vector.6.elements
natural.numbers + vector.6.elements 
    # 1+1 2+2 3+3 4+4 ... now the first vector begins again ... 1+5 2+6
#Attention: Sometimes this can lead to mistakes!
another.vector <- c(1, 1)
natural.numbers + 2 * another.vector 
    #here no error warning occurs, as the first vector has double length of the second one

#task 1
#Assign n <- 10 and compare the sequences 1:n-1 and 1:(n-1)

###Operators for logical vectors

#For logical vectors you use boolean operators like AND and OR 
log.1 <- c(TRUE, FALSE, FALSE)
log.2 <- c(FALSE, FALSE, TRUE)

log.1 & log.2 #AND 
log.1 | log.2 #OR
log.1 == log.2 #equal to
log.1 != log.2 #not equal to

#the later two can also be applied to other vectors returning logical vectors
c(1, 2, 3) == c(3, 2, 3)
c(1, 2, 3) != c(3, 2, 3)

#Greater (vs. smaller) work similarly
c(1, 2, 3) > c(3, 2, 3) #greater
c(1, 2, 3) >= c(3, 2, 3) #greater or equal


###########################################################

# 3.Converting vectors

#Sometimes you have to change the mode of an object to make it fit for your command or your data.
#Commands like as.numeric, as.logical or as.character are designed to do this.

obj <- c("1", "2", "3", "4") #character vector
mean(as.numeric(obj))

c(1, 0, 0, 1) & c(1, 1, 1, 1) 
    #R converts numeric vectors automatically to logical vectors and returns a logical result; 
as.numeric(c(1, 0, 0, 1) & c(1, 1, 1, 1)) 
    #if you want a numeric vector, you have to say this explicitly

#If you do not want to change the name of the vector but it's mode, use an assignment.
v <-c(0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 1)
v <- as.logical(v)
v
v <- as.character(v)
v

v2 <-c(0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 1)
v2 <- as.character(v2)
v2

#task 2: Compare the last version of "v" and "v2". Why is there a different result?

#task 3: Try to get v2 from the character mode into a logical mode  
    #(that's a little bit more difficult; one solution is at the end of the script)

#tip: 
#If you want to concatenate different types of vectors in one single character,you can use the command paste
postal.code <- "07743"
city <- "Jena"
country <- "Germany"
paste(postal.code, city, country)
paste(postal.code, city, country, sep="/")

#############################################################

#4.Factors

#A factor is a vector object used to specify a discrete classification (grouping) of the components of other vectors of the same length. 
#The following example is taken from http://cran.r-project.org/doc/manuals/R-intro.html

#Suppose, we have a sample of 30 tax accountants from all the states and territories of Australia
#Their individual state of origin is specified by a character vector of state mnemonics as

state <- c("tas", "sa",  "qld", "nsw", "nsw", "nt",  "wa",  
           "wa", "qld", "vic", "nsw", "vic", "qld", "qld", 
           "sa",  "tas","sa",  "nt",  "wa",  "vic", "qld", 
           "nsw", "nsw", "wa", "sa",  "act", "nsw", "vic",
           "vic", "act")

#A factor is similarly created using the 'factor()' function: 
statef<-factor(state)

#Here we get an overview, which values the factor level can take.
levels(statef)

#We use indexing here to alter the state of two accountants
statef[30] <- "wa"
statef[26] <- "vic"

#Although act is no more included in the values, it is still included a a possible level
statef


#To continue the example, suppose we have the incomes of the same tax accountants in another vector (in suitably large units of money). 
incomes <- c(60, 49, 40, 61, 64, 60, 59, 54, 62, 69, 70, 42, 56,
                    61, 61, 61, 58, 51, 48, 65, 49, 49, 41, 48, 52, 46,
                    59, 46, 58, 43)

#With the special funktion 'tapply(...)' we can calculate the sample mean income for each state.
incmeans <- tapply(incomes, statef, mean)
incmeans
  #the empty level returns NA as no mean can be computed

#tip
###With 'gl()' you can generate regular series of factors.

###Be careful when you use the command as.numeric with factors
favourite.number <- factor(c("4","3","9","30","various"))
levels(favourite.number) #get information on levels
as.numeric(favourite.number) #is this the result you expected?
as.numeric(as.vector(favourite.number)) #or rather that?

###########################################################

# Solutions of tasks

#task 1
n <- 10
1:n-1
1:(n-1)
#the first version counts from 1 to 10 and distract 1 from each element afterwards
#the second version counts from 1 to 9, as 10-1=9.

#task 2
#The additional transformation as.logical results in another "wording" of the vector: 
#"TRUE" and "FALSE" instead of "1" and "0".

#task 3
as.logical(as.numeric(v2))
#first convert it to numeric, then to logical




