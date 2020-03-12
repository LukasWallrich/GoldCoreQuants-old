# Importing and describing data

## Importing data into R

Generally, R is a poor choice for data entry, so you will usually import data from spreadsheet software or other sources. That also helps to keep data and analyses apart, and thereby increases transparency.

The most common ways to import data into R are to 

* read tabular data saved as text (such as the common *.csv* files) with the `readr` package
* read Excel files with the `readxl` package 
* read data files from SPSS or SAS with `haven`. 

In these packages, the functions to read data are always `read_x()`, with x replaced by the type of file you want to open. You always need to specify the name of the datafile, with its path (unless it is in the same folder as your .Rmd file), as the first argument of the `read_x()` function. For the path, it can be helpful to start with the dot (`.`), which means: start from the current folder. For example, I often have a data folder within the folder where the .Rmd file is, so that the path would then be `"./data/file.csv"`. Always remember to assign the result of the function (i.e. the data) to a variable using `<-`, otherwise the data is just printed and not saved in R.

The functions that load data from tables need to establish the variable class for each variable. They can either guess (which you will then need to check), or you can provide the classes in the `col_types`-argument. Check `?readr::read_csv` for details. 


```r
#readr is loaded with the tidyverse, but can be loaded separately as well if you don't need the other packages
library(readr)
gapminder <- read_csv("./data/gapminder.csv", col_types = "finnnnnff")

library(readxl)
gapminder <- read_xlsx("./data/gapminder.xlsx") #Here col_types are not defined so that R will guess and print out the results - make sure to check whether the classes are what you would expect

library(haven)
gapminder <- read_sav("./data/gapminder.sav") #SPSS files contain information on the class of each variable, so that col_types do not need to be defined
```

There are shortcuts to quickly get some data into R, which can be helpful if you just want to try something out - all of them only make sense in the Console, not in a .Rmd script. Using the `edit()` function, you can open up a simple spreadsheet to edit and input data, using the `read.table(file="clipboard", sep="\t")`, you can get data you copied in Excel. As with all ways of importing data, remember to assign the result to a variable.



```r
#If you want to edit an existing dataset
gapminder_corrected <- edit(gapminder)

#If you want to type or copy in a new dataset
yourdata <- edit(data.frame())
#The data.frame() function creates an empty dataframe for you to then edit

#If you want to read data from the clipboard
pasted <- read.table(file="clipboard", sep="\t")

#If that data contains variable names in the first row:
pasted <- read.table(file="clipboard", sep="\t", header = TRUE)

#Note that reading data from the clipboard does not always work - if it doesn't, 
#try pasting your data into the window opened with the edit() function
```

## Manipulating data

Once you have imported your data into R, you might need to filter it, sort it, add some new variables, and calculate summaries. The `dplyr` package (part of the `tidyverse`) is designed to make all these steps easier, so we use it extensively during this course. `dplyr` is based on two main ideas: 

* Develop a chain of data manipulation steps that get you towards the desired data, with the steps connected by the `%>%` operator ("pipe"). That removes the need for nested functions or for saving lots of intermediate results.
* Use functions names after natural language verbs to develop code that can be easily understood.

`%>%` takes the argument on the left and places it as the first argument into the function on the right. For example:


```r
x <- c(1,2,3, NA)

#The following two commands are equivalent
mean(x, na.rm = TRUE)
x %>% mean(na.rm = TRUE)
```

```
## [1] 2
## [1] 2
```

The most important `dplyr` functions are:

* `select()`: select specific variables
* `filter()`: filter rows based on condition
* `arrange()`: sort data ascendingly (arrange(desc()) to reverse)
* `mutate()`: create/change variables
* `summarise()`: calculate summary statistics
* `group_by()`: separate data into groups, usually to summarise by group

All functions use a dataframe as their first argument, usually from `%>%`. After that, variables in the dataframe are accessed just with their name (no `$`).

If we want to calculate the average income per capita in 2010 on each continent from the gapminder dataset, we need most of these functions - if you **read the `%>%`-operator as 'then'**, and mentally add 'take' at the very start, you should be able to follow along quite naturally. 

*One thing to note:* you can split R code into multiple lines as long as each line is incomplete. Since the lines here end with `%>%`, R includes the next line into the same command. If that operator was moved to the start of the next line, the code would no longer work.


```r
library(dslabs) #Load the gapminder teaching dataset
gapminder %>% 
  filter(year == 2010) %>%
    mutate(gdpPerCap = gdp/population) %>%
      filter(!is.na(gdpPerCap)) %>% 
      #This filter() removes countries where either gdp or population is missing
        group_by(continent) %>% 
        #group_by() allows for summary statistics to be calculated for each continent separately
          summarise(AvgGdpPerCap_Nations = mean(gdpPerCap), 
                    AvgGdpPerCap_People = sum(gdp)/sum(population)) %>%
              mutate_if(is.numeric, round, 0) %>% 
              #This rounds all numeric variables to 0 decimal places 
              #(beyond expectations for this course)    
                arrange(desc(AvgGdpPerCap_Nations))
```

```
## # A tibble: 5 x 3
##   continent AvgGdpPerCap_Nations AvgGdpPerCap_People
##   <fct>                    <dbl>               <dbl>
## 1 Europe                   15214               14643
## 2 Asia                      8163                3277
## 3 Americas                  6797               16305
## 4 Oceania                   5281               17942
## 5 Africa                    1303                 867
```

