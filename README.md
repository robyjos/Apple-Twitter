#Apple Twitter – Text Analytics

#Dataset

* Dataset consists of loosely structured tweets from Apple Twitter.
* The tweets are rated from five categories of sentiment expressed by users towards Apple, i.e.
1. Strongly Negative (-2)
2. Negative (-1)
3. Neutral (0)
4. Positive (+1)
5. Strongly Positive (+2)

#Objective

* Develop predictive model to predict negative sentiment of Apple twitter data.

#Analysis

* Pre-Process the tweets to convert them into plain text structure form using Bag of Words and Stemming approach.
* Built CART model using "negative" dependent variable to predict negative sentiment. Achieved 87% prediction accuracy.
* The accuracy can be improved by building randomForest model but it will be less interpretable than CART model.

#Conclusion

* The predictive model developed with just 1181 observations can now help Apple predict negative sentiments for future tweets. 
