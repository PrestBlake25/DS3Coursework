#################################################################################
# Reproduce this table in ISRS 5.29 using the original dataset in body.dat.txt
# Coefficients:
#               Estimate  Std. Error  t value  Pr(>|t|)
# (Intercept)  -105.0113      7.5394   -13.93    0.0000
# height          1.0176      0.0440    23.13    0.0000
body <- read.table("body.dat.txt", header = TRUE)

###################################################################################
# ISRS Exercise 6.1
#  The Child Health and Development Studies investigate a range of
# topics. One study considered all pregnancies between 1960 and 1967 among women in the Kaiser
# Foundation Health Plan in the San Francisco East Bay area. Here, we study the relationship
# between smoking and weight of the baby. The variable smoke is coded 1 if the mother is a
# smoker, and 0 if not. The summary table below shows the results of a linear regression model for
# predicting the average birth weight of babies, measured in ounces, based on the smoking status of
# the mother.
# Coefficients:
#               Estimate  Std. Error  t value  Pr(>|t|)
# (Intercept)    123.05        0.65   189.60    0.0000
# smoke           -8.94        1.03    -8.65    0.0000

# The variability within the smokers and non-smokers are about equal and the distributions are
# symmetric. With these conditions satisfied, it is reasonable to apply the model. (Note that we
# don’t need to check linearity since the predictor has only two levels.)
babyweights <- read.table("babyweights.txt", header = TRUE)

# a. Write the equation of the regression line.

# Answer: y = 123.05 + -8.94x

# b. Interpret the slope in this context, and calculate the predicted birth weight of babies born to
# smoker and non-smoker mothers.

#  Answer: if the mother smokes, then the weight of the baby would be 114.11, and if the mother doesn't smoke,
# the weight of the baby is 123.05.


# c. Is there a statistically significant relationship between the average birth weight and smoking?

# Answer: Since the p-values are 0, there is a statistically significant relationship between 
# the average birth weight and smoking.

###################################################################################
# ISRS Exercise 6.2
# Exercise 6.1 introduces a data set on birth weight of babies.
#Another variable we consider is parity, which is 0 if the child is the first born, and 1 otherwise.
#The summary table below shows the results of a linear regression model for predicting the average
# birth weight of babies, measured in ounces, from parity
# Coefficients:
#               Estimate  Std. Error  t value  Pr(>|t|)
# (Intercept)    120.07        0.60   199.94    0.0000
# parity          -1.93        1.19    -1.62    0.1052
#
# a. Write the equation of the regression line.

# Answer: y = 120.07 + -1.93x

# b. Interpret the slope in this context, and calculate the predicted birth weight of first borns and
#    others.

# Answer: If the child is of first born, the weight of the kid would by 120.07, and if the kid 
# is not a first born, the child's weight is 118.14 

# c. Is there a statistically significant relationship between the average birth weight and parity?

# There is no statistically significant relationship between birth weight and parity since
# the p-value of partiy is more than .05

###################################################################################
# ISRS Exercise 6.3
# We considered the variables smoke and parity, one at a time, in
# modeling birth weights of babies in Exercises 6.1 and 6.2. A more realistic approach to modeling
# infant weights is to consider all possibly related variables at once. Other variables of interest
# include length of pregnancy in days (gestation), mother’s age in years (age), mother’s height in
# inches (height), and mother’s pregnancy weight in pounds (weight). Below are three observations
# from this data set.

# Data set observations (n = 1,236):
#        bwt  gestation  parity  age  height  weight  smoke
# 1      120        284       0   27      62     100      0
# 2      113        282       0   33      64     135      0
# ...
# 1236   117        297       0   38      65     129      0

# Coefficients:
#               Estimate  Std. Error  t value  Pr(>|t|)
# (Intercept)    -80.41       14.35    -5.60    0.0000
# gestation        0.44        0.03    15.26    0.0000
# parity          -3.33        1.13    -2.95    0.0033
# age             -0.01        0.09    -0.10    0.9170
# height           1.15        0.21     5.63    0.0000
# weight           0.05        0.03     1.99    0.0471
# smoke           -8.40        0.95    -8.81    0.0000
#
# a. Write the equation of the regression line that includes all variables:

# Answer: y = -80.41 + 0.44x1 + -3.33x2 + -0.01x3 + 1.15x4 + 0.05x5 + -8.4x6

# x1 = gestation
# x2 = parity
# x3 = age of mother
# x4 = mother's height
# x5 = mother's weight
# x6 = smoke



# b. Interpret the slopes of gestation and age in this context:

# gestation - for each day the mother becomes pregnant with her baby, the slope increases by 0.44
# age - as the woman gets older, the baby's birth weight will increase by .44


# c. The coefficient for parity is different than in the linear model shown in Exercise 6.2. Why
#    might there be a difference?

# The parity's coefficient is different than the one in the other model because 
# there are multiple independent variables contributing in finding the weight of
# the baby
#


# d. Calculate the residual for the first observation in the dataset.

babyW <- read.table('week3/babyweights.txt', header = TRUE, na.strings = "NA")
baby_lm <- lm(bwt ~ ., data = babyW)
residuals(baby_lm)[1]

# -2.003102

# e. The variance of the residuals is 249.28, and the variance of the birth weights of all babies
#    in the data set is 332.57. Calculate the R^2 and the adjusted R^2. Note that there are 1,236
#    bservations in the data set.

r_squared <- 1 - (249.28/332.57) # R^2: .2504435
adj_r_squared <- 1 - (249.28/332.57) * (1236 - 1)/(1236 - 6 - 1) # Adjusted R^2: .2467842
summary(baby_lm)$r.squared
