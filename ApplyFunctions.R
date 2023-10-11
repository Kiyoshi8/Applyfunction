### The apply family of functions

# an elegant way to do loops


# apply (arrays - matrices)

# tapply (vectors can be split in different subsets)

# lapply (the whole subfamily is for vectors or lists)
## sapply (user friendly version of lapply)
## vapply (similar to sapply, modified return value)
## replicate (random nr generation)

# rapply (similar to lapply)
# eapply (environment, generates a list)
# mapply (multivariate, similar to sapply)
# by (data frames, similar to tapply, factors needed, splits the df und does calculus on subset)


### APPLY

?apply

X = matrix(c(1:9), nr=3, byrow =T)

# MARGIN :: 1 is for row, 2 is for col

apply(X, 1, mean) # gives the mean of every row
apply(X, 2, mean) # gives the mean of every column

apply(X, 1, plot) # even graphics functions are possible


### TAPPLY

?tapply

# we use tapply to work with subsets of vectors

# tapply factor (given by the INDEX) determines which group the number in the vector belongs to
tapply (1:4, c(3,3,3,3), sum, simplify = F)

# to get two groups
tapply (1:4, c(3,3,3,4), sum, simplify = F)

# simplify gets just another output
tapply (1:4, c(3,3,3,4), sum, simplify = T)


# BY

# similar to tapply but can be used for dataframes
# Data can be split into subsets.

?by

head(iris)

by(iris[1:4], iris$Species, colMeans)

# we need to specify which column we want to work with []

by(iris[2:4], iris$Species, colMeans)

# in this case the first col sepal. length disappears


# EAPPLY

?eapply

# create an environment

e <- new.env()
e$e1 <- (3:8)
e$e2 <- (56:61)
e

# run function

eapply (e, mean)

# not that often used, specific for environments

# LAPPLY (whole subfamily)

?lapply

# we use lapply for lists

mylist <- list(a=(1:10), b=(45:77))

mylist

# result has same length as the list (here 2)

resultlapply <- lapply(mylist, sum)

resultlapply

# or vectors

myvector <- c(1:20)
lapply(myvector, sum)


# SAPPLY

?sapply

resultsapply <- sapply(mylist, sum)

resultsapply


# we do get the same result as lapply, however the output
# is different. In this case we get a userfriendly vec or mat

# VAPPLY

?vapply

# similar to sapply but the output can be specified
# classic example is fivenum function (five nr summary)

resultsvapply <- vapply(mylist, fivenum,
                        c(Min. = 0, "1st Qu." = 0,  Median = 0,
                          "3rd Qu." = 0, Max. = 0))

resultsvapply

# result is a matrix with row names = output functions
# and col names = list names


# REPLICATE

# allows for replication of random number generation

resultsreplicate <- replicate(7, runif(10))

resultsreplicate

# result is matrix


# MAPPLY

?mapply

# similar to sapply but multivariate
# functions are applied in different levels

mapply(rep, 1:4, 4:1)

# that means number 4 is rep 4x, number 2 is rep 3x, etc

# recycling (length must be a multiple)

mapply(rep, 1:8, 4:1)

# nr 1 and nr 5 should be rep 4x in this case

# this is a good way to work with different elements
# of a list (list$element.name). Exercise!

# RAPPLY

#similar to lapply

?rapply

list1 <- list(a=c(1:5), b=c(6:10))
list1

rapply(list1, sum)
rapply(list1, sum, how = "list")

# default to how is "unlist", which in fact is a vector, Other options are "list" and "replace."

a = c(TRUE, TRUE, TRUE)
b = c(1:3)

# use the class argument to apply the function only to this class
# of the mixed list

list2 <- list(a=a, b=b)
list2

rapply(list2, median, class ="integer")

# the class argument is a good way to handle mixed lists



#### those functions are overlapping at some points - you could use several roads to get to Rome

#### hint - package "plyr" gives more functions on this topic



### Exercise

# 1. If you take a look at the 4 functions: rowSums, rowMeans, colSums, colMeans
     # could you use the apply function to get the same results?

rowSums = apply(X, 1, sum) -> "2forcol"
rowMeans = apply(X, 1, mean) -> "2forcol"


# 2. mapply: Create 2 lists consisting of 3 elements each.
     # All elements have the same length.

     # get the sum and the mean of all elements of list 1 and elements 2 and 3 from list 2
     # the result should be 2 vectors (sum, mean) of the same length as the elements

a <- c(1:5)
b <- c(4:8)
c <- c(8:12)
d <- c(12:16)
e <- c(16:20)
f <- c(20:24)

list1 <- list (a=a,b=b,c=c)
list2 <- list (d=d,e=e,f=f)

mapply(sum, list1$a, list1$b, list1$c, list2$e, list2$f)
mapply(mean, list1$a, list1$b, list1$c, list2$e, list2$f)

# 3. Generate a vector of 100 random nrs. (rnorm)
     # there are 3 groups: gr 1 has numbers 1-40, gr 2 (41 -70) and gr 3 has (71 -100).
     # get the sum and the mean of those groups by using a suitable functions of the apply family

x <- rnorm(100)

y <- c(rep(1, times =40), rep(2, times = 30), rep(3, times =30))

tapply (x, y, sum)

tapply (x, y, mean)


# 4. create a matrix of 4 rows and 5 columns with random normal distributed numbers with mean 8.
# make the result reproducible
# calculate the mean for every row 

set.seed(34)
g <- replicate(5, rnorm(4,8))
apply(g, 1, mean)

# 5. create a mixed list (3 components) of 2 x 3 numeric values and 3 logicals.
# that means a is logical, b and c are numeric
# choose a suitable function and calculate the sum of the two numeric components.

a = c(FALSE, TRUE, FALSE)
b = c(3 , 5.7, 6)
c = c(4.3, 6.7, 5.9)
mylist=list(a=a, b=b, c=c)
mylist
rapply(mylist, sum, class="numeric")
