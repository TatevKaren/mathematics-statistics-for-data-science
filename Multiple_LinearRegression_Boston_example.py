# Importing libraries
import numpy as np
import pandas as pd
from scipy import stats

from sklearn.datasets import load_boston
from sklearn import datasets, linear_model
from sklearn.metrics import mean_squared_error, r2_score
from sklearn.linear_model import LinearRegression
from sklearn.preprocessing import PolynomialFeatures

import statsmodels.api as sm
import statsmodels.formula.api as smf
from statsmodels.sandbox.regression.predstd import wls_prediction_std
from statsmodels.stats.outliers_influence import OLSInfluence


import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

#---------------------Example with Boston data ------------------------#

boston = load_boston() # loading the data
X_ = boston.data # independent variables
Y_ = boston.target # dependent variables
Boston_data = np.column_stack([X_,Y_]) # combining them
col_names = np.append(boston.feature_names, 'MEDV') # getting the names
print(col_names)
Boston_df = pd.DataFrame(Boston_data, columns = col_names) # defining the dataframe
Boston_df.head()

# dep vb > medv & indep vb > lstat
model = smf.ols('MEDV ~ LSTAT', data = Boston_df)
fit_model = model.fit()
fit_model.summary()

fit_model.params
# fit_model.fittedvalues
# fit_model.conf_int(alpha=0.05)


# given new values of X we can perform predictions
X_new = pd.DataFrame({'LSTAT': [5,10,15]})
Y_pred = fit_model.get_prediction(X_new)
#Y_pred.summary_frame(alpha = 0.05)

# plot to plot the data, OLS estimate, prediction and confidence intervals
fig, ax = plt.subplots(figsize=(8,6))
x = Boston_df.LSTAT

ax.scatter(x, Boston_df.MEDV, facecolors='none', edgecolors='b', label="data")
ax.plot(x, fit_model.fittedvalues, 'g', label="OLS")

# we need all prediction values to plot prediction and confidence intrvals
predictions = fit_model.get_prediction(Boston_df).summary_frame(alpha=0.05)

# plot the high and low prediction intervals
ax.plot(x, predictions.obs_ci_lower, color='0.75', label="Prediction Interval")
ax.plot(x, predictions.obs_ci_upper, color='0.75', label="")

# plot the high and low mean confidence intervals
ax.plot(x, predictions.mean_ci_lower, color='r',label="Predicted Mean CI")
ax.plot(x, predictions.mean_ci_upper, color='r', label="")

ax.legend(loc='best');

plt.xlabel('LSTAT');
plt.ylabel('MEDV');


# For checking the Linearity, homoskedasticity, Outliers
influence = OLSInfluence(fit_model)
leverage = influence.hat_matrix_diag
studentized_res = influence.resid_studentized_external

fig, (ax1,ax2) = plt.subplots(1,2,figsize=(12,6))
# Plotting the residual for each fitted value
ax1.scatter(fit_model.fittedvalues, fit_model.resid, facecolors='none', edgecolors='b');
ax1.set_xlabel('fitted values');
ax1.set_ylabel('residuals');

# Plotting the studentized residuals
ax2.scatter(fit_model.fittedvalues, studentized_res, facecolors='none', edgecolors='b');
ax2.set_ylabel('Studentized Residuals');
ax2.set_xlabel('fitted values');

# Cheking for High-leverage points
fig, ax = plt.subplots(figsize=(8,6))
ax.scatter(leverage, studentized_res,facecolors='none', edgecolors='b');
ax.set_xlabel('Leverage');
ax.set_ylabel('Studentized Residuals');