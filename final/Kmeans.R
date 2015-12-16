mydata<-read.csv("data.csv",header=TRUE)
set.seed(05713)
mysample <- mydata[sample(1:nrow(mydata),5000,replace=FALSE),]
#install.packages("fpc")
library('fpc')
library(rgl)
library(cluster)
dx<-daisy(mysample[,c("cast.1","director.1","genres.1","writer.1")],metric = "gower")#37.48%
r<-pam(dx,21,diss = TRUE)
plot3d(mysample[,c("director.1","genres.1","writer.1")],col=r$clustering+1L,aspect = TRUE)


