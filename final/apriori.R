library(arules) # used for apriori

getUniqueSortedRules <- function(rules) {
  sm <- is.subset(rules,rules)
  sm[lower.tri(sm,diag = T)] <- NA
  index = colSums(sm, na.rm = T) >= 1
  rules[!index]
}

# binary data
im <- read.csv("data_new.csv",na.strings = "null")
set.seed(05713)
index<-sample(nrow(im),10000)
j <- im[index,]
rownames(j) <-  j[,1]
j <- j[,-1]
cn <- c("cast.1","cast.2","cast.3","cast.4","director.1","director.2","director.3","director.4","producer.1","producer.2","producer.3","producer.4","writer.1","writer.2","writer.3","writer.4")

l5 <- as(j[,cn],"transactions")

l3.better <- apriori(l5,
              control = list("verbose"=F),
              parameter = list(support=0.0005,confidence=0.1,minlen=4),
              appearance = list(default="both")
)
l3.sorted <- sort(l3.better, by="lift")
l3.uniqueSorted <- getUniqueSortedRules(l3.sorted)
rules <- l3.uniqueSorted
inspect(rules)