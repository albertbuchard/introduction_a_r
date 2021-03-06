# Load datasets from R
library(datasets)

# Load the library we are going to use
library(data.table)
library(psych)
library(MASS)


############################
# Element wise comparison
# a = c(1,2,3,4)
# b = a[((a>3) | (a<2))]
#
# Operators
# ==
# <=
# =>
# !=
# &&
# ||
############################

# Check what your datasets http://127.0.0.1:8617/help/library/datasets/html/00Index.html
# or write : ?datasets then index bottom of the page

# Categorical datasets
HairEyeColor

# Explore the structure of the data. Here it is a table NOT a data.table
str(HairEyeColor)

# Get the marginal count for one variable
# the sum of all the counts by this variable
eyes = margin.table(HairEyeColor, 2)

# convert to proportions
prop.table(eyes)

# test significantly differ from H0 equal proportions
chisq.test(eyes)

# test with an H0 with custom population proportions (p = c(...,...))
chisq.test(eyes, p=c(.41,.32,.15,.12))

# Different structure for a data.table
dt = data.table(a = rep(23,4))
str(dt)


## SAMPLE MEAN - 2 SAMPLE MEAN - 2 tail - 1 tail
mtcars

# extract mpg
hist(mtcars[,1])

# test significantly different than 20 -- get confidence interval of 0.8
t.test(mtcars[,1], mu = 20, conf.level = 0.8)

# create fake data
# Sample 18000 scores from a normal distribution of mean 5 and sd 2
memory_test = rnorm(18000, mean = 5, sd = 2)

# take only the values between 0 and 10 (you could use also the function ifelse())
memory_test_filtered = memory_test[memory_test>0 & memory_test<10]
hist(memory_test_filtered)

# test significantly different than 5
t.test(memory_test_filtered, mu=5)

# sample the same amount of subjects this time centered on 6
memory_test_female = rnorm(18000, mean = 6, sd = 2)
hist(memory_test_female)
describe(memory_test_female)

# Filter it in the same way take only values between 0 and 10
memory_test_female_filtered = memory_test_female[memory_test_female>0 & memory_test_female<10]
hist(memory_test_female_filtered)

# One tailed (alternative / alt = "greater")
t.test(memory_test_female_filtered, memory_test_filtered, alt = "greater")

## PAIRED T TEST T1 -> Intervention -> T2 (repeated measure)
## GROUP T1 - first test before the intervention
# sample fake data centered on 2
memory_test = rnorm(18000, mean = 2, sd = 1)

# a lot of the data is below 0
# but since we are going to use a paired t-test we want to keep the same amount of
# subjects and not delete them

# We need to REPLACE the values for subjects below 0
# If we replace all the values below 0 by 0 it will strongly alter the shape of the distribution
memory_test[memory_test<0] = 0

# look at the first bin on the left is a lot higher than its symetric bin on the other side
# The distribution is skewed, which is not bad in itself, you just have to account for it by using
# robust statistics if the skeweness is too important
hist(memory_test)

# Another way, to smooth your distribution a bit could be to replace by 0 + a random value between 0 and 3
# (this is fake data -- not something you will want to do with real data)
memory_test = rnorm(18000, mean = 2, sd = 1)

# get the number of subjects below 0
size_below_zero = length(memory_test[memory_test<0])

# get a vector of values between 0 and 3
sampled_vector = seq(from = 0, to = 3, by = 0.01)

# sample from that vector the same amount of time that there are subject below 0 in the memory test
sample_for_replacement = sample(sampled_vector, size = size_below_zero,replace = T)

# replace the values
memory_test[memory_test<0] = sample_for_replacement
hist(memory_test)

## GROUP T2 cw in between !
# We create the second vector by adding a random number sampled from a normal distribution
# with mean of 3 and sd of 1
added_vector = rnorm(length(memory_test), mean = 3, sd = 1)
hist(added_vector)

# our intervention has a positive effect so we add this positive vector
memory_test_t2 = copy(memory_test) + added_vector

# we build our data.table with the two samples
pairs = data.table(t1 = memory_test, t2 = memory_test_t2)

# Check visually evolution of the 100 first subjects (parcoord is part of the MASS package)
parcoord(pairs[0:100,], var.label = T)

# Paired T test with H0 difference is not significantly different than 0
t.test(memory_test_t2, memory_test , paired = T)

### ANOVA One variable
# Check that the number of days of holidays between countries is different
chinese = rnorm(n = 150, mean = 3, sd = 1)
japan = rnorm(n = 30, mean = 6, sd = 1)
danemark = rnorm(n = 20, mean = 30, sd = 4)
usa = rnorm(n = 400, mean = 4, sd = 2)

boxplot(chinese, japan, danemark, usa)

# We need an indicator variable, we build it by hand
group = c(rep('chinese', 150),rep('japanese', 30), rep('danish', 20), rep('american', 400))

# This is our value variable
values = c(chinese, japan, danemark, usa)

# We create a data.table with those two corresponding vector
dt = data.table(g = group, v = values)
print(dt)

# Now we can perform our anova test
aov_results = aov(dt, formula = v ~ g)
summary(aov_results)

# We can also test group difference one to one using Tukey
# Here they are all significant
tukey_results = TukeyHSD(aov_results)
print(tukey_results)

# To use the function stack() the number of observation need to be similar
chinese = rnorm(n = 50, mean = 3, sd = 1)
japan = rnorm(n = 50, mean = 6, sd = 1)
danemark = rnorm(n = 50, mean = 30, sd = 4)
usa = rnorm(n = 50, mean = 4, sd = 2)
stack_variable = stack(data.frame(cbind(chinese, japan, danemark, usa)))
result = aov(stack_variable, formula = values ~ ind)
summary(result)






