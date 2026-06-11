##################################################################################
# ISRS Exercise 5.20
# Part III. Exercise 5.13 introduces data on shoulder girth and
# height of a group of individuals. The mean shoulder girth is 
# 108.20 cm with a standard deviation of 10.37 cm. The mean height 
# is 171.14 cm with a standard deviation of 9.41 cm. The correlation
# between height and shoulder girth is 0.67
# See textbook for image

# a. Write the equation of the regression line for predicting height.

    #   y = 164.8353 + 0.05826895x

 # b. Intepret the slope and the intercept in this context.

    # Intercept: If an individual has a shoulder width of 0, then the expected height would be 164.8353
    # Slope: As you increase shoulder girth by 1 cm, the height increases by 0.05826895

# c. Calculate R^2 of the regression line for predicting height from 
#    shoulder girth, and interpret in the context of the application. 

    # R^2 : 0.4489
    # Around 455 of the variation can be explained by the model by just knowing 
    # the shoulder girth

# d. A randomly selected student from your class has a shoulder girth 
#    of 100 cm. Predict the height of this student using the model.

    # the height would be 170.6622

# e. The student from part (d) is 160 cm tall. Calculate the residual, 
#    and explain what this residual means.

    # the residual would be -10.6622, meaning that there is an underestimation here

# f. A one year old has a shoulder girth of 56 cm. Would it be 
#    appropriate to use this linear model to predict the height of this child?

    # No, we shouldn't extrapolate because we are just assuming that this relationship stays outside the realm

##################################################################################
# ISRS Exercise 5.29
# The scatterplot and least squares summary below show the relationship
# between weight measured in kilograms and height measured in centimeters
# of 507 physically active individuals
# See textbook for scatterplot.

# Coefficients:
#               Estimate  Std. Error  t value  Pr(>|t|)
# (Intercept)  -105.0113      7.5394   -13.93    0.0000
# height          1.0176      0.0440    23.13    0.0000

# a. Describe the relationship between height and weight.

    # it is a linear relationship between height (predictor) and weight (response)

# b. Write the equation of the regression line. Interpret the slope
#    and intercept in context.

    # y = -105.0113 + 1.0176x

# c.Do the data provide strong evidence that an increase in height 
#   is associated with an increase in weight? State the null and 
#   alternative hypotheses, report the p-value, and state your conclusion.

    # Null Hypothesis: increase in height doesn't result in a change in weight (slope = 0)
    # Alternative Hypothesis: an increase in height results in an increase in weight (slope > 0)

    # the p-value for height is 0, so we would reject the null hypothesis

# d. The correlation coefficient for height and weight is 0.72. 
#    Calculate R^2 and interpret it in context.

    # 0.5184, meaning that around 52% of the variation can be explained 
    # by the model with only height