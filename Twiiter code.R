
tweets = read.csv("tweets.csv", stringsAsFactors=FALSE)							# Read in the data 


str(tweets)																		# Check structure of data


tweets$Negative = as.factor(tweets$Avg <= -1)								    # Create a new dependent variable


table(tweets$Negative)															# Check new variable outcomes


install.packages("tm")															# Install tm package														
library(tm)
install.packages("SnowballC")													# Install SnowballC package
library(SnowballC)

 
corpus = Corpus(VectorSource(tweets$Tweet))										# Create Corpus


corpus																			# Check Corpus


corpus[[1]]


corpus = tm_map(corpus, tolower)												# Convert the tweets to lower case


corpus = tm_map(corpus, PlainTextDocument)										# Convert tweets to plain text


corpus = tm_map(corpus, removePunctuation)										# Remove punctuations from the tweets

 
stopwords("english")[1:10]														# Check stop words


corpus = tm_map(corpus, removeWords, c("apple", stopwords("english")))			# Remove stop words and "apple" word from the tweets

 

corpus = tm_map(corpus, stemDocument)											# Stem document



frequencies = DocumentTermMatrix(corpus)										# Create matrix
frequencies																		# Check frequencies 


inspect(frequencies[1000:1005,505:515])											# Inspect the matrix


findFreqTerms(frequencies, lowfreq=20)											# Check for sparsity


sparse = removeSparseTerms(frequencies, 0.995)									# Remove Sparse terms
sparse


tweetsSparse = as.data.frame(as.matrix(sparse))									# Convert sparse to a data frame


colnames(tweetsSparse) = make.names(colnames(tweetsSparse))						# Make variable names R-friendly


tweetsSparse$Negative = tweets$Negative											# Add the dependent variable


library(caTools)																# Load caTools package
set.seed(123)																	# Set the seed for sample


split = sample.split(tweetsSparse$Negative, SplitRatio = 0.7)					# Split the data into 70/30 ratio


trainSparse = subset(tweetsSparse, split==TRUE)									# Split 70% data in Training set
testSparse = subset(tweetsSparse, split==FALSE)									# Split remaining 30% in Testing set


library(rpart)																	# Load CART packages
library(rpart.plot)


tweetCART = rpart(Negative ~ ., data=trainSparse, method="class")				# Build a CART model
prp(tweetCART)																	# Check the decision trees


predictCART = predict(tweetCART, newdata=testSparse, type="class")				# Evaluate the performance of the model


table(testSparse$Negative, predictCART)
(294+18)/(294+6+37+18)															# Compute CART model accuracy 


table(testSparse$Negative)
300/(300+55)																	# Compute Baseline accuracy


library(randomForest)															# Load randomForest package
set.seed(123)


tweetRF = randomForest(Negative ~ ., data=trainSparse)							# Build a Random forest model



predictRF = predict(tweetRF, newdata=testSparse)								# Make predictions


table(testSparse$Negative, predictRF)
(293+21)/(293+7+34+21)															# Compute randomForest model accuracy

