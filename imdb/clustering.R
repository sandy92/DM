library(ggplot2)
#install.packages("StatMatch")
#install.packages("vegan")
library(vegan) # used for jaccard
library(StatMatch)
library(plyr) # used for rename
library(arules) # used for apriori
library(cluster) # used for k mediods

set.seed(1890)

data("movies")

a <- movies[1:10,]

b <- movies[1:500,1:6]

#c <- daisy(b, metric = "gower")
distance <- gower.dist(b)

fit <- cmdscale(distance, eig = TRUE, k = 2)
x <- fit$points[, 1]
y <- fit$points[, 2]

plot(x, y)

data <- data.frame(x=as.vector(x),y=as.vector(y))

km <- kmeans(data,8)

plot(data$x,data$y,col=km$cluster)


b <- a[,c(2,5,18,19,20,21,22,23,24)]
b <- movies[,c(2,5,18,19,20,21,22,23,24)]
b <- movies[,c(1,18,19,20,21,22,23,24)]
b <- unique(b)


print(movies[2,"title"])

mydata <- movies[,c("rating","votes")]


wss <- (nrow(mydata)-1)*sum(apply(mydata,2,var))
for (i in 2:15) wss[i] <- sum(kmeans(mydata, 
                                     centers=i)$withinss)
plot(1:15, wss, type="b", xlab="Number of Clusters",
     ylab="Within groups sum of squares")


# binary data

j <- i[1:1000,1:5]
rownames(j) <-  j[,1]
j <- j[,-1]
k <- cbind(as.vector(j$cast.1),as.vector(j$cast.2),as.vector(j$cast.3),as.vector(j$cast.4))
k <- as.vector(k)
k <- unique(k)
l <- matrix(0,1000,length(k))
rownames(l) <- rownames(j)
colnames(l) <- k

for(x1 in rownames(j))
  for(y1 in colnames(j))
    l[x1,as.character(j[x1,y1])] <- 1

which(l["167260",]==1)

apple <- l

l <- apple
l1 <- as.data.frame(l)
l2 <- sapply(l1,as.logical)

l3 <- merge(rownames(l),l2,by="row.names")
l3 <- l3[,2:(ncol(l3)-1)]



l4 <- l3[1:5,]
l5 <- l3[,2:ncol(l3)]

l3.better <- apriori(l5,
              control = list("verbose"=F),
              parameter = list(support=0.0001,confidence=0.8,minlen=1),
              appearance = list(default="both")
)
l3.sorted <- sort(l3.better, by="lift")
l3.uniqueSorted <- getUniqueSortedRules(l3.sorted)
rules <- l3.uniqueSorted 

inspect(l3.sorted)

inspect(l3.better)
inspect(rules)

getUniqueSortedRules <- function(rules) {
  sm <- is.subset(rules,rules)
  sm[lower.tri(sm,diag = T)] <- NA
  index = colSums(sm, na.rm = T) >= 1
  rules[!index]
}


# clustering
# pam(dist(l7,"binary",upper=T,diag=T),2,diss = T)

