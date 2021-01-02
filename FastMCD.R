#installing required packages and libraries 
library(MASS)
library(robustbase)
library(stats)
library(rlist)
library(mvtnorm)
library(plyr)
#---------------------------------------------------------------------------------------------------------
#Function CovFastMCD
#---------------------------------------------------------------------------------------------------------
covFastMCD = function(x, alpha, m, l, delta){
  x = data.frame(as.matrix(x,nrow = nrow(x),ncol = ncol(x)))
  p = ncol(x) #number of varaibles in data
  n = nrow(x) #number of observations in data
  h = h.alpha.n(alpha, n, p) #computing the subsetsize h using above p and n and given alpha
  determ = as.vector(rep(0,m)) #initialization of determinant vector
  q.alpha = qchisq(alpha,df = p)
  q.delta = qchisq((1-delta),df = p)
  c.a = alpha/pgamma(q.alpha/2, shape = p/2+1, scale = 1)
  c.delta = (1-delta)/pgamma(q.delta/2, shape = p/2+1, scale = 1)
  cnp = .MCDcnp2(p, n, alpha)
  #------------------------------------------------------------------------------------------
  #Before we start we might wanna check whther some conditions for inputes are satisified
  #------------------------------------------------------------------------------------------
  #condition of n&p
  if (n <= p){
    print("Error: n <= p  the sample size is too small and MCD can not be performed!")
    break
    }
  if(n == p + 1){
    print("Error: n == p+1  is too small sample size for MCD")
    break
  }
  if(n<2*p){
    warning("n<2*p this might be a too small sample size")
  }
  #condition of nh&alpha
  if(h > n ){
    print("Error: h value is too large: h > n choose lower alpha ")
    break
  }
  if(h < (n + p + 1)/2 ){
    print("Error: h value is too small: h < (n+p+1)/2 choose higher alpha")
    break
  }
  if(h == n){ #in this case the MCD location estimator T is average of the whole dataset and scatter MCD is the cov matrix
   T_mcd = apply(x,2,mean)
   S_mcd = (h-1)/h*var(x)
   mcdh = list(centerh = T_mcd,scatterh = S_mcd)
   return(mcdh)
   break
  }
#------------------------------------------------------------------------------------------
# Determining top 10 initial subsets
#------------------------------------------------------------------------------------------
#initialization of all required lists in which we will store the generated samples,matrices and vectors 
  T_0 = list()
  S_0 = list()
  H_0 = list()
  T_1 = list()
  S_1 = list()
  H_1 = list()
  T_2 = list()
  S_2 = list()
  H_2 = list()
  T_3 = list()
  S_3 = list()
  H_3 = list()
  H_final = list()
  list_sets = list()
  S_final = list()
  sigma = list()
  center = list()

  for(i in 1:m){
    
    H_0[[i]] = x[sample(1:n,p+1),] #randomly selecting p+1 observations from data
    T_0[[i]] = apply(H_0[[i]],2,mean)
    S_0[[i]] = p/(p+1)*var(H_0[[i]]) #correcting for 1/n-1 to have 1/n (multiplying (n-1)/n)
    
    #if the det(S_0) is 0 we should keep adding observations to random subset untill it becomes nonzero
    #---------------------------------------------------------------------------------------------------
    while (det(S_0[[i]]) == 0){
      for (k in 1:(n-p-1)){
        subsetnew = x[sample(n,(p+1)+k),]
       }
      H_0[[i]] = subsetnew
      T_0[[i]] = apply(subsetnew,2,mean) 
      S_0[[i]] = (p+k)/(p+1+k)*var(subsetnew)
    }
    
    mah_dist0 = mahalanobis(x,T_0[[i]],S_0[[i]])
    d_sqr0 = sort(mah_dist0,decreasing = FALSE,index.return = TRUE)
    H1_index = d_sqr0$ix[1:h]
    H_1[[i]] = x[H1_index,] #the first subset with h components that will be used in C1-step
    #-----------------------------------------------------------
    #C1-step looking at H1
    #-----------------------------------------------------------
         T_1[[i]] = apply(H_1[[i]],2,mean) #center based on H1
         S_1[[i]] = (h-1)/h*var(H_1[[i]]) #scatter based on H1
         mah_dist1 = mahalanobis(x,T_1[[i]],S_1[[i]]) 
         d_sqr1 = sort(mah_dist1,decreasing = FALSE,index.return = TRUE)
         H2_index = d_sqr1$ix[1:h] #indeces of h small d^2's observations
         H_2[[i]] = x[H2_index,] #H2 subset
         T_2[[i]] = apply(H_2[[i]],2,mean) #center based on H2
         S_2[[i]] = (h-1)/h*var(H_2[[i]]) #scatter based on H2

           #-----------------------------------------------------------
           #C2-step looking at H2
           #-----------------------------------------------------------
           mah_dist2 = mahalanobis(x,T_2[[i]],S_2[[i]]) 
           d_sqr2= sort(mah_dist2,decreasing = FALSE,index.return = TRUE)
           H3_index = d_sqr2$ix[1:h] #indeces of h small d^2's observations
           H_3[[i]] = x[H3_index,] #H3 subset
           T_3[[i]] = apply(H_3[[i]],2,mean) #center based on H3
           S_3[[i]] = (h-1)/h*var(H_3[[i]]) #scatter based on H3
           determ[i] = det(S_3[[i]]) #we take the det of the best subset
          }
     
    
  D = sort(determ, decreasing = FALSE, index.return = TRUE) #sorting the deteminant of all m subsets  and picking smallest l determinant
  det10 = D$ix[1:l] #getting indexes of these 10 low det sets
  
  #getting the best busets and the corresponding covariances
  for(r in 1:l){
      list_sets[[r]] = H_3[[det10[r]]] #in this case H3 has been used
      S_final[[r]] = S_3[[det10[r]]]
   }
  
  objectmcd = list(call = match.call(),H0sets = H_0,H1sets = H_1,H2sets = H_2, H3sets = H_3,final10_set = list_sets, finalS = S_final, index_10 = det10)
  #---------------------------------------------------------------------------------------
  #while loop for C-steps of convergence for top 10 subsets from initial step
  #---------------------------------------------------------------------------------------
  for(k in 1:l){
  H_new = data.frame(as.matrix(objectmcd$final10_set[[k]],nrow = h,ncol = p)) #H1 for k =1 is the first subset of 10 finial subsets
  term1 = 1 #determinant of new one 
  term2 = 2 #determinant of old one
  
  while(term1 != term2 && term1 != 0 ){ #continue c-steps until det(S_new) = det(S_old) or det(S_new) = 0
    
    T_old = apply(H_new,2,mean)
    S_old = (h-1)/h*var(H_new)
    term2 = det(S_old) #determinant of the initial subset
    mah_distnew = mahalanobis(x,T_old,S_old)
    d_ksqr = sort(mah_distnew,decreasing = FALSE,index.return = TRUE)
    index_new = d_ksqr$ix[1:h] 
    #updating infromation based on new indices
    H_old = H_new  #new new sumbset becomes old subset to compare it weith new one
    H_new = x[index_new,] #updating H_new using the indices determined by H_old
    T_new = apply(H_new,2,mean)
    S_new = (h-1)/h*var(H_new)
    term1 = det(S_new) #updating new determinant
    
   }
  
  center[[k]] = T_new # storing the final center estimate in list of this final 10 centers
  sigma[[k]] = S_new  #store in the final 10 scatters
  H_final[[k]] = H_new  #store in the final 10 subsets
 
  }  
  #deciding which one has the minimum determiniant of these final 10 sets
  d = rep(0,l) 
  for(i in 1:l){
    d[i] = det(sigma[[i]])
  }
  det10= sort(d,decreasing = FALSE,index.return = TRUE) #det10 is sorted vector of top 10 final final determinant
  #index of the one with smallest determinant from all 10, where first one is the one with smallest det
  mindet = det10$ix[1] #the index of the best set  corresponding the smallest det
  #------------------------------------------------------------------------------------
  #the final T and S estimators with index mindet 
  #------------------------------------------------------------------------------------
  T_mcd = center[[mindet]] #center estimater of the minimal det set
  S_mcd = c.a*cnp*sigma[[mindet]] #scatter estimator of the minimal det set
  H_mcd = H_final[[mindet]] #final subset with smallest det
  indeces_H_mcd = as.integer(rownames(H_mcd)) #indeces of the final subset
  result1 = list(raw.center  = T_mcd, raw.cov = S_mcd , best = indeces_H_mcd)
  #------------------------------------------------------------------------------------
  #Reweighting step
  #------------------------------------------------------------------------------------
  #(1-delta quantile of Chi-square dist. we will use 0.025 to expect that 97.5% of data will be included)
  w = rep(0,n) #initialization of weight vector
  d_sqr_r = mahalanobis(x,result1$raw.center,result1$raw.cov) #mah. distanaces for all observations
  cutoff = qchisq((1-delta), df = p) #quantile of chi-square distribution with o degrees of freedom
  for(i in 1:n){
    if(d_sqr_r[i]<=cutoff){
      w[i] = 1
    }
  } 
  weights = t(w) #weights matrix
  #--------------------------------------
  #Reweighted MCD location estimator
  #--------------------------------------
  x = as.matrix(x,nrow=n,ncol = p)
  T_rwgt = 1/sum(weights)*(weights%*%x)
  #--------------------------------------
  #Reweighted MCD scatter estimator
  #--------------------------------------
  S = diag(0,p) #zero diagonal matrix
  sigmas = list() #list to stor each ith sigma matrix
  T = as.matrix(T_rwgt,nrow = nrow(T),ncol =ncol(T))
  for(i in 1:n){
    sigmas[[i]] = t(x[i,]-T)%*%(x[i,]-T)*weights[i]
    S = S + sigmas[[i]] #adding each time the new sigma
  }
  S_rwgt = S/sum(weights) #the sum of all covariance matrices devided by sum of weights
  Srwgt = c.delta*cnp*S_rwgt
  #the output adding the newresults to result1 with raw estimates
  list = list.append(result1, weights = weights,center = T_rwgt,cov = Srwgt )
  return(list)
}
