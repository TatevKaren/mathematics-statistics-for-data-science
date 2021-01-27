#---------------------------------------------------------------------------------------------------------
#ER rate calculation
#---------------------------------------------------------------------------------------------------------
ER = function(object){
  center = as.matrix(object$center)
  cov = as.matrix(object$cov_pooled)
  pi = as.matrix(object$prior)
  theta = log(pi[2,]/pi[1,])
  Delta = sqrt(t(center[1,]-center[2,])%*%solve(cov)%*%(center[1,]-center[2,]))
  er = (pi[1,]*pnorm((theta/Delta-Delta/2),0,1) + pi[2,]*pnorm((-theta/Delta-Delta/2),0,1))
  er = pnorm((-Delta/2),0,1)
  return(er)
}

#---------------------------------------------------------------------------------------------------------
#3.1:Simulation study for comparison robustLDA(TRUE argument) and LDA(FALSE) argument no outliers
#---------------------------------------------------------------------------------------------------------
{
  #How well does robustified version perform when there is no deviations from the model distribution?
  n1 = 60
  n2 = 60
  n = n1+n2
  mu1 = as.vector(c(0,0,0,0,0,0)) #main mu1
  mu2 = as.vector(c(1,1,1,1,1,1)) #main mu2
  Sigma = diag(1,nrow = p)
  y1 = rep(0,n1)
  y2 = rep(1,n2)
  y = c(y1,y2)
  error_nr = rep(0,R)
  error_r = rep(0,R)
  ER_opt_nr_k = rep(0,R) 
  ER_opt_r_k = rep(0,R) 
  for(i in 1:R){
    #calculate for each of those samples the mean and covariance using LDA function
    sample1 = rmvnorm(n1,mean = mu1,sigma = Sigma) #first sample 
    sample2 = rmvnorm(n2,mean = mu2,sigma = Sigma) #second sample
    samplet = rbind(sample1,sample2) #combining two samples
    #division of the data into training and test set
    index = sample(1:n,n*0.6)
    s_train = samplet[index,] #randomly selecting 60%(120 obs) from the data
    y_train = y[index]
    s_test = samplet[-index,] 
    y_test = y[-index]
    #lda object for nonrobust case
    lda.nonrobust = lda(s_train,y_train,robust=FALSE)
    true1 = sum(predictLda(lda.nonrobust,s_test)$class == y_test)
    false1 = sum(predictLda(lda.nonrobust,s_test)$class != y_test)
    error_nr[i] = false1/(true1+false1) #nonrobust error rate
    ER_opt_nr_k[i] = ER(lda.nonrobust)
    #lda object for robust case
    lda.robust = lda(s_train,y_train, robust=TRUE, alpha = 0.55,m = 500,l = 10,delta = 0.025)
    true2 = sum(predictLda(lda.robust,s_test)$class == y_test)
    false2 = sum(predictLda(lda.robust,s_test)$class != y_test)
    error_r[i] = false2/(true2+false2) #robust error rate
    ER_opt_r_k[i] = ER(lda.robust)
    
  }
  
  avg_error_nonr = mean(error_nr) #average error rate for non-robust case
  avg_error_r = mean(error_r) #average error rate for robust case
  ER_opt_nr = mean(ER_opt_nr_k) #average ER for non-contaminated data non-robust case
  ER_opt_r = mean(ER_opt_r_k)  #average ER for non-contaminated data robust case
  
}
#----------------------------------------------------------------------------------------------------
#3.2:Adding contamination to the predictors/outliers in the predictors
#----------------------------------------------------------------------------------------------------
{
  n1 = 60
  n2 = 60 
  n = n1+n2
  p = 6
  epsilon = c(0.05,0.10,0.20,0.30,0.40)
  mu_1c = as.vector(c(5,5,5,5,5,5)) #contamination mu1
  mu_2c = as.vector(c(-4,-4,-4,-4,-4,-4)) #contamination mu2
  Sigma_c =  Sigma*(0.25^2)
  y1 = rep(0,n1)
  y2 = rep(1,n2)
  y = c(y1,y2)
  ER_nonr = rep(0,length(epsilon)) #ER for nonrobust
  ER_r = rep(0,length(epsilon))
  avg_error_p = rep(0,length(epsilon)) #average error rates for nonrobust
  avg_error_rob_p = rep(0,length(epsilon))
  s_train= list()
  y_train = list()
  s_test = list()
  y_test = list()
  for(k in 1:length(epsilon)){
    error_p = rep(0,R)
    error_rob_p = rep(0,R)  
    Nout1 = n1 * epsilon[k]#number of outliers
    Nout2 = n2 * epsilon[k]
    ER_nk_nonr = rep(0,R) #vector containing the ER's for each iteration for non-robust case this with contamination
    ER_nk_r = rep(0,R) #ER's for robust case
    for(i in 1:R){
      myout1 = rmvnorm(Nout1,mean = mu_1c,sigma = Sigma_c)
      myout2 = rmvnorm(Nout2,mean = mu_2c,sigma = Sigma_c)
      s1_p = rmvnorm(n1,mean = mu1,sigma = Sigma) #first sample 
      s2_p = rmvnorm(n2,mean = mu2,sigma = Sigma) #second sample
      s1_outp = rbind(myout1[1:Nout1,],s1_p[-(1:Nout1),]) #sample1:replacing Nout rows by random outliers
      s2_outp = rbind(myout2[1:Nout2,],s2_p[-(1:Nout2),])#sample2 with outliers
      s_outp= rbind(s1_outp,s2_outp) #combining two samples
      #division of the data into training and test set
      index = sample(1:n,n*0.6)
      s_train[[i]] = s_outp[index,] #randomly selecting 60%(120 obs) from the data
      y_train[[i]] = y[index]
      s_test[[i]] = s_outp[-index,] 
      y_test[[i]] = y[-index]
      #lda object for nonrobust case with outliers
      lda.nonr_out = lda(s_train[[i]],y_train[[i]] ,robust=FALSE)
      true1 = sum(predictLda(lda.nonr_out,s_test[[i]])$class == y_test[[i]])
      false1= sum(predictLda(lda.nonr_out,s_test[[i]])$class != y_test[[i]])
      error_p[i] = false1/(true1+false1) #nonrobust error rate
      ER_nk_nonr[i] = OER(lda.nonr_out) #ER for non-robust case
      #lda object for robust case with outliers
      lda.r_out = lda(s_train[[i]],y_train[[i]], robust=TRUE, alpha = 0.65, m = 500, l = 10, delta = 0.025)
      true2 = sum(predictLda(lda.r_out,s_test[[i]])$class ==y_test[[i]])
      false2 = sum(predictLda(lda.r_out,s_test[[i]])$class !=y_test[[i]])
      error_rob_p[i] = false2/(true2+false2) #robust error rate
      ER_nk_r[i] = OER(lda.r_out)#ER for robust case
    }
    
    avg_error_p[k] = mean(error_p)
    avg_error_rob_p[k] = mean(error_rob_p)
    ER_nonr[k] = mean(ER_nk_nonr)
    ER_r[k] = mean(ER_nk_r)
    
  }
  
}
#----------------------------------------------------------------------------------------------------
#3.3:Adding contamination to class variable
#----------------------------------------------------------------------------------------------------
{
  R = 100
  n1 = 60
  n2 = 60
  n = n1+n2
  #y1 contains n 0's
  #y2 contains n 1's
  misslab = c(0.05,0.10,0.20,0.30,0.40) #1-20 possible misslabeling in each y1,y2
  avg_error_c = rep(0,length(misslab))
  avg_error_rob_c = rep(0,length(misslab))
  ER_nonr= rep(0,length(misslab))
  ER_r = rep(0,length(misslab))
  for(l in 1:length(misslab)){
    #to make sure that for each mislabling ammount we have the original y's
    y1 = rep(0,n1)
    y2 = rep(1,n2)
    y = c(y1,y2)
    y1mis = NULL
    y2mis = NULL
    ymis = NULL
    Nout1 = n1 * misslab[l]#number of outliers
    Nout2 = n2 * misslab[l]
    mis1 = rep(1, Nout1) #replacing 0's of class1 with 1's for misslab times
    mis2 = rep(0, Nout2) #replacing 1's of class2 with 0's for misslab times
    y1mis = c(mis1,y1[-(1:Nout1)])
    y2mis = c(mis2,y2[-(1:Nout2)])
    ymis  = c(y1mis,y2mis) #newmislabbleed y
    #for standard error rates
    error_nonr_c = rep(0,R)
    error_r_c = rep(0,R)
    ER_nk_nonr_c = rep(0,R) 
    ER_nk_r_c = rep(0,R) 
    
    for(i in 1:R){
      #samples
      s1_c = rmvnorm(n1,mean = mu1,sigma = Sigma) 
      s2_c = rmvnorm(n2,mean = mu2,sigma = Sigma) 
      s_c = rbind(s1_c,s2_c) 
      #division of the data into training and test set
      index = sample(1:n,n*0.6)
      s_train = s_c[index,] #randomly selecting 60%(120 obs) from the data
      y_train = ymis[index]
      s_test = s_c[-index,] 
      y_test = ymis[-index]
      #nonrobust lda with mislabbled y
      lda.nonr_c = lda(s_train,y_train,robust=FALSE)
      true1 = sum(predictLda(lda.nonr_c,s_test)$class == y_test) 
      false1= sum(predictLda(lda.nonr_c,s_test)$class != y_test)
      error_nonr_c[i] = false1/(true1+false1) #nonrobust error rate
      ER_nk_nonr_c[i] = ER(lda.nonr_c)
      #lda object for robust case with mislabbled y
      lda.r_c = lda(s_train,y_train, robust=TRUE, alpha = 0.55, m = 500, l = 10, delta = 0.025)
      true2 = sum(predictLda(lda.r_c,s_test)$class == y_test)
      false2 = sum(predictLda(lda.r_c,s_test)$class != y_test)
      error_r_c[i] = false2/(true2+false2) #robust error rate
      ER_nk_r_c[i] = ER(lda.r_c)
    }
    avg_error_c[l] = mean(error_nonr_c)
    ER_nonr[l] = mean(ER_nk_nonr_c)
    avg_error_rob_c[l]= mean(error_r_c)
    ER_r[l] = mean(ER_nk_r_c)
  }
  avg_error_c
  avg_error_rob_c
  ER_nonr
  ER_r
  
}
#----------------------------------------------------------------------------------------------------
#4.1:Applying robustified LDA and standard LDA to the Swiss bank note data
#----------------------------------------------------------------------------------------------------
{
  swissbankdata = banknote[,-1]
  Length = swissbankdata[,1]
  Left = swissbankdata[,2]
  Right = swissbankdata[,3]
  Bottom = swissbankdata[,4]
  Top = swissbankdata[,5]
  Diagonal = swissbankdata[,6]
  #(0 if genuine) & (1 if counterfeit)
  class = as.numeric(banknote[,1] =="counterfeit")
  #classical/standard LDA
  lda.standard = lda(swissbankdata, class, robust =FALSE)
  lda.standard
  #robustified LDA using fastMCD
  lda.robust= lda(swissbankdata, class, robust =TRUE,alpha = 0.6, m = 500, l = 10,delta = 0.025)
  lda.robust
  #outliers with the weights of covMCD
  #graph of outliers
  covMCD_banknote = covFastMCD(swissbankdata,alpha = 0.6, m = 500, l = 10,delta = 0.025)
  Noutliers = sum(covMCD_banknote$weights == 0) #number of outliers
  Noutliers
  group1 <- data[1:100,]
  group2 <- data[101:200,]
  bank1.covMCD  =  covFastMCD(group1, alpha = 0.6, m = 500, l=10, delta=0.025)
  center1 = bank1.covMCD$raw.center
  cov1 = bank1.covMCD$raw.cov
  bank2.covMCD = covFastMCD(group2, alpha = 0.6, m = 500, l=10, delta=0.025)
  center2 = bank2.covMCD$raw.center
  cov2 = bank2.covMCD$raw.cov
  delta = 0.025
  cutoff = qchisq((1-delta), df = p)
  
  dist1 = mahalanobis(group1, center = center1, cov = cov1)
  dist2 = mahalanobis(group2, center = center2, cov = cov2)
  
  Mahalanobis.distance = data.frame(cbind(dist1,dist2))
  matplot(Mahalanobis.distance,col=c("blue","red"),pch=20, ylab = "Mahalanobis distance")
  abline(a = cutoff, b = 0)
}
#----------------------------------------------------------------------------------------------------
#4.2: Split the data into a training set and a test set to evaluate prediction performance
#----------------------------------------------------------------------------------------------------
{
  trper = c(0.3,0.4,0.5,0.6,0.7,0.8)
  n = nrow(swissbankdata)
  error_rate_nr = rep(0,R)
  error_rate_r = rep(0,R)
  train = list()
  train.class = list()
  test = list()
  test.class = list()
  error_classical = rep(0,length(trper))
  error_robust =  rep(0,length(trper))
  for(k in 1:length(trper)){
    for(i in 1:R){
      
      train[[i]] = swissbankdata[sample(1:n,n*trper[k]),] #randomly selecting 60%(120 obs) from the data
      index = as.integer(rownames(train[[i]])) 
      train.class[[i]] = class[index]
      test[[i]] = swissbankdata[-index,] 
      test.class[[i]] = class[-index]
      #Standard LDA
      lda.fit.nonr = lda(train[[i]],train.class[[i]],FALSE) #non-robust case
      lda.pred.nonr = predictLda(lda.fit.nonr,test[[i]]) #using training set fit the model
      true_nr = sum(lda.pred.nonr$class == test.class[[i]])
      false_nr = sum(lda.pred.nonr$class != test.class[[i]]) 
      error_rate_nr[i] = false_nr/(true_nr+false_nr)
      #Robustified LDA
      lda.fit.r = lda(train[[i]],train.class[[i]],TRUE, alpha = 0.6, m = 500, l = 10,delta = 0.025) #robust case
      lda.pred.r = predictLda(lda.fit.r,test[[i]])
      true_r = sum(lda.pred.r$class == test.class[[i]])
      false_r = sum(lda.pred.r$class != test.class[[i]]) 
      error_rate_r[i] = false_r/(true_r+false_r)
      #print(error_rate_r[i])
      
    }
    error_classical[k] = mean(error_rate_nr)
    error_robust[k] = mean(error_rate_r)
    
  }
  error_classical
  error_robust
  
}
#----------------------------------------------------------------------------------------------------
#Asymmetric adaboost
#----------------------------------------------------------------------------------------------------
{}
sample <- sample.int(n = nrow(banknote), size = floor(.60*nrow(banknote)), replace = F)
train <- as.matrix(banknote[sample, -1]) 
y.train <- as.numeric(banknote[sample,1]=="genuine")
test  <- as.matrix(banknote[-sample, -1])
y.test <- as.numeric(banknote[-sample,1]=="genuine")

object <-lda(train,y.train,robust=TRUE,alpha=0.6,m=500,l=10,delta=0.025)
test.pred <- predictLda(object,test)
result=test.pred$class
PRED=list()
R = 100
countCorrect1 <- rep(0,R)
countType1 <- rep(0,R)
countCorrect2 <- rep(0,R)
countType2 <- rep(0,R)
Aloss <-rep(0,R)
for (i in 1:R){
  
  PRED[[i]] = test.pred$class
  
  for (j in 1:length(y.train)) {
    if(y.train[j] == 1) {
      if(PRED[[i]][j] == 1) {
        countCorrect1[i] <- countCorrect1[i] + 1
        countType1[i] <- countType1[i]
      }
    }  
    else {
      countCorrect1[i] <- countCorrect1[i]
      Aloss[i] <- sqrt(countType1[i] + 1)
    }
    
    else if (y.train[j] == 0){
      
      if(PRED[[i]][j] == 0) {
        countCorrect2[i] <- countCorrect2[i] + 1
        countType2[i] <- countType2[i]
      }
      else {
        countCorrect2[i] <- countCorrect2[i]
        Aloss[i] <- 1/sqrt(countType2[i] + 1)
      }
    }
    
    
  }
  
}
