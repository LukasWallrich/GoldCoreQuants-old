# Reporting the results of statistical tests

Statistical test can often result in a lot of different numbers, but should also result in clear decisions and messages. To facilitate communication, there are sets of guidelines regarding what to report. In this course, we are using the APA guidelines, which are also commonly used in journals in psychology and beyond.

## Essential pieces of information

When reporting inferential statistical tests, always make sure to:

* State whether the results were **significant** (or which results were), and what the exact *p*-values were (typically rounded to three decimal places; if smaller than .001 then reported as < .001). Results with *p*-values between .05 and .1 can be reported as a trend, or as marginally significant, but that should at the very least only be done if the estimated effect size is substantial.
* Report **which test** you carried out, and how it was carried out, if you did anything non-standard (e.g., if *p*-values were simulated). For each test, relevant degrees of freedom and test statistics should be reported, see below.
* Include relevant **descriptive statistics**. If a difference is significant, the reader will want to know how large it was.
* Consider including **effect sizes**, ideally with confidence intervals, so that readers can judge how important the effect is. In reality, there will often be some statistically significant differences between groups, but not all are of a  size that makes them interesting or practically significant.

### What to include for specific tests

* ***t*-tests:** *t*(df) = 1.23, *p* = .012. df stands for degrees of freedom and is shown in the `t.test()`-output. If equal variances are assumed, it is the sample size - 1; otherwise, a bit less. In any case, it describes which *t*-distribution was used to find the *p*-value.
* ***F*-tests** (for ANOVAs and model evaluation): *F*(df1, df2) = 1.23, *p* = .012. Here you have two degrees of freedom, df1 for the model and df2 for the error term. Both are provided in the output of various functions; a simple heuristic for checking whether you got them the right way round is that df2 should be the larger one in the vast majority of cases.
* **Correlations:** *r* = .12, *p* = .012. Given that correlations are bounded by -1 and 1, the leading 0 is always ommitted. If you use Spearman's rank order correlation, it is reported as *rho* = .12; the Greek letter $\rho$ is not typically used.
* **$\chi^2$-tests:** $\chi^2$(df) = 1.23, *p* = .012. Here the degrees of freedom are the number of frequency table rows - 1 * the number of columns - 1. When you `simulate.p.values`, R does not report it because it does not use a fixed $\chi^2$-distribution to look up the *p*-values; you should report it nonetheless as it also gives an indication for the complexity of your table.

**Examples** can be found all over the internet; [this](https://my.ilstu.edu/~jhkahn/apastats.html) might be a good place to start

### Formatting

* Any **Roman letters** (*p, r, F, t, R*) that stand for specific statistics are printed in *italics*
* If a statistic cannot have a value higher than 1 (i.e. for *p, r, rho, R^2*) the **leading 0** should be omitted, i.e. *p* = .04 rather than *p* = 0.04
* If you want to use **Greek letters** (e.g., $\alpha, \beta, \chi, \Delta$) in RMarkdown, the easiest way to get them is to create an inline formula (an expression wrapped into dollar signs) and then type the name of the letter after a \, for instance `\$\\alpha\$` You can use the same approach to show sums, fractions etc., though you would generally not need that in this course. The easiest way to get special characters like Greek letters into Word documents is to Google and copy-paste them.
* To insert a **superscript**, most often ^2, into RMarkdown, type \^2. In Word, there is a superscript button close to the font size selection box.
* When it comes to **descriptive statistics**, *N* typically denotes the number of cases/participants, *M* the mean, and *SD* the standard deviation

### Rounding

It is important to round numbers consistently, partly because too many decimal places might convey a false impression of accuracy (does it help if I report that I spend 2.978536776 hours working on this book today), but also because numbers that do not convey relevant information can quicky clutter up papers and presentations.

In general, test statistics and most descriptive statistics should be rounded to two decimal places (i.e. places after the decimal point) and *p*-values to three decimal places. If that leads to descriptive statistics or regression coefficients to be rounded down to 0.00, that is a strong indication that you should consider changing the scale of the variables (e.g., from hours to minutes). *p*-values by definition can never be equal to 0, so here you need to pay attention to report small *p*-values as < .001 rather than = .000

**How to round? (With one change to what you learned in school)** Cross out all numbers after the last decimal place you want to keep. If the first number you crossed out is less than 5, then you are done. If it more than 5, then increase the last number you keep by 1. If it is 5 and any later number if more than 0, then also increase the last number you keep by one. If it is exactly 5 with only 0s following, then keep the last number unchanged if it is even, and increase it by 1 if it is odd. Some examples:

* 1.2349 --> 1.23
* 1.2351 --> 1.24
* 1.2350 --> 1.24
* 1.2250 --> 1.22 (!)

*Why not just round up 5* like we all learned in school? If we always did that, we would introduce a small but consistent bias into our numbers. Therefore, this would better be randomised. The rule set out here goes towards randomisation without being too complicated, and is therefore what the APA guidelines recommend.




