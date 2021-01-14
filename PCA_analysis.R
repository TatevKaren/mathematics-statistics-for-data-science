
#------------------------------------------------------------------------------------------------------------------
#PCA analysis
#------------------------------------------------------------------------------------------------------------------
data_pca = data.frame(Recency,Frequency,Monetary)
colnames(data_pca) = c("Recency","Frequency","Monetary")
cov(data_pca) 
cor(data_pca) 
#pca with and without scaling
pca.data = prcomp(data_pca,scale = F)
pca.dataScale = prcomp(data_pca,scale = T) #with scaling
pca.dataScale$rotation
#the pca plots 
biplot(pca.data, cex = 0.6)
biplot(pca.dataScale, cex = 0.6)
eig = eigen(cor(data_pca))
screeplot(pca.dataScale, type="l", npcs = 3, main = NULL)
pve = rep(NA, dim(data_pca)[2]) # proportion of variance explained
for(i in 1:3)
{
  pve[i] = print(sum(eig$values[1:i])/3)
}
eig$values
pve
# generating new varaibles using the weights/loadings of pca
pca_Recency = pca.dataScale$rotation[1,1]*Recency_s 
pca_Frequency = (-1)*pca.dataScale$rotation[2,1]*Frequency_s 
pca_Monetary = (-1)*pca.dataScale$rotation[3,1]*Monetary_s 
data_pca = data.frame(Recency,Frequency,Monetary)
colnames(data_pca) = c("Recency","Frequency","Monetary")
cov(data_pca) 
cor(data_pca) 
#pca with and without scaling
pca.data = prcomp(data_pca,scale = F)
pca.dataScale = prcomp(data_pca,scale = T) #with scaling
pca.dataScale$rotation
#the pca plots 
biplot(pca.data, cex = 0.6)
biplot(pca.dataScale, cex = 0.6)
eig = eigen(cor(data_pca))
screeplot(pca.dataScale, type="l", npcs = 3, main = NULL)
pve = rep(NA, dim(data_pca)[2]) # proportion of variance explained
for(i in 1:3)
{
  pve[i] = print(sum(eig$values[1:i])/3)
}
eig$values
pve
# generating new varaibles using the weights/loadings of pca
pca_Recency = pca.dataScale$rotation[1,1]*Recency_s 
pca_Frequency = (-1)*pca.dataScale$rotation[2,1]*Frequency_s 
pca_Monetary = (-1)*pca.dataScale$rotation[3,1]*Monetary_s 
