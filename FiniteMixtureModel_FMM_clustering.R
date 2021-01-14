#------------------------------------------------------------------------------------------------------------------
# Finite Mixture Model with Negative Binomial Distribution
#------------------------------------------------------------------------------------------------------------------
set.seed(20190218)
Model = FLXMRziglm(family = "poisson")
control = list(verbose = 10, iter.max = 300, minprior = 0.1, tol = 0.01)  
formula = Frequency ~ 1 + Monetary
formula2 = Frequency ~ 1+ Monetary + Recency
data = data.frame(customerid,Frequency,Monetary)
data2 = data.frame(customerid,Frequency,Monetary,Recency)

#formula 1 with k = 3
Fitted1 = flexmix(formula, data = data, k = 3 ,model = Model, control = control)
summary(Fitted1)
Fitted1
refit1 = refit(Fitted1, method = 'optim')
summary(refit1) 
#formula 1 with k = 4
Fitted2 = flexmix(formula, data = data, k = 4 ,model = Model, control = control)
summary(Fitted2)
Fitted2
refit2 = refit(Fitted2, method = 'optim')
summary(refit2)   
#formula 1 with k = 5
Fitted3 = flexmix(formula, data = data, k = 5 ,model = Model, control = control)
summary(Fitted3)
Fitted3
refit3 = refit(Fitted3, method = 'optim')
summary(refit3)
#formula 1 with k = 6
Fitted4 = flexmix(formula, data = data, k = 6 ,model = Model, control = control)
summary(Fitted4)
Fitted4
refit4 = refit(Fitted4, method = 'optim')
summary(refit4) 

#formula 2 with k = 3
Fitted1 = flexmix(formula2, data = data2, k = 3 ,model = Model, control = control)
summary(Fitted1)
Fitted1
refit1 = refit(Fitted1, method = 'optim')
summary(refit1) 
#formula 2 with k = 4
Fitted2 = flexmix(formula2, data = data2, k = 4 ,model = Model, control = control)
summary(Fitted2)
Fitted2
refit2 = refit(Fitted2, method = 'optim')
summary(refit2)   
#formula 2 with k = 5
Fitted3 = flexmix(formula2, data = data2, k = 5 ,model = Model, control = control)
summary(Fitted3)
Fitted3
refit3 = refit(Fitted3, method = 'optim')
summary(refit3)
#formula 2 with k = 6
Fitted4 = flexmix(formula2, data = data2, k = 6 ,model = Model, control = control)
summary(Fitted4)
Fitted4
refit4 = refit(Fitted4, method = 'optim')
summary(refit4)  

#getting the clusters k = 6 case
cluster = clusters(Fitted4)
d = data.frame(data2,cluster)
data = data.frame(d,Age,Female,Allow_analysis,Opt_in_com)
Cluster1Ind = as.numeric(rownames(d[d[,5]==1,]))
Cluster2Ind = as.numeric(rownames(d[d[,5]==2,]))
Cluster3Ind = as.numeric(rownames(d[d[,5]==3,]))
Cluster4Ind = as.numeric(rownames(d[d[,5]==4,]))
Cluster5Ind = as.numeric(rownames(d[d[,5]==5,]))
Cluster6Ind = as.numeric(rownames(d[d[,5]==6,]))
datac1 = data[Cluster1Ind,]
datac2 = data[Cluster2Ind,]
datac3 = data[Cluster3Ind,]
datac4 = data[Cluster4Ind,]
datac5 = data[Cluster5Ind,]
datac6 = data[Cluster6Ind,]  
