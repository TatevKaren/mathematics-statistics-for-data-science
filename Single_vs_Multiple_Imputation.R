#required libraries
library(MASS)
library(robustbase)
library(stats)
library(rlist)
library(mvtnorm)
library(VIM)
library(mice)
library(lattice)
library(tidyverse)

#-----------------------------------------------------------------------------------------
# Function for Single and Multiple Imputation 
#-----------------------------------------------------------------------------------------
# Inputs
#---------
# m: number of imputataions;default of m is 10 when missing proporition is larger then 10 we use rule of thumb to set m equal to missing percentage
# mixed: index of semi-continous varaibles in the data
# count: index of count varaibles in the data
# imp.type: type of imputation that has to be applied; single or multiple
# initmethod:  initialization method in the IRMI for missing values; KNN or median imputation
# robMethod: regression method when the response is continuous; by default we put it equal to lmrob
# robust: logical operator to indicate weather the robust or non-robust regression should be applied
#---------
# Output
#---------
# object containing following things 
# m: number of imputataions used 
# x: the original data used in for the imputataion
# imputed: list containing all m imputed data sets
# imputed.identifier: list containing m matrices consisting of TRUE/FALSE logical operators indicating which elements have been imputed
# imp.type: wheather single or multiple imputataion has been used
multimp = function(x, mixed = NULL,count = NULL , m = 10, imp.type = c("single","multiple") ,initmethod = c("KNN","median"),robMethod = "lmrob",robust = FALSE){ #where = is.na(x),
  colnames(x) = names(x)
  n = nrow(x)
  p = ncol(x)
  vars = names(x) 
  imputation_m = list() #list containing all imputed data sets
  imputation_mlog = list() #list containing for all m imputation logical TRUE/FALSE operators indicating weather it has been imputed or not
  # When imputataion type is Single 
  #--------------------------------
  if(imp.type=="single"){
    m = 1
    if (robust == "FALSE"){
      imputation_m[[1]] = irmi(x,mixed = mixed,count = count, init.method = initmethod, robust = FALSE)
    }
    else if(robust == "TRUE") {
      imputation_m[[1]] = irmi(x,mixed = mixed,count = count, init.method = initmethod, robust = TRUE)
    }
    imputation_mlog[[1]] = imputation_m[[1]][(p+1):ncol(imputation_m[[1]])]
    colnames(imputation_m[[1]]) = names(x)
  }
  # When imputataion type is Multiple 
  #--------------------------------
  else if(imp.type=="multiple"){
    #checking the proportion of the missing values to see weather m should be changed or not
    propmis = floor(100*length(which(is.na(x)))/nrow(x)) #proportion of missing values in R*100 rounded to nearest integer
    if(propmis > m){
      m = propmis
    }
    #loop over all imputations
    for(r in 1:m){
      if (robust == "FALSE"){
        imputation_m[[r]] = irmi(x,robust = FALSE,init.method = initmethod)
      }
      else if(robust == "TRUE") {
        imputation_m[[r]] = irmi(x,robust = TRUE,init.method = initmethod)
      }
      imputation_mlog[[r]] = imputation_m[[r]][(p+1):ncol(imputation_m[[r]])] 
      imputation_m[[r]] = imputation_m[[r]][1:p]
      colnames(imputation_m[[r]]) = names(x)
    }
  }  
  
  xList = list(originaldata = x, imputed = imputation_m, imputed.identifier = imputation_mlog , m = m, imp.type = imp.type)
  return(xList)
}

