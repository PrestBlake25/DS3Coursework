library(tidyverse)

####################################################################################
# IST Chapter 4, Exercise 4.1
#
# Table 4.4 presents the probabilities of the random variable Y:
#
#   Value | Probability
#   ------|------------
#     0   |    1p
#     1   |    2p
#     2   |    3p
#     3   |    4p
#     4   |    5p
#     5   |    6p
#
# These probabilities are a function of the number p, the probability of
# the value "0". Answer the following questions:
#
# 1. What is the value of p? 
#       p = 1/21
# 2. P(Y < 3) = 2/7
# 3. P(Y = odd) = 4/7
# 4. P(1 <= Y < 4) = 3/7
# 5. P(|Y - 3| < 1.5) = 4/7
# 6. E(Y) = 10/3
# 7. Var(Y) = 20/9
# 8. What is the standard deviation of Y? 
# My answer is sqrt(20)/3


####################################################################################
# IST Chapter 4, Exercise 4.2
#
# One invests $2 to participate in a game of chance. In this game a coin
# is tossed three times. If all tosses end up "Head" then the player wins
# $10. Otherwise, the player loses the investment.
#
# 1. What is the probability of winning the game?
# The probability of winning the game is 1/8
# 2. What is the probability of losing the game?
# The probability of lossing the game is 7/8
# 3. What is the expected gain for the player that plays this game?
#    (Notice that the expectation can obtain a negative value.)
# E(X) = (10 * 1/8) + (-2 * 7/8) = -1/2 



####################################################################################
# IST Chapter 6, Exercise 6.1
#
# Consider the problem of establishing regulations concerning the maximum
# number of people who can occupy a lift. In particular, we would like to
# assess the probability of exceeding maximal weight when 8 people are
# allowed to use the lift simultaneously and compare that to the probability
# of allowing 9 people into the lift.
#
# Assume that the total weight of 8 people chosen at random follows a
# Normal distribution with a mean of 560kg and a standard deviation of 57kg.
# Assume that the total weight of 9 people chosen at random follows a
# Normal distribution with a mean of 630kg and a standard deviation of 61kg.
#
# 1. What is the probability that the total weight of 8 people exceeds 650kg?
   1 - pnorm(650,560,57)
   # My answer is 5%
# 2. What is the probability that the total weight of 9 people exceeds 650kg?
    1 - pnorm(650,630,61)  
    # My answer is 37%
# 3. What is the central region that contains 80% of distribution of the
#    total weight of 8 people?
    qnorm(.9,560,57)
    qnorm(.1,560,57) 

    # My answer is [486.9516, 633.0484]

# 4. What is the central region that contains 80% of distribution of the
#    total weight of 9 people?

    qnorm(.9, 630, 61)
    qnorm(.1, 630, 61)
    # My answer is [551.8254, 708.1746]
# Hint: use pnorm() and qnorm().



####################################################################################
# IST Chapter 7, Exercise 7.1
#
# The file "pop2.csv" contains information associated to the blood pressure
# of an imaginary population of size 100,000:
# http://pluto.huji.ac.il/~msby/StatThink/Datasets/pop2.csv
#
# Variables: id, sex, age, bmi, systolic, diastolic, group
#
# Our goal is to investigate the sampling distribution of the sample average
# of the variable "bmi". We assume a sample of size n = 150.
#
# 1. Compute the population average of the variable "bmi".
        mean(pop2$bmi)
        # The mean is 24.98446

# 2. Compute the population standard deviation of the variable "bmi".
    sd(pop2$bmi)
    # The population standard deviation is "bmi" column is 4.188511

# 3. Compute the expectation of the sampling distribution for the sample
#    average of the variable.

        bmi_samp <- sample(pop2$bmi, 150)
        mean(bmi_samp)
      # The expectation mean is 25.26796

# 4. Compute the standard deviation of the sampling distribution for the
#    sample average of the variable.

    sd(bmi_samp)
    # The expected standard deviation is 4.436131

# 5. Identify, using simulations, the central region that contains 80% of
#    the sampling distribution of the sample average.

    replicate(100,
                { 
                    bmi_samp <- sample(pop2$bmi, 150)
                    mean_samp <- mean(bmi_samp)
                    quantile(bmi_samp, c(0.1,0.9))
                }
            )

# 6. Identify, using the Central Limit Theorem, an approximation of the
#    central region that contains 80% of the sampling distribution of the
#    sample average.

    qnorm(c(0.1,0.9),mean(bmi_samp),sd(bmi_samp)) 
    # The region is [19.58282, 30.95308] for 1 sample



pop2 <- read_csv("http://pluto.huji.ac.il/~msby/StatThink/Datasets/pop2.csv")

# Hint: for (5), use replicate() to draw many samples of size 150,
# compute the mean of bmi for each, then use quantile().
# For (6), use qnorm() with the expectation and sd from (3) and (4).

