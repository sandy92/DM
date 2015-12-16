genres <- mysample[,c("genres.1","genres.2","genres.3","genres.4")]
genres <- replace(genres, genres == "null", NA)
uniqueGenres <- unique(as.vector(cbind(as.vector(genres$genres.1),as.vector(genres$genres.2),as.vector(genres$genres.3),as.vector(genres$genres.4))))
uniqueGenres <- uniqueGenres[!is.na(uniqueGenres)]


#kmd <- pam(gower.dist(l4[,2:ncol(l4)]),k = length(uniqueGenres),diss = T)
km<-r
data<-mysample
genres<-uniqueGenres
  final <- matrix(0,length(km$medoids),length(genres))
  colnames(final) <- genres
  
  j <- 0
  for(i in km$clustering) {
    j <- j+1
  #  print(paste(i,j,"---"))
    if(data[j,"genres.1"] != "null"){
      final[i,as.character(data[j,"genres.1"])] = final[i,as.character(data[j,"genres.1"])] + 1
    }
    if(data[j,"genres.2"] != "null"){
      final[i,as.character(data[j,"genres.2"])] = final[i,as.character(data[j,"genres.2"])] + 1
    }
    if(data[j,"genres.3"] != "null"){
      final[i,as.character(data[j,"genres.3"])] = final[i,as.character(data[j,"genres.3"])] + 1
    }
    if(data[j,"genres.4"] != "null"){
      final[i,as.character(data[j,"genres.4"])] = final[i,as.character(data[j,"genres.4"])] + 1
    }
  }
  m <- 0
  for(i in 1:nrow(final)) {
    m <- m + max(final[i,])
    print(max(final[i,])/sum(final[i,]))
  }
  p<-m/sum(final)
  print(p,"Purity")
  print(p)
