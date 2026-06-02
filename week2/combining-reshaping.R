library(tidyverse)

####################################################################################
# 12.2.1. Exercise 2
# Compute the rate for table2, and table4a + table4b. You will need
# to perform four operations:
#   1. Extract the number of TB cases per country per year.
#   2. Extract the matching population per country per year.
#   3. Divide cases by population, and multiply by 10000.
#   4. Store back in the appropriate place.

# Which representation is easiest to work with? Which is hardest? Why?
# Add your answer as a comment.

## table2
# 1)
table2 %>% pivot_wider(names_from = type, values_from = count) %>% 
select(-population) %>% pivot_wider(
                        names_from = year, 
                        values_from = cases)

# 2)
table2 %>% pivot_wider(names_from = type, values_from = count) %>% 
select(-cases) %>% pivot_wider(
                        names_from = year, 
                        values_from = population)

# 3) and 4)
new_table2 <- table2 %>% 
pivot_wider(names_from = type, values_from = count) %>% 
mutate (case_per_pop = cases/population * 10000)

## table4a + table4b

# Questions 1 and 2 are already solved since they're both pivot tables

# 3) and 4)
case_table <- rename(table4a, case_1999 = '1999', case_2000 = '2000')
pop_table <- rename(table4b, pop_1999 = '1999', pop_2000 = '2000')

pop_join_case <- inner_join(case_table, pop_table, by = "country")

pop_join_case <- pop_join_case %>% mutate(case_per_pop_2000 = case_2000/pop_2000 * 10000, case_per_pop_1999 = case_1999/pop_1999 * 10000)


# My answer: the table4a and table4b are easier to work with because those tables separately are pivot tables that answer
# the first 2 questions. Even though I had to join them to them to do to the last 2 questions, it wasn't difficult to compute. 


####################################################################################
# 12.3.3 Exercise 1
# 1. Why are pivot_longer() and pivot_wider() not perfectly symmetrical?
# Carefully consider the following example:
stocks <- tibble(
  year   = c(2015, 2015, 2016, 2016),
  half  = c(   1,    2,     1,    2),
  return = c(1.88, 0.59, 0.92, 0.17)
)

# My Answer: The reason I think that the functions are not perfectly symmetrical is because 
# the data is not in the form of a m by m matrix
stocks %>% 
  pivot_wider(names_from = year, values_from = return) %>% 
  pivot_longer(`2015`:`2016`, names_to = "year", values_to = "return")

# (Hint: look at the variable types and think about column names.)
# pivot_longer() has a names_ptypes argument, e.g.  names_ptypes = list(year = double()). 
# What does it do? Add your answer as a comment.

# My answer: What the code above do is make a pviot table where the years become new columns 
# with the returns becoming the values per each half. Then, the pivot_longer makes a new pivot table 
# with 2 new columns "year" and "return" where each row displays a half with both years in new unique columns
# with its respective return

####################################################################################
# 12.3.3 Exercise 3
# What would happen if you widen this table? Why? 
# How could you add a new column to uniquely identify each value?
#  Add your answers as a comment.
people <- tibble(
  ~name,             ~names,  ~values,
  #-----------------|--------|------
  "Phillip Woods",   "age",       45,
  "Phillip Woods",   "height",   186,
  "Phillip Woods",   "age",       50,
  "Jessica Cordero", "age",       37,
  "Jessica Cordero", "height",   156
)

# My answer: It depends how you widen it. If you widen this table by name,
# both names will be columns, and the characterisics (names) will be columns. Vice versa if the widening by characteristic

# I would widen by characteristic (names), so that once reading from left to right, we can see which characteristic
# that each height and weight represent

people %>% pivot_wider(names_from = names, values_to = values)