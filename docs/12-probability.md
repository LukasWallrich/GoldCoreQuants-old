# Probability in statistics and real life



Much of statistics (namely *inferential* statistics) is about probability. Based on the data we have, is it likely that our hypothesis is true? But much of our other work as scientists, and much of everyday life, is also about probabilities. To be able to evaluate scientific claims, as well as news reporting and a range of other situations in life, it helps to have a basic understanding of probability. By the end of this, you should be able to find an answer to questions like the following:

* How big does a group need to be until it is 95% likely that two of them share a birthday?
* Should it be news that a village in Poland has not seen a single boy being born in a decade?
* How likely is it that someone has breast cancer when they receive a positive mammogram result?

## What are probabilities?

There is still a lot of technical disagreement on definitions in this area. However, for our purposes, we just need to distinguish three concepts: procedures, events and probabilities. *Procedures* are anything that generates data - from rolling a die and writing down the number to conducting a medical test or surveying 500 people and calculating the mean on some outcome. An *event* is the result of a procedure, be that a 3 on a die or a positive result on a medical test. Finally, the *probability* expresses the likelihood with which an unobserved event will occur. Probabilities thereby offer guidance as to a reasonable degree of belief.

Probabilities can be based on experience and inference. I can count how often it rains later in the day when I wake up to a grey sky; if I do that for long enough and calculate the share of days when it rained as a total of all days I observed, this will give me a good guidance regarding the probability of rain. Weather forecasting apps do something a bit more sophisticated, but still quite similar.

Alternatively, we can use a more formal and logical way to find probabilities. This involves counting the number of possible outcomes of our procedure, and the number of possible outcomes that would lead to the event we are interested in. Probabilities are then expressed as fractions, dividing the number of ways in which our specified event can occure by the total number of outcomes. For example, the probability of rolling a 3 with a die is $\frac{1}{6}$, as there are 6 possible outcomes, and only one of them results in a three. Rolling an even numbers, on the other hand, has a probability of $\frac{3}{6}$ (or $\frac{1}{2}$) as there are now 3 out of 6 possible outcomes that lead to the event we are interested in.

Over to you - what is the probability of rolling a number smaller than 5?  <select class='solveme' data-answer='["4/6 or 2/3"]'> <option></option> <option>2/6 or 1/3</option> <option>3/6 or 1/2</option> <option>4/6 or 2/3</option></select>

These fractions can often be expressed more easily by a percentage. The probability of rolling an odd number is $\frac{3}{6}$ or 50%.

What is the probability of pulling a red card from a standard deck of cards, in percent?  <input class='solveme nospaces ignorecase' size='4' data-answer='["50","50%","50 %"]'/>

Finally, probabilities can range from 0 (0 %) to 1 (100 %) - an event with a probability of 0 is impossible, one with a probability of 1 is inevitable. 

## Combining multiple events together

Often we are interested in more than one possible outcome. So what is the probability of rolling an even number *or* a 3 with a die? We already know that it is $\frac{3}{6}$ for an even number and $\frac{1}{6}$ for a 3. So the probability for either of them to occur is $\frac{4}{6}$ - we can add them up. 

However, what is the probability of rolling a 3 *or* an odd number? The probability for rolling an odd number is $\frac{3}{6}$, and the probability for rolling a 3 is $\frac{1}{6}$. Can we add them up? Remember that probabilities are the ways in which the event we are interested in can occur, divided by the total number of outcomes. Here, those are three ways (1, 3 and 5) of the possible six outcomes of rolling a die. Since rolling a 3 satisfies both sides of our *or* statement, we must not double count it.

As a shorthand, we can write $P(A)$ to mean the probability of event A. Formally, the probability of either of two events occuring is
$P(A or  B)=P(A)+P(B)-P(AandB)$

Over to you - what is the probability of getting a King or Queen when you draw a card from a standard deck of cards (52 cards)?  <select class='solveme' data-answer='["8/52 or 15%"]'> <option></option> <option>4/52 or 7.5 %</option> <option>8/52 or 15%</option> <option>16/52 or 30%</option></select>


<div class='solution'><button>I need a hint</button>

Consider the total number of possible results as well as the possible number of ways you can get a King or a Queen

</div>



<div class='solution'><button>Give me the explanation</button>

$P(King)$ is $\frac{4}{52}$ because there are 4 Kings among the 52 cards. Likewise, $P(Queen)$ is $\frac{4}{52}$ because there are 4 Queens. There is no card that is both a King and a Queen, so that we can just add up the probabilities and thus arrive at $\frac{8}{52}$

</div>



One more - what is the probability of getting a red card or a King or Queen when you draw a card from a standard deck of cards (52 cards)?  <select class='solveme' data-answer='["30/52"]'> <option></option> <option>26/52</option> <option>30/52</option> <option>34/52</option></select>


<div class='solution'><button>I need a hint</button>

This time, there is a risk of double-counting. Avoid doing that.

</div>



<div class='solution'><button>Give me the explanation</button>

$P(KingorQueen)$ is $\frac{8}{52}$, while $P(Red)$ $\frac{26}{52}$. However, there are 2 red Kings and 2 red Queens that are counted in both probabilities - therefore, we can get a red card or a King or a Queen in only 30 rather than 34 ways.

</div>


## Looking at independent events

We are always interested in patterns that emerge when we look across multiple events. If we keep on tossing a coin, what is the probability to get two heads in a row? We can again count the number of possible outcomes versus the number of ways in which our event can occur.