#-----------------------------------------------------------------------------------------
# Function for Fitting Regressions
#-----------------------------------------------------------------------------------------
# Inputs
#---------
# f: formula correspondig to the model that has to be feeted with dependent and independent varaible from the data
# p: number of predictors in f
# xList: object of type multimp prodused from multimp() function 
# method: weather  OLS or MM regression type should be used
# max.it: integer specifying the maximum number of IRWLS iterations, default value is 200
# bb: expected value under the normal model of the “chi”
# psi: the type of psi function: "bisquare" for S and MM-estimates should be chosen and "lqq"" else
# k.max: maximal number of refinement steps for the “fully” iterated best candidates for the fast-S algorithm, by default 1000
# method: the method of estimation is MM by default
# cov: the name of the function that should be used to calculate covariance matrix estimate ".vcov.avar1" (formulas of Croux, Dhaene and Hoorelbeke (2003) only for MM metod) or ".vcov.w"(based on asymptotic normality of est coefficiets(Koller and Stahel (2011)))
# refine.tol: relative convergence tolerance for the fully iterated best candidates(for the fast-S algorithm), by default is 1e-7
#---------
# Output
#---------
# list/object of type fit() containing
# x: the original data that has been used in the imputation
# models: objects of type lm() or lmrob()
# summary_models: the summary model of object model including the 95% confidence interval
# MSE: the mean squared error using the residuals of object models
# Pred: the prediction y_hat for each model
# Weights_MM: the weights of lmrob() object, the “robustness weights” assigned by the M-estimator for outlier detection
fit = function(f, p, xList, methodreg = c("OLS", "MM") ,max.it = 200, bb = 0.5, k.max = 500, method = "MM",cov = ".vcov.avar1", psi = c("bisquare","lqq"), refine.tol = 1e-6){
  control = lmrob.control( max.it = max.it, bb = bb,k.max = k.max, cov = cov, psi = psi, method  = method , setting="KS2014",refine.tol = refine.tol)
  m = xList$m #number of imputation 
  models = list() #list that will contain all regressions
  sum_models = list() #list containg all summary regressions 
  MSE = list() #list containing Mean Squared errors for each regression
  Pred = list()
  Weights_MM = list()
  #for loop over m iterations 
  for(i in 1:m){
    # OLS estimation if method is OLS
    if(methodreg =="OLS"){
      models[[i]] = lm(f, data = xList$imputed[[i]])
      MSE[[i]] = mean(models[[i]]$residuals^2)
      sum_models[[i]] = cbind(summary(models[[i]])$coeff, confint(models[[i]]))
      Pred[[i]] = predict(models[[i]])
    }
    # MM estimation if method is MM
    else if(methodreg =="MM"){
      models[[i]] = lmrob(f, data = xList$imputed[[i]], control = control)
      MSE[[i]] = mean(models[[i]]$residuals^2)
      sum_models[[i]] = sum_models[[i]] = cbind(summary(models[[i]])$coeff, confint(models[[i]]))
      Pred[[i]] = predict(models[[i]])
      Weights_MM[[i]] = weights(models[[i]], type = "robustness")
    }
    
  }
  #object containing models,regression results and m
  fitList = list(x = xList$originaldata, models = models, summary_models = sum_models, MSE = MSE, m = m, p = p, imp.type = xList$imp.type,Pred = Pred,Weights_MM = Weights_MM)
  return(fitList)
  
}


#-----------------------------------------------------------------------------------------
# Function for pooling all results together
#-----------------------------------------------------------------------------------------
# Inputs
#---------
# fitList: list from fit() function
#---------
# Output
#---------
# list of type pool() containing 
# matrix: matrix containing pooled estimates, standard errors etc.
# matrixsig: matrix only now added also the significance signs 
# imp.type: the type of imputation;single or multiple
# m: the number of imputations
# MSE: the pooled mean squared error
# Pred: the pooled y_hat prediction

