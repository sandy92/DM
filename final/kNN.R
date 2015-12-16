
#install.packages("caret")
library(caret)
#install.packages("e1071")
library(e1071)
#install.packages("klaR")
library(klaR)
#install.packages("RWeka")
library(RWeka)
#install.packages("class")
library(class)
#install.packages("cluster")
library(cluster)
#install.packages("ROCR")
library(ROCR)
#install.packages("ggplot2")
library(ggplot2)
#install.packages("rpart")
library(rpart)
#install.packages("randomForest")
library(randomForest)

set.seed(05713)
movie<- read.csv("data.csv")
  
  temp_data = movie
  
  #View(movies)
  #View(temp_data)
  
  partition = sample(1:nrow(temp_data), size=0.8*nrow(temp_data))
  
  # Split data into train and test
  train_data = temp_data[partition,]
  
  test_data = temp_data[-partition,]


# grow tree 
 


  modelkNN <- IBk(genres.1~.,train_data[,c("cast.1","director.1","genres.1","genres.2","genres.3","genres.4","producer.1","writer.1")],control = Weka_control(K = 100, X = TRUE))     #k is taken as 15. Can be taken as 4, 5, 6 etc.
  kNNpred<-predict(modelkNN,test_data[,c("cast.1","director.1","genres.1","genres.2","genres.3","genres.4","producer.1","writer.1")])
  summary(kNNpred)
  
  
  
  confusionMatrix(kNNpred,test_data$genres.1)
  x<-confusionMatrix(kNNpred,test_data$genres.1)

confusion<-as.table(x)

  overall.accuracy <- x$overall['Accuracy']
 
          
  precisionVector = numeric() #empty vector 
  for (i in 1:ncol(confusion)) {
    precisionVector <- c(precisionVector,confusion[i,i]/sum(confusion[i,]))
  }
  
  
  
  #recall = true positive / true positive + false negative 
  recallVector = numeric() #empty vector 
  for (i in 1:ncol(confusion)) {
    recallVector <- c(recallVector,confusion[i,i]/sum(confusion[,i]))
  }
  
  #f Measure = 2rp / r+p
  fMeasureVector = (2 * recallVector * precisionVector)/(recallVector+precisionVector)


precisionVector
recallVector
fMeasureVector


#Detaching packages


detach("package:ggplot2", unload=TRUE)
detach("package:caret", unload=TRUE)
detach("package:class", unload=TRUE)
detach("package:RWeka", unload=TRUE)
detach("package:datasets", unload=TRUE)
detach("package:cluster", unload=TRUE)
detach("package:ROCR", unload=TRUE)
detach("package:e1071", unload=TRUE)
detach("package:rpart", unload=TRUE)
detach("package:randomForest", unload=TRUE)
