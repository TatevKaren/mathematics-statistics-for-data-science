#--------------------------------------------------------------------------- 
#Principal Component Analysis 
#--------------------------------------------------------------------------- 
pca.data = prcomp(data_log10,scale = F)
pca.dataScale = prcomp(data_log10,scale = T) #with scaling
#biplots
biplot(pca.data, cex = 0.6)
biplot(pca.dataScale, cex = 0.6)
#Number of PC's

#--------------------------------------------------------------------------- 
#1:"Elbow Rule"
#--------------------------------------------------------------------------- 

eig = eigen(cor(data_log10))
screeplot(pca.dataScale, type="l", npcs = 9, main = NULL)
  pve = rep(NA, dim(data_log10)[2]) # proportion of variance explained
  for(i in 1:9)
  {
    pve[i] = print(sum(eig$values[1:i])/9)
  }
  eig$values
  pve
  
#--------------------------------------------------------------------------- 
#2: "Including PC's to explain 80% of total variation" 
#--------------------------------------------------------------------------- 
pca.variance <- eig$values 
round(sum(pca.variance[1:5])/sum(pca.variance),digits=2) #82%
round(sum(pca.variance[1:6])/sum(pca.variance),digits=2) 

#--------------------------------------------------------------------------- 
#3: "Kaiser rule"
#--------------------------------------------------------------------------- 
round(pca.variance,digits=2)
mean(pca.variance) #only 3 first PCs have eigen values > 1 #interpretation of PC's
#barplots of PC's
par(mfrow=c(3,3))
  barplot(pca.dataScale$rotation[,1],col=2,main='Pr.Comp1',
          ylim = c(-0.7,0.7),cex.names=0.6)
  barplot(pca.dataScale$rotation[,2],col=3,main='Pr.Comp2',
          ylim = c(-0.7,0.7),cex.names=0.6)
  barplot(pca.dataScale$rotation[,3],col=4,main='Pr.Comp3',
          ylim = c(-0.7,0.7),cex.names=0.6)

#--------------------------------------------------------------------------- 
#Correlation matrix of varaibles and PC's
#--------------------------------------------------------------------------- 
cor = pca.dataScale$rotation%*%matrix(diag(pca.dataScale$sdev), ncol=9, nrow=9) round(cor,digits=3)
#PC scores
PC1PC2.scores <- round(pca.dataScale$x[,1:2],digits = 3) row.names(PC1PC2.scores) <- NULL
PC1PC2.scores <- cbind.data.frame(city_names, PC1PC2.scores)
PC1.rank <- PC1PC2.scores[order(PC1PC2.scores[,2],decreasing = TRUE),c(1,2)] PC1.rank
PC2.rank <- PC1PC2.scores[order(PC1PC2.scores[,3],decreasing = TRUE),c(1,3)] PC2.rank
