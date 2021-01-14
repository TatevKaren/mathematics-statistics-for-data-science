#---------------------------------------------------------------------------------------------------------
#Function LDA
#---------------------------------------------------------------------------------------------------------
lda = function(x,y,robust=TRUE,alpha,m,l,delta){
  K = 2
  x= as.matrix(x)
  #case 1(when robust standard LDA should be performed)
  #-------------------------------------------------------------------------------------
  #number of obersations in X/rows
  #set of observations corresponding to class 0 
  x_class0 = x[y==0,]
  #set of observations corresponding to class 1
  x_class1 = x[y==1,]
  n0 = nrow(x_class0) #number of obs. in class 0
  n1 = nrow(x_class1) #number of obs. in class 1
  #estimators for priors 
  pi0_hat = n0/(n0+n1)
  pi1_hat = n1/(n0+n1)
  prior = rbind(pi0_hat,pi1_hat)
  if (robust == 'FALSE'){
    #determining the center of each group
    mean0_hat = apply(x_class0,2,mean) 
    mean1_hat = apply(x_class1,2,mean)
    #matrix in which row 1(2) contains centers of the first group(second group)
    center = as.matrix(rbind(mean0_hat,mean1_hat), nrow = 2, ncol = ncol(x))
    #Pooled Covariance matrix
    cov_pooled = (1/(n0+n1-K))*((n0-1)*var(x_class0) + (n1-1)*var(x_class1))
  }
  #case 2(when robustified LDA based on the MCD estimator should be computed)
  else{
    
    #determining the cnter estimates using the data of the first class
    mcd_results0 = covFastMCD(x_class0,alpha,m,l,delta) #using earlier creating function of covMCD
    mean0_hat = mcd_results0$center #center estimates
    sigma0 = as.matrix(mcd_results0$cov) #covariance matrix
    #determining the cnter estimates using the data of the first class
    mcd_results1 = covFastMCD(x_class1,alpha,m,l,delta)
    mean1_hat = mcd_results1$center
    sigma1 = as.matrix(mcd_results1$cov) #the MCD covariance matrix for class_1 data
    #center estimates matrix
    center = as.matrix(rbind(mean0_hat,mean1_hat), nrow = 2, ncol = ncol(x))
    #Pooled Covariance matrix
    cov_pooled = 1/(n0+n1-K)*((n0-1)*sigma0 + (n1-1)*sigma1)
  }
  #-------------------------------------------------------------------------------------
  #Calculating coefficients of LDA
  #-------------------------------------------------------------------------------------
  lda.cf = solve(cov_pooled)%*%as.matrix(center[2,]-center[1,])
  lda.cf.normalized = t(lda.cf)%*%cov_pooled%*%lda.cf
  lda.cf.final = lda.cf/drop(sqrt(lda.cf.normalized)) #making sure the dimensions coinsize
  #output
  listlda = list(center = center,cov_pooled = cov_pooled,prior = prior,coefficients = lda.cf.final)
  return(listlda)
}
#---------------------------------------------------------------------------------------------------------
#Function PredictLDA
#---------------------------------------------------------------------------------------------------------
predictLda = function(object,newdata){
  n = nrow(newdata)
  Y = rep(0,n)
  newdata = as.matrix(newdata)
  #function which return the discriminant value corresponding to class 0 
  discri_value0= function(x){
    value0 = -0.5*t(x-object$center[1,])%*%solve(object$cov_pooled)%*%(x-object$center[1,]) + log(object$prior[1,])
    return(value0)
  }
  #function which return the discriminant value corresponding to class 1
  discri_value1= function(x){
    value1 = -0.5*t(x-object$center[2,])%*%solve(object$cov_pooled)%*%(x-object$center[2,]) + log(object$prior[2,])
    return(value1)
  }
  #for each observation( of 1by6) of newdata we have to compare the discriminant values
  #if the new data is n by 6 such that it's number of columns is 6
  for (i in 1:n){
    if(discri_value1(newdata[i,]) > discri_value0(newdata[i,])){
      #assign that observation to class 1
      Y[i] = 1
    }
    else if(discri_value1(newdata[i,]) < discri_value0(newdata[i,])){
      #assign that observation to class 0
      Y[i] = 0
    }
    
  }
  pred = list(class = Y)
  return(pred)
}
