# install packages
install.packages("datasets")
install.packages("RWeka", dependencies = TRUE)
install.packages("oblique.tree", dependencies = TRUE)
install.packages("e1071", dependencies = TRUE)
install.packages("caret", dependencies = TRUE)
install.packages("oblique.tree", dependencies = TRUE)

# Initial variable declaration
lifeExpectancyFilePath <- "./life_expectancy.csv"

myC45 <- function(d) {
  # C45 classifier
  fit <- J48(paste(tail(colnames(d),1),".",sep="~"), data=d)
}

myNaiveBayes <- function(d) {
  # Naive Bayes classifier
  c <- ncol(d)
  fit <- naiveBayes(d[,1:c-1], d[,c])
}

myKNN <- function(d) {
  # kNN classifier
  fit <- IBk(paste(tail(colnames(d),1),".",sep="~"), data=d, control = Weka_control(K=20, X=TRUE))
}

myRipper <- function(d) {
  # Ripper classifier
  c <- ncol(d)
  fit <- train(d[,1:c-1], d[,c], method="JRip",preProcess = c("center", "scale"),tuneLength = 10,trControl = trainControl(method = "cv"))
}

myOblique <- function(d) {
  #Oblique Tree classifier
  fit <- oblique.tree(formula = paste(tail(colnames(d),1),".",sep="~"), data=d, oblique.splits = "only")
}

myPredict <- function(fit, d) {
  #Predictor
  num_col <- ncol(d)
  predictions <- predict(fit, d[,1:num_col-1])
  t <- table(predictions,d[,num_col])
}

myObliquePredict <- function(fit, d) {
  #Oblique Tree Predictor
  num_col <- ncol(d)
  predictions <- predict(fit, d,type="class")
  t <- table(predictions,d[,num_col])
}

divideData <- function(d) {
  # Divide the data set into test and training sets
  set.seed(1)
  num_rows <- nrow(d)
  n <- as.integer(row.names(d))
  s <- sample(num_rows,0.8*num_rows)
  dataset <- list(training=d[s,],test=d[n[!n %in% s],])
}

generateStats <- function(t) {
  # Generates the confusion matrix values for each class of the prediction table
  rnames <- rownames(t)
  cnames <- colnames(t)
  tp <- c()
  fp <- c()
  fn <- c()
  tn <- c()
  for(a in cnames) {
    tp <- c(tp,sum(t[a,a])) #tp
    fp <- c(fp,sum(t[a,cnames[!cnames %in% a]])) #fp
    fn <- c(fn,sum(t[rnames[!rnames %in% a],a])) #fn
    tn <- c(tn,sum(t[rnames[!rnames %in% a],cnames[!cnames %in% a]])) #tn
  }
  x <- data.frame(tp,fp,fn,tn)
  rownames(x) = cnames
  x
}

printConfusionMatrix <- function(t) {
  # Prints the confusion matrix for each class
  cat("\n\n---- Confusion matrices start ----\n\n")
  rnames <- rownames(t)
  for(a in rnames) {
    x <- matrix(t[a,],2,2)
    rownames(x) <- paste("p::",c(a,paste("not", a)), sep="")
    colnames(x) <- paste("a::",c(a,paste("not", a)), sep="")
    print(x)
    cat("\n")
  }
  cat("---- Confusion matrices end ----\n\n")
}

generateMeasures <- function(t) {
  # Generates various measures for each of the class
  rnames <- rownames(t)
  accuracy <- c()
  precision <- c()
  recall <- c()
  fmeasure <- c()
  for(a in rnames) {
    acc <- sum(t[a,"tp"],t[a,"tn"]) / sum(t[a,"tp"],t[a,"tn"],t[a,"fp"],t[a,"fn"])
    accuracy <- c(accuracy,acc)
    prec <- sum(t[a,"tp"]) / sum(t[a,"tp"],t[a,"fp"])
    precision <- c(precision,prec)
    rec <- sum(t[a,"tp"]) / sum(t[a,"tp"],t[a,"fn"])
    recall <- c(recall,rec)
    fm <- (2 * prec * rec)/(prec + rec)
    fmeasure <- c(fmeasure,fm)
  }
  x <- data.frame(accuracy, precision, recall, fmeasure)
  rownames(x) = rnames
  colnames(x) = c("accuracy", "precision", "recall", "fmeasure")
  x
}

totalAccuracy <- function(t) {
  # Total accuracy of the dataset for a given algorithm
  sum(diag(t))/sum(t)
}

classificationResults <- function(algo,d) {
  cat(paste("Classification for",algo))
  # The main function
  dataset <- divideData(d)
  fit <- switch (algo,
    C45 = myC45(dataset$training),
    NaiveBayes = myNaiveBayes(dataset$training),
    KNN = myKNN(dataset$training),
    Ripper = myRipper(dataset$training),
    Oblique = myOblique(dataset$training)
  )
  
  if(algo == "Oblique") {
    predictions <- myObliquePredict(fit, dataset$test)
  }
  if(algo != "Oblique") {
    predictions <- myPredict(fit, dataset$test)
  }

  cat("\n---- prediction table starts ----\n")
  print(predictions)
  cat("\n---- prediction table ends ----\n")
  if(algo == "Oblique") {
    plot(fit, type="uniform");text(fit);
  }
  
  if(algo == "C45") {
    plot(fit)
  }

  st = generateStats(predictions)

  printConfusionMatrix(st)
  
  results = generateMeasures(st)
  
  cat("\n---- measures table starts ----\n\n")
  print(results)
  cat("\n---- measures table ends ----\n")
  cat("\n")
  cat(paste("Total accuracy of",algo,"for the test set:",totalAccuracy(predictions)))
  cat("\n")
  cat("-----------\n")
}

library(datasets)
library(RWeka)
library(e1071)
library(caret)
library(oblique.tree)

# classification on IRIS data set
cat("\nDataset: IRIS\n\n")
d <- iris
classificationResults("Ripper",d)
classificationResults("C45",d)
classificationResults("Oblique",d)
classificationResults("NaiveBayes",d)
classificationResults("KNN",d)

# classification on Life expectancy data set
cat("\nDataset: Life Expectancy\n\n")
d <- read.csv(lifeExpectancyFilePath,header = TRUE)
d <- d[,c(5,7,8)] # considering only male and female expectancy columns, since other columns are redundant

classificationResults("Ripper",d)
classificationResults("C45",d)
classificationResults("Oblique",d)
classificationResults("NaiveBayes",d)
classificationResults("KNN",d)

# detach packages
detach("package:RWeka", unload = TRUE)
detach("package:oblique.tree", unload = TRUE)
detach("package:e1071", unload = TRUE)
detach("package:caret", unload = TRUE)
detach("package:oblique.tree", unload = TRUE)
detach("package:datasets")
