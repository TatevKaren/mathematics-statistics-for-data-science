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

#---------------------Example with Diabetes data ------------------------#

# Load the diabetes dataset
diabetes_X, diabetes_y = datasets.load_diabetes(return_X_y=True)

# Use only one feature
diabetes_X = data_X[:, np.newaxis, 2]
#print(diabetes_X)

# Spliting the data into training/test sets
diabetes_X_train = diabetes_X[:-20]
diabetes_X_test = diabetes_X[-20:]
# Split the targets into training/testing sets
diabetes_y_train = diabetes_y[:-20]
diabetes_y_test = diabetes_y[-20:]

# Defining the model
model = linear_model.LinearRegression()
# Training the model using the training sets
fit_model = model.fit(diabetes_X_train, diabetes_y_train)
# Testing by making predictions using the test set
y_pred = fit_model.predict(diabetes_X_test)

print("The intercept, the average if all indep vb's 0:",fit_model.intercept_)
print("The coefficient, the impact of main indep ceteris paribus: \n",fit_model.coef_)
# The mean squared error, comparing the predicted y's with real y values
print('Mean Squared Error: %.2f'
      % mean_squared_error(diabetes_y_test, y_pred))
# The coefficient of determination: 1 is perfect prediction
print('R_squared: %.2f'
      % r2_score(diabetes_y_test, y_pred))
# print("R-squared is: ", R_sq)

# Plot outputs
plt.scatter(diabetes_X_test, diabetes_y_test,  color='black')
plt.plot(diabetes_X_test, y_pred, color='blue', linewidth=3)
plt.xticks(())
plt.yticks(())
plt.show()