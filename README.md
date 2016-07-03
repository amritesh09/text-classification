# text-classification
This is the implementation of text classification 
using improved Naive Bayes approach.

Text classification: Text classification is one of the major challenges 
being faced. Given a set of articles and classes to which tehy belong, the purpose
is to classify new articles accurately.

There are sevaral problems in applying Naive Bayes approach to this:
1. Ignoring the frequency of the words.

2. Ignoring the semantics of the data.

3. Inherent error probability involved in Bayes
approach.

4. Equal importance to all words.

5. Incorporation of Negative evidence i.e.
evidence from words that do not occur in the
document. 




We propose the following enhancements to it:

1. First, we exclude the negative evidence from the
model i.e. we do not consider the absence of a word
having any effect on classification of a document.
We actually get better accuracy than the traditional
model since in text classification presence of a
word is a much more important characteristic than
its absence.

2. Second, we remove all “stop words” from the
feature vector. Stop words are those which have no
relation to the category of data. They are usually
filtered out for most Natural Language Processing
applications.

3. Third, we do not treat each word similarly. There
are some words that play a key role in text
classification. Throughout this paper, we call them
“golden words”. These are those words which have
a very high frequency of occurrence in one class but
very low in all other classes. For example the word
“speed” occurs much more times in class “autos”
than any other class. We give very high weightage
to these words for our decision of class.

We used the
20newsgroup dataset available through UCI data
repository. For this experiment, we have picked up
a total of 7230 articles belonging to 8 newsgroups
corresponding to rec.* and talk.*.

We implemented
multi-variate Naïve Bayes algorithm in MATLAB
to classify each article into one of the newsgroup
categories. We generated the training and test data
to perform 5-fold cross validation by randomly
dividing our data into 5 equal sized splits. 

We
trained on each possible combination of 4 splits and
tested on the remaining one. 
The average accuracy with our approach was *99%*.

For more details, refer to [Text Classification:
Improved Naive Bayes Approach] (https://www.academia.edu/24963412/Text_Classification_Improved_Naive_Bayes_Approach)