*Just as an aside:* consider the differences between the two ways of calculating averages per continent. One focuses on the average of country values, and thus yields the average national income per capita. The other takes population sizes into account and thus yields the average personal income per capita. For most continents, the difference in results is huge. Both approaches are used in the media - so it's always worth looking a little closer at summary statistics.

[![](https://i1.pngguru.com/preview/158/556/881/tuts-icon-youtube-alt-png-clipart.jpg?display=inline-block){#id .class width=35 height=35px}](https://www.youtube.com/watch?v=QtQE-b5iMUQ&list=PLm5BFz6s4ylavu_ef4UaLSHksKUUgWeFe&index=2) &nbsp; For an introduction to dplyr, you can [watch this video](https://www.youtube.com/watch?v=QtQE-b5iMUQ&list=PLm5BFz6s4ylavu_ef4UaLSHksKUUgWeFe&index=2)

## Functions to view and summarise data

When you start with a new dataset, there are some helpful functions to get a first look at the data: `glimpse()`gives a good overview of the variables contained in the dataset, while `head()` and `tail()` print the first and last lines. In the **Console** (but not really within scripts such as .Rmd files), you can also use `View()` to open up the whole dataset. Finally, you can have a look at data in the **Environment** pane in RStudio.


```r
glimpse(gapminder)
head(gapminder, n=5) #n defines number of rows shown
tail(gapminder, n=5)
```

```
## Observations: 10,545
## Variables: 9
## $ country          <fct> Albania, Algeria, Angola, Antigua and Barbuda, Arg...
## $ year             <int> 1960, 1960, 1960, 1960, 1960, 1960, 1960, 1960, 19...
## $ infant_mortality <dbl> 115.40, 148.20, 208.00, NA, 59.87, NA, NA, 20.30, ...
## $ life_expectancy  <dbl> 62.87, 47.50, 35.98, 62.97, 65.39, 66.86, 65.66, 7...
## $ fertility        <dbl> 6.19, 7.65, 7.32, 4.43, 3.11, 4.55, 4.82, 3.45, 2....
## $ population       <dbl> 1636054, 11124892, 5270844, 54681, 20619075, 18673...
## $ gdp              <dbl> NA, 13828152297, NA, NA, 108322326649, NA, NA, 966...
## $ continent        <fct> Europe, Africa, Africa, Americas, Americas, Asia, ...
## $ region           <fct> Southern Europe, Northern Africa, Middle Africa, C...
##               country year infant_mortality life_expectancy fertility
## 1             Albania 1960           115.40           62.87      6.19
## 2             Algeria 1960           148.20           47.50      7.65
## 3              Angola 1960           208.00           35.98      7.32
## 4 Antigua and Barbuda 1960               NA           62.97      4.43
## 5           Argentina 1960            59.87           65.39      3.11
##   population          gdp continent          region
## 1    1636054           NA    Europe Southern Europe
## 2   11124892  13828152297    Africa Northern Africa
## 3    5270844           NA    Africa   Middle Africa
## 4      54681           NA  Americas       Caribbean
## 5   20619075 108322326649  Americas   South America
##                  country year infant_mortality life_expectancy fertility
## 10541 West Bank and Gaza 2016               NA           74.70        NA
## 10542            Vietnam 2016               NA           75.60        NA
## 10543              Yemen 2016               NA           64.92        NA
## 10544             Zambia 2016               NA           57.10        NA
## 10545           Zimbabwe 2016               NA           61.69        NA
##       population gdp continent             region
## 10541         NA  NA      Asia       Western Asia
## 10542         NA  NA      Asia South-Eastern Asia
## 10543         NA  NA      Asia       Western Asia
## 10544         NA  NA    Africa     Eastern Africa
## 10545         NA  NA    Africa     Eastern Africa
```

Next you might want to use summary functions - either in a dplyr `summarise()` function or on their own. For most of them, you can use the `na.rm = TRUE` argument to tell R to ignore missing values (only do that when you have reason to expect that missing values can safely be ignored).


```r
gapminder2010 <- gapminder %>% filter(year==2010)

#Global population
sum(gapminder2010$population, na.rm = TRUE)

#Number of countries included
nrow(gapminder2010)
#To get the number inside dplyr's summarise function, it would have to be
gapminder2010 %>% summarise(countries = n())

#Average (mean) number of children per woman
mean(gapminder2010$fertility, na.rm = TRUE)

#Average (median) number of children per woman
median(gapminder2010$fertility, na.rm = TRUE)

#Highest and lowest fertility rates
max(gapminder2010$fertility)
min(gapminder2010$fertility)

#Countries with highest and lowest fertility.
#There are many ways to look this up - here is a simple dplyr pipe (Note that | means 'or' in the context of logical comparisons and == is needed to test for equality because = just assigns a value)
gapminder2010 %>% 
  filter(fertility == max(fertility) | fertility == min(fertility)) %>% 
    select(country, fertility)
```

```
## [1] 6778331427
## [1] 185
##   countries
## 1       185
## [1] 2.885297
## [1] 2.38
## [1] 7.58
## [1] 1
##        country fertility
## 1 Macao, China      1.00
## 2        Niger      7.58
```