<div class="figure" style="text-align: center">
<img src="./images/coins.jpg" alt="Results of two coin tosses" width="100%" />
<p class="caption">(\#fig:img-coins)Results of two coin tosses</p>
</div>



As you can see in the figure, there are four possible outcomes, only one of which results in two heads, so that the probability for that is $\frac{1}{4}$ or 25%. What about four coins in a row turning up head? We know that there is only one way in which that can happen, but how many outcomes are there in total? We have seen that 2 coins result in four outcomes. Now tossing a third coin results in two possibilities for each of these 4 outcomes so far, turning them into 8. Tossing a fourth coin results in 16. (If you can't see the pattern, try to draw out the possibilities - it will help.). So the probability for four heads in a row is $\frac{1}{16}$ or about 6%

The probability of two events both occuring in sequence is $P(A)*P(B)$. That implies that the probability of the same event occuring n times in a row is $P(A)^n$. 

Over to you - if you assume that 50% of babies born are girls, what is the probability of a woman to give birth to three girls in a row?  <select class='solveme' data-answer='["1/8 or 12.5%","1/2 or 50%"]'> <option></option> <option>1/8 or 12.5%</option> <option>1/3 or 33 %</option> <option>1/2 or 50%</option></select>


<div class='solution'><button>Give me the explanation</button>

The probability for the first child to be a girl is 50% ($\frac{1}{2}$). For the second it is 50% as well. If we multiply them, we get 25%($\frac{1}{4}$). The third child again has a 50% chance of being a girl. Multiplying 25% by 50% results in 12.5% ($\frac{1}{8}$). 

</div>


Quite often we are interested in the **likelihood of something occuring at least once,** rather than on every attempt. So we might want to know how likely it is that a family with three children has at least one boy among them. Assuming that gender is binary, that is the same as saying that they do not have three girls. Given that they either have 3 girls or at least one boy, we know that these probabilities add up to 1 (certainty) - such events are known as complementary events. Therefore, the probability of having at least one boy is 1 - 12.5% = 77.5%

This idea that **something happening at least once is the *complement* of it never happening** is a very helpful, as it is much easier to calculate the chance of something never happening across a given number (n) of procedures. It is $P(notA)^n$. We have already discussed this in the context of multiple comparisons. 

Over to you. If the chance of finding a false positive is 5% on each attempt, what is the chance of finding a false positive in at least one of seven tests? For that, you will need a calculator. Note that $x^n$ should be entered as `x^n` in R or the Google search box. Enter your answer in percent, rounded to the nearest whole number: <input class='solveme nospaces ignorecase' size='4' data-answer='["30","30%","30 %"]'/>


<div class='solution'><button>I need a hint</button>

The answer is 100% - the probability of not getting a false positive 7 times in a row.

</div>



<div class='solution'><button>Give me the explanation</button>

The probability of not getting a false positive is 95%, so if we try that 7 times in a row, we get a probability of
$0.95^7=0.70$ of getting *no* false positivives. Given that getting at least one false positive is the complementary event to this, the chances of that are 100% - 70% = 30%

</div>


## Updating our beliefs - Bayes' theorem

What you have looked at so far are the basic rules of probability that are good to remember (and that you will have likely seen in school). So far, we have treated probabilities as something abstract: we think about a situation in the abstract, or run an experiment, and then assign a probability. In reality, that is not how it works. We rather use the probabilities of events to update our present beliefs. For example, if I leave my front door and see that the street is wet, I use that to update my belief (i.e. the probability I believe in) about whether it has rained earlier in the day, but in a way that is more complicated than what we captured so far.

To further explore such an updating of beliefs, we are making quite a far jump to Bayes' theorem - you do not need to remember the formula, but the intution is important. A key part of it are conditional probabilities - the probability of an even given that another event has occured. We have worked with one kind of them extensively - *p*-values. They are the probability of observed data, given that the null hypothesis is true, which can be written as $P(O|H_0)$

What Bayes' theorem reveals is how we can link that probability to the probability we are actually interested in, namely the probability that the hypothesis is true, given the data. In statistics, we often slip from one in the other, but if we think about other examples, it becomes clear that are not the same. For example, $P(StreetWet|Rained)\neq P(Rained|StreetWet)$. With regard to the first part, it is very likely that the street is wet if it has rained. However, whether it is likely that it has rained if the street is wet depends on other factors - and those factors are what Bayes' theorem adds to our thinking. It suggests that

$P(Rained|StreetWet) = \frac{P(StreetWet|Rained)*P(Rained)}{P(StreetWet)}$

So, my belief whether is has rained given that the street is wet should be based on the probability that the street is wet *if* it has rained, but also on the probability I could assign to rain before I got that information, and the probability that the street is wet. If I saw beautiful sunshine through the window, I expected $P(Rained)$ to be very low, so that I would probably not give a high value to $P(Rained|StreetWet)$. Similarly, if the street in front of my house is wet all the time due to a broken pipe, I would not give a high value to $P(Rained|StreetWet)$.

Thinking in this way can help to interpret probabilistic results. A frequently used example (Gigerenzer and Hoffrage, 1995) goes as follows:

>The probability of breast cancer is 1% for women aged forty who participate in routine screening. If a woman has breast cancer, the probability is 80% that she will get a positive mammogram. If a woman does not have breast cancer, the probability is 9.6% that she will also get a positive mammogram. A woman in this age group has a positive mammogram in a routine screening. What is the probability that she actually has breast cancer?


## Further resources

* ADD
