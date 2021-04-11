rm(list=ls())
graphics.off()    # Close graphs
cat("\014")       # Clear Console 
#loading required packages
library (psych) 
library (CCA) 
library(scatterplot3d)
placesrating = read.csv(file.choose(), header = T) #getting the data 
#---------------------------------------------------------------------------
#Summary statistics
#---------------------------------------------------------------------------
head(placesrating)
city_names = placesrating[,1]
row.names(placesrating) = placesrating[,1] 
placesrating = placesrating[,-1] 
#transformed data
data_log10 = placesrating
data_log10[,c(2,3,4,5,7,8,9)] = log(data_log10[,c(2,3,4,5,7,8,9)])
#---------------------------------------------------------------------------
#Histogram plots with density lines
#---------------------------------------------------------------------------
#i) Untransformed data 
par(mfrow=c(3,3))
hist(placesrating[,1],prob=TRUE,ylim = c(0,0.005),main = NA,xlab = "Climate")
lines(density(placesrating[,1]),col="blue",lwd=2)
hist(placesrating[,2],prob=TRUE,ylim = c(0,0.0003),main = NA,xlab = "Housing Cost")
lines(density(placesrating[,2]),col="blue",lwd=2)
hist(placesrating[,3],prob=TRUE,ylim = c(0,0.0009),main = NA,xlab = "Health Care")
lines(density(placesrating[,3]),col="blue",lwd=2)
hist(placesrating[,4],prob=TRUE,ylim = c(0,0.0015),main = NA,xlab = "Crime")
lines(density(placesrating[,4]),col="blue",lwd=2)
hist(placesrating[,5],prob=TRUE,ylim = c(0,0.0003),main = NA,xlab = "Transport")
lines(density(placesrating[,5]),col="blue",lwd=2)
hist(placesrating[,6],prob=TRUE,ylim = c(0,0.0015),main = NA,xlab = "Education")
lines(density(placesrating[,6]),col="blue",lwd=2)
hist(placesrating[,7],prob=TRUE,ylim = c(0,0.00025),main = NA,xlab = "Arts")
lines(density(placesrating[,7]),col="blue",lwd=2)
hist(placesrating[,8],prob=TRUE,ylim = c(0,0.0007),main = NA,xlab = "Recreation")
lines(density(placesrating[,8]),col="blue",lwd=2)
hist(placesrating[,9],prob=TRUE,ylim = c(0,0.0005),main = NA,xlab = "Economy")
lines(density(placesrating[,9]),col="blue",lwd=2)
#ii) kernel densities of transformed data 
par(mfrow=c(3,3))
hist(data_log10[,1],prob=TRUE,main = NA,xlab = "Climate")
lines(density(data_log10[,1]),col="blue",lwd=2)
hist(data_log10[,2],prob=TRUE,main = NA,xlab = "log(Housing Cost)") 
lines(density(data_log10[,2]),col="blue",lwd=2)
hist(data_log10[,3],prob=TRUE,main = NA,ylim = c(0,1.4),xlab = "log(Health Care)")
lines(density(data_log10[,3]),col="blue",lwd=2)
hist(data_log10[,4],prob=TRUE,main = NA,ylim= c(0,3),xlab = "log(Crime)") 
lines(density(data_log10[,4]),col="blue",lwd=2)
hist(data_log10[,5],prob=TRUE,main = NA,xlab = "log(Transport)")   
lines(density(data_log10[,5]),col="blue",lwd=2)
hist(data_log10[,6],prob=TRUE,main = NA,xlab = "Education")
lines(density(data_log10[,6]),col="blue",lwd=2)
hist(data_log10[,7],prob=TRUE,main = NA,xlab = "log(Arts)") 
lines(density(data_log10[,7]),col="blue",lwd=2)
hist(data_log10[,8],prob=TRUE,main = NA,xlab = "log(Recreation)") 
lines(density(data_log10[,8]),col="blue",lwd=2)
hist(data_log10[,9],prob=TRUE,main = NA,xlab = "log(Economy)") 
lines(density(data_log10[,9]),col="blue",lwd=2)
#Get colnames and rownames for the log transformed data 
colnames(data_log10) = c("Climate", "HousingCost", "HlthCare","Crime","Transp","Educ","Arts", "Recreat","Econ")
rownames(data_log10) = city_names
#Correlation matrix
cor(data_log10)
pairs(data_log10)
round(cor(data_log10),digits = 4) 
#---------------------------------------------------------------------------
#Principal Component Analysis
#---------------------------------------------------------------------------
pca.data = prcomp(data_log10,scale = F) 
pca.dataScale = prcomp(data_log10,scale = T) #with scaling
#biplots
biplot(pca.data, cex = 0.6)
biplot(pca.dataScale, cex = 0.6)
#Number of PC's
#1:"Elbow Rule"
eig = eigen(cor(data_log10))
screeplot(pca.dataScale, type="l", npcs = 9, main = NULL)
pve = rep(NA, dim(data_log10)[2]) # proportion of variance explained
for(i in 1:9)
{
  pve[i] = print(sum(eig$values[1:i])/9)
}
eig$values
pve
#2: "Including PC's to explain 80% of total variation"
pca.variance <- eig$values
round(sum(pca.variance[1:5])/sum(pca.variance),digits=2) #82%
round(sum(pca.variance[1:6])/sum(pca.variance),digits=2)
#3: "Kaiser rule"
round(pca.variance,digits=2)
mean(pca.variance) #only 3 first PCs have eigen values > 1
#interpretation of PC's
#barplots of PC's
par(mfrow=c(3,3))
barplot(pca.dataScale$rotation[,1],col=2,main='Pr.Comp1',
        ylim = c(-0.7,0.7),cex.names=0.6)
