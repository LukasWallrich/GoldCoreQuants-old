# Two more pipes

If you are clear on the pipe operator `%>%` then two more pipes can help you save some typing and write more efficient code. However, neither are critical for this course. All of them require that you load the `magrittr` package explicitly - it is installed as part of the tidyverse, but not loaded.


```r
library(tidyverse)
library(magrittr)
#Example data
constituencies <- read_csv(url("http://empower-training.de/Gold/ConstituencyData2019.csv"), col_types = "_cfddddfffddddfffdfdddd")
```

## Expanding the tidyverse: the exposition pipe (`%$%`)

Inside dplyr pipes, you do not need to use the `$` to access variables within the dataframe. However, that does not work in some base-R functions such as `cor.test()`. For them, `%$%` can expose the variables in a dataframe temporarily (until the end of that command) so that they can be accessed as if they were separate variables in your environment.


```r
#Normal code
cor.test(constituencies$MedianAge, constituencies$ElectionConShare)

#With the exposition pipe
constituencies %$% cor.test(MedianAge, ElectionConShare)
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  constituencies$MedianAge and constituencies$ElectionConShare
## t = 16.454, df = 648, p-value < 2.2e-16
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  0.4862318 0.5949037
## sample estimates:
##      cor 
## 0.542836 
## 
## 
## 	Pearson's product-moment correlation
## 
## data:  MedianAge and ElectionConShare
## t = 16.454, df = 648, p-value < 2.2e-16
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  0.4862318 0.5949037
## sample estimates:
##      cor 
## 0.542836
```

Clearly in this case, the difference is slight but you might find it more readable as well. In other cases, this can spare you from having to save a filtered dataset or otherwise processed dataset into a new variable that you are only using once.


```r
constituencies %>% filter(ContType == "County") %$% 
  cor.test(MedianAge, ElectionConShare)
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  MedianAge and ElectionConShare
## t = 7.4961, df = 366, p-value = 5.003e-13
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  0.2727644 0.4502600
## sample estimates:
##       cor 
## 0.3648222
```

## A somewhat risky time-saver: the assignment pipe (`%<>%`)

Quite often, we want to edit an element in place, which leads to some repetition as you need to specify that you want to put it into the pipe and then save it back in place.


```r
#Normal code
constituencies <- constituencies %>% filter(ConstituencyName != "Chorley")

#With assignment pipe
constituencies %<>% filter(ConstituencyName != "Chorley")
```

The assignment pipe here takes `constituencies`, puts it into the pipeline, and takes the result at the end to save back into `constituencies`. It can be particularly pleasant when you want to apply a function to a single variable, but be careful not to use it accidentally - if you type `%<>%` instead of `%>%` you will create bugs in your code that are not easy to spot.


```r
constituencies$ElectionWon %<>% relevel(ref="Lab")
```

