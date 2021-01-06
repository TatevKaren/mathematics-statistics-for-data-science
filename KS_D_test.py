import numpy as np
import stats
from scipy.stats import stats
import statsmodels.api as sm

import pandas as pd
import math

import pandas as pd
import numpy as np
from matplotlib import pyplot
import matplotlib.pyplot as plt
from statsmodels.regression.linear_model import OLS



print(math.floor(n_proxy))

Y_hat = pd.read_csv('Timeseries_het.txt', header=None)
Y_hat_n= Y_hat.iloc[:, 0:3].copy()
n = 62
phi_1 = 0.75
phi_2 = 0.25
phi = np.array([phi_1, phi_2])
x = np.array(np.mean(Y_hat_n[0]))

alpha = 0.05
column = 0
for i in range(2,len(5)):
    print(i)

def get_Ylag(num_lags, Y):
    Ylag = Y.shift(num_lags).fillna(0)
    return(Ylag)


def get_deltaYs(Y):
    #Ytminus1
    Y_lag1 = get_Ylag(1, Y)
    #Ytminus2
    Y_lag2 = get_Ylag(2, Y)
    delta_Yt = Y-Y_lag1
    delta_Ytlag1 = Y_lag1-Y_lag2
    return(delta_Yt, delta_Ytlag1)

# Heteroskedasticity-consistent covariance matrix estimator
def cov_matrix_estimator(X, sigma):
    return np.dot(np.dot(np.dot(np.dot(np.linalg.inv(np.dot(X.T, X)), X.T), sigma), X), np.linalg.inv(np.dot(X.T, X)))


def get_regressionvbs(Y_hat_col):
    Ytminus1 = np.array(get_Ylag(1, Y_hat_col))
    delta_Ytminus1 = np.array(get_deltaYs(Y_hat_col)[1])
    indp_vbs = np.vstack([Ytminus1, delta_Ytminus1])
    delta_Yt = np.array(get_deltaYs(Y_hat_col)[0])
    dep_vb = delta_Yt
    return(indp_vbs, dep_vb)


nsample = 100
x = np.linspace(0, 10, 100)
X = np.column_stack((x, x**2))
beta = np.array([1, 0.1, 10])
e = np.random.normal(size=nsample)

X = sm.add_constant(X)
y = np.dot(X, beta) + e
#print(X)
#print(y)


indep_vbs = get_regressionvbs(Y_hat_n[0])[0].T
#print(indep_vbs.shape)
dep_vb = get_regressionvbs(Y_hat_n[0])[1]
#print(dep_vb.shape)
num_target_indepvb = 0

def ols(dep_vb, indep_vbs):
    model = OLS(dep_vb, indep_vbs).fit()
    prediction = model.predict()
    residuals = dep_vb - prediction
    return(model.params, residuals, prediction)


# for beta 0 the target is the first entry so num_target_indepvb = 0
def get_test_stat(indep_vbs, dep_vb, num_target_indepvb):
    coeff, resid, pred = OLS(dep_vb, indep_vbs)
    sigma = np.diag(resid**2)
    sigma_hat = cov_matrix_estimator(indep_vbs, sigma)
    test_stat = coeff[num_target_indepvb]/ np.sqrt(np.abs(sigma_hat[num_target_indepvb][num_target_indepvb]))
    return(test_stat)

get_test_stat(indep_vbs, dep_vb, num_target_indepvb)


 def ols(dep_vb, indep_vbs):
     model = OLS(dep_vb, indep_vbs).fit()
     prediction = model.predict()
     residuals = dep_vb - prediction
     return(model.params, residuals, prediction)


# the inputs are the big Yhat data containing all teh Yhats and the critical value
def count_avg_num_rejections(Yhats, test_crit):
    num_rejects = 0
    num_yhats = Yhats.shape[1]
    for i in Yhats:
        #getting the corresponding indep vbs
        indep_vbs = get_regressionvbs(Yhats[i])[0].T
        #getting the corresponding dep vb
        dep_vb = get_regressionvbs(Yhats[i])[1]
        #getting the test stat for this specific y_hat
        test_stat = get_test_stat(indep_vbs, dep_vb, 0)
        print(test_stat)
        if test_stat < test_crit:
             num_rejects += 1
    avg_num_rejects = num_rejects * 100 / num_yhats
    return (avg_num_rejects)


print("Number of times the Null was rejected out of all 1000 cases:", count_avg_num_rejections(Y_hat, -1.95))
print(count_avg_num_rejections(Y_hat, -1.95))



# Importing the data set
X = pd.read_csv('Regressors.txt', header=None)
y = pd.read_csv('Observables.txt', header=None)

#print(X)
#print(y)

def statistic(beta, s):
    return(beta / np.sqrt(np.abs(s)))
#print(np.abs(2))

def ols(X, y):
    model = OLS(y, X).fit()
    prediction = model.predict()
    residuals = y - prediction
    return(model.params, residuals, prediction)

# Heteroskedasticity-consistent covariance matrix estimator

def cov_matrix_estimator(X, sigma):
    return(np.dot(np.dot(np.dot(np.dot(np.linalg.inv(np.dot(X.T, X)), X.T), sigma), X), np.linalg.inv(np.dot(X.T, X))))

def t_test(X, y):
    params, residuals, prediction = ols(X, y)
    sigma = np.diag(residuals**2)
    cov_matrix = cov_matrix_estimator(X, sigma)
    stat = statistic(params[1], cov_matrix[1][1])
    return(stat)


from scipy.stats import norm
alpha = 0.05
prob = 1-alpha/2
c = norm.ppf(prob)


stats = []
rejected = 0
for column in y:
    stat = t_test(X, y[column])
    if np.abs(stat) > c:
        rejected += 1
print("Rejection: {:%}".format(rejected / y.shape[1]))

print(c)
print(prob)







