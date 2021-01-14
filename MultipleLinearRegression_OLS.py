import numpy as np
from sklearn.linear_model import LinearRegression
from sklearn.preprocessing import PolynomialFeatures
from sklearn.metrics import mean_squared_error, r2_score
import statsmodels.api as sm


#-------------------------  Linear Regression -----------------------------#


# generating independent variables matrix, single variable
#training
x_train = np.array([5, 15, 25, 35, 45, 55]).reshape((-1, 1))
#test
x_test = np.arange(5).reshape((-1,1))

# generating dependent variable vector
y = np.array([5, 20, 14, 32, 22, 38])

# defining the linear model (first argument == True means including constant variable in the model)
# adding an intercept can also be done manually: see MLR case underneath
model = LinearRegression(fit_intercept = True, normalize = False)

# Step 1: Fitting  the model
fit_model = model.fit(x_train,y)

# Step 2: Predicting the model using fitted model and test data
y_pred = fit_model.predict(x_test)

# Step3: Obtaining the R-squared, goodness of fit of the model (%variation explained by the model)
R_sq = fit_model.score(x,y)

# Printing the results
print("R-squared is: ", R_sq)
print("The intercept, the average if all indep vb's 0:",fit_model.intercept_)
print("The coefficient, the impact of main indep ceteris paribus:",fit_model.coef_)
print("preditcted y:", y_pred, sep = '\n')



#------------------------- Multiple  Linear Regression ------------------------#

#training data (multiple independnt varaibles)
x_train = [[0, 1], [5, 1], [15, 2], [25, 5], [35, 11], [45, 15], [55, 34], [60, 35]]
#test data
x_test = [[0, 2], [4, 2], [13, 1], [20, 3], [30, 10], [42, 12], [50, 30], [58, 32]]
#dependent variable
y = [4, 5, 20, 14, 32, 22, 38, 43]

x_train, y = np.array(x_train), np.array(y)
print(x_train,y)


# optional: adding constant column to the predictor's matrix to get an intercept
x_train = sm.add_constant(x_train)
x_test = sm.add_constant(x_test)
print(x_train, x_test)

model = LinearRegression()
# fitting the model
fit_model = model.fit(x_train,y)
R_sq = fit_model.score(x_train,y)
print("R-squared is: ", R_sq)
print("The intercept:",fit_model.intercept_)
print("The coefficients:",fit_model.coef_)
y_pred = fit_model.predict(x_test)
print(y_pred)


#---------------------------- OLS  Estimation ------------------------------#
model = sm.OLS(y,x)
fit_model = model.fit()
print(fit_model.summary())
print('R_squared:', fit_model.rsquared)
print('R_squared_adjusted, in case of MLR what matters:', fit_model.rsquared_adj)
# prediction
y_pred = fit_model.predict(x_new)
print('predicted response:', y_pred, sep='\n')

