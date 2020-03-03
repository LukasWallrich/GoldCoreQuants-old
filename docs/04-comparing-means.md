
## Comparing means between conditions or groups

[![](https://i1.pngguru.com/preview/158/556/881/tuts-icon-youtube-alt-png-clipart.jpg?display=inline-block){#id .class width=35 height=35px}](https://youtu.be/L69HyBnvQRQ) &nbsp; [Watch/rewatch this video](https://youtu.be/L69HyBnvQRQ) for an introduction to testing for differences between two means and to the differences between repeated measures and independent samples designs.

[![](https://i1.pngguru.com/preview/158/556/881/tuts-icon-youtube-alt-png-clipart.jpg?display=inline-block){#id .class width=35 height=35px}](https://youtu.be/r96FYPLQ1l0) &nbsp; [Watch/rewatch this video](https://youtu.be/r96FYPLQ1l0) for an introduction to testing for differences between *more than* two means.

### Repeated measures or independent samples

The first question always needs to be whether each participant contributes one or several data points to the dependent variable that is compared. If they contribute only one, we have an *independent samples* or *between-participants* design; if they contribute several, the design is *repeated measures* or *within participants.* In the latter case, we need to account for the relationships between some of the measurements in our analysis.

### Two independent means

Going back to the European Social Survey 2014 data, we might be curious whether social trust differs between men and women in the UK. For that, we should always first calculate the descriptive statistics:


```r
ess <- read_rds(url("http://empower-training.de/Gold/round7.RDS"))
ess <- ess %>% mutate(soctrust = (ppltrst + pplfair + pplhlp)/3)
essUK <- ess %>% filter(cntry=="GB")
essUK %>% group_by(gndr) %>% summarise(mean(soctrust, na.rm = TRUE))
```

```
## # A tibble: 2 x 2
##   gndr   `mean(soctrust, na.rm = TRUE)`
##   <fct>                           <dbl>
## 1 Male                             5.70
## 2 Female                           5.72
```

Those means look very close. Nevertheless, we might want to know how likely we would have been to see a difference this large under the null-hypothesis, i.e. if social trust did not differ between men and women. For that, we can run a t-test.


```r
t.test(soctrust ~ gndr, data=essUK, var.equal = TRUE)
```

```
## 
## 	Two Sample t-test
## 
## data:  soctrust by gndr
## t = -0.2116, df = 2248, p-value = 0.8324
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -0.1601569  0.1289597
## sample estimates:
##   mean in group Male mean in group Female 
##             5.702288             5.717886
```

This is just a special case of a linear model, so we could also use the `lm()` function:


```r
lm(soctrust ~ gndr, data=essUK) %>% summary()
```

```
## 
## Call:
## lm(formula = soctrust ~ gndr, data = essUK)
## 
## Residuals:
## <Labelled double>: Most people can be trusted or you can't be too careful
##     Min      1Q  Median      3Q     Max 
## -5.7179 -1.0512  0.2821  1.2821  4.2977 
## 
## Labels:
##  value                      label
##      0   You can't be too careful
##      1                          1
##      2                          2
##      3                          3
##      4                          4
##      5                          5
##      6                          6
##      7                          7
##      8                          8
##      9                          9
##     10 Most people can be trusted
##  NA(b)                    Refusal
##  NA(c)                 Don't know
##  NA(d)                  No answer
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  5.70229    0.05450 104.623   <2e-16 ***
## gndrFemale   0.01560    0.07372   0.212    0.832    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 1.741 on 2248 degrees of freedom
##   (14 observations deleted due to missingness)
## Multiple R-squared:  1.992e-05,	Adjusted R-squared:  -0.0004249 
## F-statistic: 0.04478 on 1 and 2248 DF,  p-value: 0.8324
```

Both show, as expected, that the difference we observed could easily have been due to chance. If this is the only test you conduct, you would conventionally usually report the result of the t-test, saying: there was no significant difference in social trust between men and women, *t*(2248) = -0.21, *p* = .83.

### Two dependent means

In the ESS data, participants were asked how much they drank when they last drank during a weekday and during a weekend. Here the same participants provided two alcohol measures, so that these data points represent repeated measures. If we ignore that in the analysis, we violate a key assumption of linear models - namely the independence of observations. Therefore, we need to use a paired t-test. But as always, first descriptive statistics.


```r
essUK %>% summarise(weekday = mean(alcwkdy, na.rm=T), weekend=mean(alcwknd, na.rm = T)) %>% mutate(diff = weekend - weekday)
```

```
## # A tibble: 1 x 3
##   weekday weekend  diff
##     <dbl>   <dbl> <dbl>
## 1    36.3    62.4  26.1
```

So there seems to be a large difference in the average amount people drink during a single session on weekdays and weekends. Is the difference statistically significant?


```r
t.test(essUK$alcwknd, essUK$alcwkdy, paired = TRUE)
```

```
## 
## 	Paired t-test
## 
## data:  essUK$alcwknd and essUK$alcwkdy
## t = 13.119, df = 1800, p-value < 2.2e-16
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  22.23332 30.04986
## sample estimates:
## mean of the differences 
##                26.14159
```

The paired t-test - as it says in the output - tests whether the mean of the differences between the two variables is significantly different from 0. We could also specify that condition directly:


```r
t.test(essUK$alcwknd - essUK$alcwkdy, mu = 0)
```

```
## 
## 	One Sample t-test
## 
## data:  essUK$alcwknd - essUK$alcwkdy
## t = 13.119, df = 1800, p-value < 2.2e-16
## alternative hypothesis: true mean is not equal to 0
## 95 percent confidence interval:
##  22.23332 30.04986
## sample estimates:
## mean of x 
##  26.14159
```

### More than two independent means

We might be interested whether levels of life satisfaction differ between the European countries we could reach by ferry from the UK. First, let's look at the descriptive statistics.


```r
essF <- ess %>% filter(cntry %in% c("FR", "ES", "IE", "BE", "NL"))
essF %>% group_by(cntry) %>% summarise(mean(stflife, na.rm = T))
```

```
## # A tibble: 5 x 2
##   cntry `mean(stflife, na.rm = T)`
##   <fct>                      <dbl>
## 1 BE                          7.45
## 2 ES                          6.96
## 3 FR                          6.39
## 4 IE                          6.94
## 5 NL                          7.60
```

There seem to be some differences - but are they statistically significant? Here we actually have two questions:

* do the countries together explain a significant share of the variance in life satisfaction? (*omnibus test*)
* are the levels of life satisfaction in any two countries significantly different from each other? (*pairwise comparisons*)

#### Omnibus test (ANOVA)


```r
#Set the reference level, so that we know what the coefficients mean
essF$cntry <- factor(essF$cntry) %>% relevel(ref = "FR")
lm(stflife ~ cntry, data = essF) %>% summary()
```

```
## 
## Call:
## lm(formula = stflife ~ cntry, data = essF)
## 
## Residuals:
## <Labelled double>: How satisfied with life as a whole
##     Min      1Q  Median      3Q     Max 
## -7.6017 -0.9646  0.3983  1.3983  3.6054 
## 
## Labels:
##  value                  label
##      0 Extremely dissatisfied
##      1                      1
##      2                      2
##      3                      3
##      4                      4
##      5                      5
##      6                      6
##      7                      7
##      8                      8
##      9                      9
##     10    Extremely satisfied
##  NA(b)                Refusal
##  NA(c)             Don't know
##  NA(d)              No answer
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  6.39456    0.04612 138.663   <2e-16 ***
## cntryBE      1.05711    0.06651  15.893   <2e-16 ***
## cntryES      0.57006    0.06512   8.753   <2e-16 ***
## cntryIE      0.54832    0.06192   8.856   <2e-16 ***
## cntryNL      1.20711    0.06516  18.526   <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 2.016 on 9896 degrees of freedom
##   (19 observations deleted due to missingness)
## Multiple R-squared:  0.04125,	Adjusted R-squared:  0.04086 
## F-statistic: 106.4 on 4 and 9896 DF,  p-value: < 2.2e-16
```

Here we just want to see whether the country variable explains a significant share of the variance. That is shown by the last line, so that we would report: There was an overall effects of country on life satisfaction, *F*(4, 9869) = 106.4, *p*<.001.

If you are so inclined, note that this is identical to a one-way ANOVA. To see that, you can replace summary() by car::Anova() - however, this is only truly essential if you are a psychologist, most other disciplines prefer the plain linear models when they suffice.


```r
lm(stflife ~ cntry, data = essF) %>% car::Anova()
```

```
## Anova Table (Type II tests)
## 
## Response: stflife
##           Sum Sq   Df F value    Pr(>F)    
## cntry       1730    4  106.45 < 2.2e-16 ***
## Residuals  40218 9896                      
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

#### Pairwise comparisons

Now that we know that some of the countries are different, we will want to locate the differences. That is where pairwise t-tests come in. 


```r
pairwise.t.test(essF$stflife, essF$cntry, p.adjust.method = "bonferroni")
```

```
## 
## 	Pairwise comparisons using t tests with pooled SD 
## 
## data:  essF$stflife and essF$cntry 
## 
##    FR      BE      ES      IE     
## BE < 2e-16 -       -       -      
## ES < 2e-16 2.4e-12 -       -      
## IE < 2e-16 1.0e-14 1.00    -      
## NL < 2e-16 0.24    < 2e-16 < 2e-16
## 
## P value adjustment method: bonferroni
```

This gives us *p*-values for all tests, that are adjusted for the fact that we are doing many (i.e. 10) comparisons and thus running a greater risk of getting a false positive. The bonferroni adjustment, selected here, multiplies each *p*-value by the number of comparisons, unless the resulting value would exceed 1 and thus be an impossible probability.

Combining this with the descriptive statistics, we can say, for instance, that the people in the Netherlands and Belgium are more satisfied with life than those in any of the other countries, but that their satisfaction levels do not differ significantly from each other.

### More than two means from repeated measures

Here I will revert to the simulated example from the video linked above. In that, the effect of four conditions during studying on test score was tested, namely whether participants were exposed to instrumental music, vocal music, white noise or silence.



Note that the data for repeated measures analaysis in R generally needs to be formatted in a way that each row shows one observation rather than multiple observations from one participant ("long" format). If you have data in a "wide" format, you can reshape it with the `gather()` function.

To analyse whether there are differences between the conditions, as always, we start with descriptive statistics.

```r
noiseData %>% group_by(condition) %>% summarise(mean(score))
```

```
## # A tibble: 4 x 2
##   condition    `mean(score)`
##   <chr>                <dbl>
## 1 instrumental          11.6
## 2 silence               13.0
## 3 vocals                10.8
## 4 whiteNoise            13.5
```

It looks like there are some differences, but to be able to judge statistical significance, we would again be interested in omnibus tests and then pairwise comparisons.

#### Omnibus test

Testing whether the conditions make a difference is a little bit harder with repeated measures because the observations are not independent. Therefore, we need to run a model that takes into account the relationships between the observations taken from a single participant. This does not work with `lm()`; instead we need to use an additional package that allows for multi-level modeling where some observations are clustered together, `lme4` is the most frequently used such package for this purpose.

In the case of repeated measures, we were comparing our model with the group variable as a predictor implicitly to the model that only has the overall mean as a predictor (that is what the `lm()` F-test is doing). Here, the null model uses each participant's own overall mean as the prediction for their performance in any one condition. We need to set up that null model explicitly and then compare it to the model that considers groups. 


```r
#install.packages(lme4)
library(lme4)
```

```
## Loading required package: Matrix
```

```
## 
## Attaching package: 'Matrix'
```

```
## The following objects are masked from 'package:tidyr':
## 
##     expand, pack, unpack
```

```
## Registered S3 methods overwritten by 'lme4':
##   method                          from
##   cooks.distance.influence.merMod car 
##   influence.merMod                car 
##   dfbeta.influence.merMod         car 
##   dfbetas.influence.merMod        car
```

```r
#Set reference level explicitly
noiseData$condition <- noiseData$condition %>% factor() %>% relevel("silence")

#Run null model - predicting only an individual intercept per participant
model0 <- lmer((score ~ (1 | participantID)),	data = noiseData)

#Run hypothesized model - adding the groups as a predictor
model1 <- lmer((score ~ condition + (1 | participantID)),	data = noiseData)

#Comparing the two models
anova(model0, model1)
```

```
## refitting model(s) with ML (instead of REML)
```

```
## Data: noiseData
## Models:
## model0: score ~ (1 | participantID)
## model1: score ~ condition + (1 | participantID)
##        Df    AIC    BIC  logLik deviance  Chisq Chi Df Pr(>Chisq)    
## model0  3 480.29 488.10 -237.14   474.29                             
## model1  6 447.31 462.94 -217.66   435.31 38.978      3  1.754e-08 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

Here we can see that the hypothesised model showed a significantly better fit. This is tested with a $\chi^2$-test, which we will look at further later in the course.

#### Pairwise comparisons

Now that we know that there is a difference between some of the conditions, we will want to know which are different. For that, we can again run pairwise t-tests; we just need to specify that they are run on paired data by setting `paired = TRUE`.


```r
pairwise.t.test(noiseData$score, noiseData$condition,	p.adj = "bonferroni", paired=TRUE)
```

```
## 
## 	Pairwise comparisons using paired t tests 
## 
## data:  noiseData$score and noiseData$condition 
## 
##              silence instrumental vocals 
## instrumental 0.045   -            -      
## vocals       8.2e-06 0.423        -      
## whiteNoise   1.000   0.001        2.0e-05
## 
## P value adjustment method: bonferroni
```

This indicates that the scores of participants in the white noise and silence conditions were not significantly different from each other, while the other comparisons were significant.



