Introduction to Data Mining
---------------------------
Individual Project 1: Classification
---------------------------
How to run:
The results can be generating by calling the "classificationResults" with the algorithm name and the data on which the classification will be performed.

Usage: classificationResults(algo, d) where "algo" is the algorithm and "d" is the data. E.g., classificationResults("C45",iris)

The classification is performed on two data sets (iris and life expectancy) and uses one of the following algorithms(these exact values are passed into the function for the "algo" parameter):
1. C45
2. NaiveBayes
3. KNN
4. Ripper
5. Oblique

P.S. - Give the appropriate file path for life expectancy data set to "lifeExpectancyFilePath" variable at the beginning of the file.

In the confusion matrix, “p::” denotes the predicted class and “a::” denotes the actual class.
