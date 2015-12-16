#install.packages(e1071,dependencies = TRUE)
library(e1071)
library(class)

mydata<-read.csv("data.csv",header=TRUE)
mydata<-read.csv("data.csv",na.strings = "null",header = TRUE)
set.seed(05713)
index<-sample(2,nrow(mydata),replace=TRUE,prob=c(0.8,0.2))
trainData <- mydata[index==1,]
testData <- mydata[index==2,]
summary((trainData))
classifier<-naiveBayes(trainData[,c("cast.1","director.1","producer.1","writer.1")],trainData[,"genres.1"])
classifier
x<-table(predict(classifier,testData[,"genres.1"]),testData[,"genres.1"])
i#nstall.packages("caret")
library(caret)
confusionMatrix(x)
#detach("package:caret",unload = TRUE)
