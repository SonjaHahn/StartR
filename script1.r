####################################
#### Script: R as a calculator #####
####################################

3+4
3*4
sqrt(16)	#square root

number <- 9*9  #assignment
number
sqrt(number)

?sqrt		#help on command sqrt
example(sqrt)
??root		#search help for "root"

#####################################
#### Install additional packages ####
#####################################

install.packages("pracma") #install package pracma
library("pracma")	#open package pracma
factorize(18)	#new command: prime factorization; 
factorize(number)

q()		#quit R; do NOT save workspace