pool = function(fitList){
  m = fitList$m
  #in case of single impuation 
  #------------------------------------------------------------------------
  if(m == 1){
    Matrix0 = as.matrix(fitList$summary_models[[1]])
    p_value = as.matrix(Matrix0[,4]) #4th column is the column for p_values
    len = nrow(Matrix0)
    signitcode = rep(0,len)
    for(i in 1:len){
      
      if(p_value[i] < 0.001 & p_value[i] > 0){
        signitcode[i] = "***"
      }
      else if(p_value[i] < 0.01 & p_value[i] >= 0.001){
        signitcode[i] = "**"
      }
      else if(p_value[i] < 0.05 & p_value[i] >= 0.01) {
        signitcode[i] = "*"
      }
      else if(p_value[i] < 0.1 & p_value[i] >= 0.05){
        signitcode[i] = "."
      }
      else{
        signitcode[i] = ""
      }
      
    }
    Matrix0 = round(Matrix0,digits = 6)
    signitcode = as.matrix(noquote(signitcode))
    Matrix1 = cbind(Matrix0,signitcode)
    . = c("","","","","","","")
    Signif.codes = c("0 '***'","0.001 '**'","0.01 '*'","0.05 '.'","0.1 '' 1","","")
    Matrix1 = rbind(Matrix1,.,Signif.codes)
    Matrix = noquote(Matrix1)
    k = fitList$Pred[[1]]
    
  }
  
  #in case of multiple imputation
  #------------------------------------------------------------------------
  else{
    
    T_r_star = list()
    U_r_hat = list()
    B_hat = list()
    C1 = list()
    C2 = list()
    for(r in 1:m){
     
      T_r_star[[r]] = as.matrix(fitList$summary_models[[r]][,1]) #the estimates are in the first column
      U_r_hat[[r]] = as.matrix(fitList$summary_models[[r]][,2]^2) #the variance(squared standard errors) second column
      C1[[r]] = as.matrix(fitList$summary_models[[r]][,5])
      C2[[r]] = as.matrix(fitList$summary_models[[r]][,6])
      }
    T_pooled = as.matrix(Reduce("+",T_r_star)/m) #pooled estimates/coefficients
    W_hat_star = as.matrix(Reduce("+",U_r_hat)/m)#average Within-imputation variance
    CI1 = as.matrix(Reduce("+",C1)/m) #pooled CIleft
    CI2 = as.matrix(Reduce("+",C2)/m) #pooled CIright
    for(r in 1:m){
      B_hat[[r]] = (T_r_star[[r]] - T_pooled)^2
    }
    B_hat_star = as.matrix(Reduce("+",B_hat)/(m-1)) #average Between-imputation variance
    V_hat_star = W_hat_star + (m+1)*B_hat_star/m #pooled variance
    Pooled_error = sqrt(V_hat_star) #pooled standard errors
    #---------------------------------
    # calculating the adjusted df for t-values  B:ernard and Rubin (1999) 
    # & calculating t-values
    #---------------------------------
    n = nrow(fitList$x)
    p = fitList$p
    len = length(T_pooled)
    vcomp = n-p-1 #complete-data degrees of freedom
    v_m = rep(0,len) #vector containing the undjusted df
    v_obs = rep(0,len) #vector contaning the estimated observed-data df 
    v_m_tilda = rep(0,len) #vector containing adjusted df's
    gamma_m = rep(0,len)
    t_value = rep(0,len)
    p_value = rep(0,len)
    signitcode = rep(0,len) #significance code indicating the degree of significance
    
    for(i in 1:len){
      gamma_m[i] = ((m+1)/m)*(B_hat_star[i]/V_hat_star[i])
      v_m[i] = (m-1)/(gamma_m[i]^2)
      v_obs[i] = (vcomp+1)*vcomp*(1-gamma_m[i])/(vcomp + 3)
      v_m_tilda[i] = v_m[i]*v_obs[i]/(v_m[i] + v_obs[i])
      t_value[i] = T_pooled[i]/Pooled_error[i]
      p_value[i] = 2*pt(-abs(t_value[i]), df = v_m_tilda[i], lower.tail = TRUE)
      if(p_value[i] < 0.001 & p_value[i] > 0){
        signitcode[i] = "***"
      }
      else if(p_value[i] < 0.01 & p_value[i] >= 0.001){
        signitcode[i] = "**"
      }
      else if(p_value[i] < 0.05 & p_value[i] >= 0.01) {
        signitcode[i] = "*"
      }
      else if(p_value[i] < 0.1 & p_value[i] >= 0.05){
        signitcode[i] = "."
      }
      else{
        signitcode[i] = ""
      }
    }
    
    v_m_tilda = as.matrix(v_m_tilda) #adjusted degrees of freedom
    t_value = as.matrix(t_value) #t-values for each predictor
    p_value = as.matrix(p_value)
    Matrix0 = cbind(T_pooled,Pooled_error,t_value,v_m_tilda,p_value,CI1,CI2)
    colnames(Matrix0) = c("Estimate","Std.Error","t.value","df","Pr(>|t|)","2.5%","97.5%")
    Matrix1 = round(Matrix0,digits = 6)
    signitcode = as.matrix(noquote(signitcode))
    Matrix1 = cbind(Matrix1,signitcode)
    . = c("","","","","","","","")
    Signif.codes = c("0 '***'","0.001 '**'","0.01 '*'","0.05 '.'","0.1 '' 1","","","")
    Matrix1 = rbind(Matrix1,.,Signif.codes)
    Matrix = noquote(Matrix1)
    
  }
  MSE = Reduce("+",fitList$MSE)/m
  k =  Reduce("+",fitList$Pred)/m

  fitlist = list(matrix = Matrix0, matrixsig = Matrix, imp.type = fitList$imp.type, m = m, MSE = MSE, Pred = k)
  return(fitlist)
  
}



