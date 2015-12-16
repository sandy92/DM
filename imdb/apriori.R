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
#k <- cbind(as.vector(j$cast.1),as.vector(j$cast.2),as.vector(j$cast.3),as.vector(j$cast.4))
cn <- c("cast.1","cast.2","cast.3","cast.4","director.1","director.2","director.3","director.4","producer.1","producer.2","producer.3","producer.4","writer.1","writer.2","writer.3","writer.4")
#cn <- c("cast.1","cast.2","cast.3","director.1","director.2","producer.1","producer.2","writer.1","writer.2")
#k <- cbind(sapply(j[,cn], function(x) as.vector(x)))
#k <- cbind(as.vector(j[,"cast.1"]),as.vector(j[,"cast.2"]),as.vector(j[,"cast.3"]),as.vector(j[,"cast.4"]),as.vector(j[,"director.1"]),as.vector(j[,"director.2"]),as.vector(j[,"director.3"]),as.vector(j[,"director.4"]),as.vector(j[,"producer.1"]),as.vector(j[,"producer.2"]),as.vector(j[,"producer.3"]),as.vector(j[,"producer.4"]),as.vector(j[,"writer.1"]),as.vector(j[,"writer.2"]),as.vector(j[,"writer.3"]),as.vector(j[,"writer.4"]))
#k <- as.vector(k)
#k <- unique(k)
#l <- matrix(0,nrow(j),length(k))
#rownames(l) <- rownames(j)
#colnames(l) <- k

#count=0
#allLevels <- levels(factor(unlist(j[,cn])))
#t1 <- do.call(cbind, lapply(j[,cn], function(x) table(sequence(nrow(j[,cn])), factor(x, levels = allLevels))))
#l2 <- (t(rowsum(t(t1), group = rownames(t(t1)))) > 0)
#rownames(l2) <- rownames(j)
#j <- apply(j[,cn],1, function(x) x[!is.na(x)])

#for(x1 in rownames(l)) {
#  for(y1 in j[[x1]]) {
#    count=count+1
   #temp <- as.character(j[x1,y1])
    #if(!is.na(temp))
  #    l[x1,temp] <- 1
    #if(!is.na(j[x1,y1]))
    #l[x1,y1] <- 1
      
#    print(count)
#  }
#}

# which(l["167260",]==1)

#l1 <- as.data.frame(l)
#l2 <- sapply(l1,as.logical)

#l3 <- merge(rownames(l),l2,by="row.names")
#l3 <- l3[,2:(ncol(l3)-1)]

#l4 <- sapply(l3,as.numeric)
#l5 <- l3[,2:ncol(l3)]

l5 <- as(j[,cn],"transactions")

l3.better <- apriori(l5,
              control = list("verbose"=F),
              parameter = list(support=0.0005,confidence=0.1,minlen=4),
              appearance = list(default="both")
)
l3.sorted <- sort(l3.better, by="lift")
l3.uniqueSorted <- getUniqueSortedRules(l3.sorted)
rules <- l3.uniqueSorted 

#inspect(l3.sorted)

#inspect(l3.better)
inspect(rules)