barplot(pca.dataScale$rotation[,2],col=3,main='Pr.Comp2',
        ylim = c(-0.7,0.7),cex.names=0.6)
barplot(pca.dataScale$rotation[,3],col=4,main='Pr.Comp3',
        ylim = c(-0.7,0.7),cex.names=0.6)
#Correlation matrix of varaibles and PC's
cor = pca.dataScale$rotation%*%matrix(diag(pca.dataScale$sdev), ncol=9, nrow=9)
round(cor,digits=3)
#PC scores
PC1PC2.scores <- round(pca.dataScale$x[,1:2],digits = 3)
row.names(PC1PC2.scores) <- NULL 
PC1PC2.scores <- cbind.data.frame(city_names, PC1PC2.scores)
PC1.rank <- PC1PC2.scores[order(PC1PC2.scores[,2],decreasing = TRUE),c(1,2)]
PC1.rank
PC2.rank <- PC1PC2.scores[order(PC1PC2.scores[,3],decreasing = TRUE),c(1,3)]
PC2.rank
#---------------------------------------------------------------------------
#Factor Analysis
#---------------------------------------------------------------------------
fa.data =  factanal(data_log10, 3, rotation = "none")
fa.data
fa.dataRot = factanal(data_log10, 3, rotation = "varimax")
fa.dataRot
fa.dataRot
fa.dataRot = factanal(data_log10, 4, rotation = "varimax")
fa.dataRot
fa.dataRot = factanal(data_log10, 2, rotation = "varimax")
fa.dataRot
fa.dataRot = factanal(data_log10, 1, rotation = "varimax")
fa.dataRot
#---------------------------------------------------------------------------
#Canonical Correlation Analysis  
#---------------------------------------------------------------------------
#Arts and Health Care are in one group 
X= data_log10[,c(3,7)]
Y= data_log10[,-c(3,7)]
cor(X)
cor(Y)
cor(X,Y)  
cca.almanac = cc(X,Y)
cca.almanac$cor # 2 canonical Correlations
# there is a substantial correlation between these two groups
# strong relation between groups 0.728 so the first one is important
cca.almanac$xcoef; cca.almanac$ycoef
#Health Care  is negativelyt correlated with Climate and Economy and 
#positively with everything else
#Arts is negatively correlated with Climate and Economy and
#postively  with everything else
plot(-cca.almanac$scores$xscores[,1],-cca.almanac$scores$yscores[,1],
     type="n",xlab="eta1",ylab="phi1")
text(x = -cca.almanac$scores$xscores[,1], y = -cca.almanac$scores$yscores[,1],
     labels = row.names(placesrating), cex=.75)
#the graph verifies the correlation
#we can inyterpret \eta  as  index of Arts
#\phi1 cosits mainly of Housingcost,Educ,Transportation but also Economy and Crime
plot(-cca.almanac$scores$xscores[,2],-cca.almanac$scores$yscores[,2],
     type="n",xlab="eta2",ylab="phi2")
text(x = -cca.almanac$scores$xscores[,2], y = -cca.almanac$scores$yscores[,2],
     labels = row.names(placesrating), cex=.75)
# as we see from the cca correlations the graph proves that we might consider
# second canonical correlation as less important