import numpy as np
np.random.seed(2021)
mu_betas = [9,30]
sigma_betas_cov = [[1,0.1],[0.1,1]]

n = 10
p = 0.8
N = 100

num_pred = 2

betas = np.random.multivariate_normal(mu_betas, sigma_betas_cov).reshape((2,1))
alpha = np.random.uniform(0,2,size = [1,1])
beta_vector = np.append(alpha,betas).reshape((3,1))
print(beta_vector.shape)

X = np.random.binomial(n,p,size = [N,num_pred])
X = np.append(np.ones([N,1]),X, axis = 1)
e = np.random.normal(0,1,size = [N,1])
Y = np.dot(X,beta_vector) + e



import statsmodels.api as sm
model = sm.OLS(Y,X)
fitted_model = model.fit()
print(fitted_model.summary())

from scipy.stats import t

def run_OLS(Y,X,alpha):
    df = len(X)-2
    Y_bar = np.repeat(np.mean(Y),len(Y))
    beta_hat = np.dot(np.linalg.inv(np.dot(X.T,X)),np.dot(X.T,Y))
    Y_pred = np.dot(X,beta_hat)
    RSS = np.sum(np.square(Y - Y_pred))
    MSE = RSS/(N-2)
    TSS = np.sum(np.square(Y - Y_bar))
    R_squared = 1-RSS/TSS

    var_beta_hat = np.linalg.inv(np.dot(X.T, X))*MSE
    SE = []
    t_stats = []
    p_values = []
    CI_s = []

    for i in range(num_pred+1):
        SE_beta_hat= np.sqrt(var_beta_hat[i,i])
        SE.append(SE_beta_hat)

        t_stat = beta_hat[i]/SE_beta_hat
        t_stats.append(t_stat)
        t_crit = t.ppf(1-alpha/2,df)*2

        p_value = t.sf(np.abs(t_stat), df)
        p_values.append(p_value)

        CI  = np.array([beta_hat[i] - t_crit*SE_beta_hat, beta_hat[i] +t_crit*SE_beta_hat]).reshape((1,2))
        CI_s.append(CI)

    # print("Coef: \n", beta_hat.reshape((3,1)))
    # print("---------")
    # print("Standard Errors: \n", np.array(np.round(SE,3)).reshape((3,1)))
    # print("---------")
    # print("t: \n", np.array(np.round(t_stats,3)).reshape((3,1)))
    # print("t_crit",t_crit)
    # print("---------")
    # print("P>|t|: \n", np.array(np.round(p_values,3)).reshape((3,1)))
    # print("---------")
    # print("CI: \n", CI_s)
    # print("---------")
    # print("MSE:\n", MSE)
    # print("---------")
    # print("R_squared: \n", R_squared)

    return(beta_hat,MSE,R_squared)

import pandas as pd

def run_K_fold_CV(K,Y,X):
    K_num_obs = int(len(Y)/K)
    data = np.append(X,Y,axis = 1)
    data = pd.DataFrame(data)
    data.columns = ["X0","X1","X2","Y"]

    folds= {}
    for i in range(K):
       hold_out_set = data.sample(K_num_obs)
       folds[i] = hold_out_set
       # dropping the selected observations
       data = data.drop(index = hold_out_set.index)
    return(folds)

def LR_with_k_fold(K,Y,X):
    K_fold_MSEs = []
    K_folds = run_K_fold_CV(K, Y, X)

    X = pd.DataFrame(X)
    X.columns = ["X0","X1","X2"]

    Y =  pd.DataFrame(Y)
    Y.columns = ["Y"]
    for i in range(K):
        hold_out = K_folds[i]
        X_test = hold_out[["X0","X1","X2"]]
        Y_test = hold_out["Y"]

        X_train = X.drop(index = X_test.index)
        Y_train = Y.drop(index = Y_test.index)

        model = sm.OLS(Y_train,X_train)
        model_fitted = model.fit()

        Y_pred = model_fitted.predict(X_test)

        K_fold_MSE = np.sum(np.sqrt(Y_pred-Y_test))/(N-num_pred)
        K_fold_MSEs.append(K_fold_MSE)
    return(np.mean(K_fold_MSEs))

#run_OLS(Y,X,alpha)
print(LR_with_k_fold(5,Y,X))









