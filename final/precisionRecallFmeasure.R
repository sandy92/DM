accuracy <- sum(diag(x))/sum(x)
#precision = true positive / true positive + false positive 
#precision can be omly for each class in multiclass problem

precisionVector = numeric() #empty vector 
for (i in 1:nrow(x)) {
  precisionVector <- c(precisionVector,x[i,i]/sum(x[i,]))
}

#recall = true positive / true positive + false negative 
recallVector = numeric() #empty vector 
for (i in 1:ncol(x)) {
  recallVector <- c(recallVector,x[i,i]/sum(x[,i]))
}

#f Measure = 2rp / r+p
fMeasureVector = (2 * recallVector * precisionVector)/(recallVector+precisionVector)
