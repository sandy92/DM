#install.packages("arules",dependencies = TRUE)
#install.packages("arulesViz",dependencies = TRUE)
library(arules)
library(arulesViz)

getUniqueSortedRules <- function(rules) {
  sm <- is.subset(rules,rules)
  sm[lower.tri(sm,diag = T)] <- NA
  index = colSums(sm, na.rm = T) >= 1
  rules[!index]
}

extractTitanicRules <- function(getAll=FALSE) {
  # Titanic Data
  titanic.data <- read.csv("./titanic.csv",header = TRUE)
  
  if(getAll) {
    titanic.rules.all <- apriori(titanic.data,
                                control = list("verbose"=F),
                                parameter = list(support=0,confidence=0,minlen=1)
    )
    rules <- titanic.rules.all
  }
  
  if(!getAll) {
    titanic.rules.better <- apriori(titanic.data,
                      control = list("verbose"=F),
                      parameter = list(support=0.01,confidence=0.90,minlen=1),
                      appearance = list(default="lhs", rhs=c("Survived=No","Survived=Yes"))
    )
    titanic.rules.sorted <- sort(titanic.rules.better, by="lift")
    titanic.rules.uniqueSorted <- getUniqueSortedRules(titanic.rules.sorted)
    rules <- titanic.rules.uniqueSorted 
  }
  rules
}

extractRetailRules <- function(getAll=FALSE) {
  # Retail Data
  retail.data <- read.csv("./retail.csv",header = TRUE)
  retail.data <- retail.data[,colnames(retail.data)[!colnames(retail.data) %in% "TransactionNo"]]
  retail.data <- sapply(retail.data, as.logical)
  
  if(getAll) {
    retail.rules.all <- apriori(retail.data,
                                control = list("verbose"=F),
                                parameter = list(support=0,confidence=0,minlen=1)
    )
    rules <- retail.rules.all 
  }
  
  if(!getAll) {
    retail.rules.better <- apriori(retail.data,
                                   control = list("verbose"=F),
                                   parameter = list(support=0.01,confidence=0.90,minlen=1),
                                   appearance = list(default="lhs", rhs=c("Beverage","Meat","PersonalCare"))
    )
    retail.rules.sorted <- sort(retail.rules.better, by="lift")
    retail.rules.uniqueSorted <- getUniqueSortedRules(retail.rules.sorted)
    rules <- retail.rules.uniqueSorted
  }
  rules
}

extractGotRules <- function(getAll = FALSE) {
  # Game of thrones Data
  got.data = read.csv("./game_of_thrones.csv", header = TRUE)
  
  got.data <- merge(got.data[,2:3],as.data.frame(sapply(got.data[,4:10],as.logical)), by="row.names")
  got.data <- got.data[,2:10]
  
  if(getAll) {
    got.rules.all <- apriori(got.data,
                             control = list("verbose"=F),
                             parameter = list(support=0,confidence=0,minlen=1)
    )
    rules <- got.rules.all 
  }
  
  if(!getAll) {
    got.rules.better <- apriori(got.data,
                                control = list("verbose"=F),
                                parameter = list(support=0.01,confidence=0.90,minlen=1),
                                appearance = list(default="lhs", rhs=c("Survives"))
    )
    got.rules.sorted <- sort(got.rules.better, by="lift")
    got.rules.uniqueSorted <- getUniqueSortedRules(got.rules.sorted)
    rules <- got.rules.uniqueSorted 
  }
  rules
}

r <- extractTitanicRules()
cat("Association Rules for Titanic data\n")
cat("-----------------------------\n")
inspect(r)
plot(r,main="scatter plot for titanic")
plot(r, method="graph", control=list(type="items"), main="graph plot for titanic")
cat("-----------------------------\n")

r <- extractRetailRules()
cat("Association Rules for Retail data\n")
cat("-----------------------------\n")
inspect(r)
plot(r, main="scatter plot for retail")
plot(r, method="graph", control=list(type="items"), main="graph plot for retail")
cat("-----------------------------\n")

r <- extractGotRules()
cat("Association Rules for Game of thrones data\n")
cat("-----------------------------\n")
inspect(r)
plot(r,main="scatter plot for game of thrones")
#plot(r, method="graph", control=list(type="items"),main="graph plot for game of thrones")
cat("-----------------------------\n")

# Uncomment the following code to print all the association rules for the given data sets
#r <- extractTitanicRules(TRUE)
#cat("Association Rules for Titanic data\n")
#cat("-----------------------------\n")
#inspect(r)
#cat("-----------------------------\n")

#r <- extractRetailRules(TRUE)
#cat("Association Rules for Retail data\n")
#cat("-----------------------------\n")
#inspect(r)
#cat("-----------------------------\n")

#r <- extractGotRules(TRUE)
#cat("Association Rules for Game of thrones data\n")
#cat("-----------------------------\n")
#inspect(r)
#cat("-----------------------------\n")

#detach("package:arules", unload=TRUE)
#detach("package:arulesViz", unload=TRUE)