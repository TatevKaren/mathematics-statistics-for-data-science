# Linar Regression
OLS from scratch <a href="https://github.com/TatevKaren/mathematics-statistics-for-data-science/blob/main/Linear%20Regression/Linear%20Regression_OLS.py">Python Code here</a> including calculation of **t-statistics, p-value, Confidence Intervals, MSE, RMSE, R-squared**

When the relationship between two variables is linear, then Linear Regression is a statistical method that can help to model the impact of a unit change in a variable, the independent variable on the values of another variable, the dependent variable.
Dependent variables are often referred to as response variables or explained variables, whereas independent variables are often referred to as regressors or explanatory variables. When the Linear Regression model is based on a single independent variable, then the model is called Simple Linear Regression and when the model is based on multiple independent variables, it’s referred to as Multiple Linear Regression. Simple Linear Regression can be described by the following expression:
<p href ="https://towardsdatascience.com/fundamentals-of-statistics-for-data-scientists-and-data-analysts-69d93a05aae7" align="left">
<img src = https://miro.medium.com/max/1936/1*EdKLk0rUW2Q3dqcbc_tquQ.png>

</p>
where Y is the dependent variable, X is the independent variable which is part of the data, β0 is the intercept which is unknown and constant, β1 is the slope coefficient or a parameter corresponding to the variable X which is unknown and constant as well. Finally, u is the error term that the model makes when estimating the Y values. The main idea behind linear regression is to find the best-fitting straight line, the regression line, through a set of paired ( X, Y ) data. One example of the Linear Regression application is modeling the impact of Flipper Length on penguins’ Body Mass, which is visualized below.
<br><br>
<p href ="https://towardsdatascience.com/fundamentals-of-statistics-for-data-scientists-and-data-analysts-69d93a05aae7" align="left">
<img align = "center" width = "500" src = https://miro.medium.com/max/1026/1*cS-5_yS2xa--V97U1RoAIQ.png>

</p>
<br><br>

## Ordinary Least Squares
The ordinary least squares (OLS) is a method for estimating the unknown parameters such as β0 and β1 in a linear regression model. The model is based on the principle of least squares that minimizes the sum of squares of the differences between the observed dependent variable and its values predicted by the linear function of the independent variable, often referred to as fitted values. This difference between the real and predicted values of dependent variable Y is referred to as residual and what OLS does, is minimizing the sum of squared residuals. This optimization problem results in the following OLS estimates for the unknown parameters β0 and β1 which are also known as coefficient estimates.
### OLS Assumptions
OLS estimation method makes the following assumption which needs to be satisfied to get reliable prediction results:<br>
**A1:** Linearity assumption states that the model is linear in parameters.
<br> **A2:** Random Sample assumption states that all observations in the sample are randomly selected.
<br>**A3:** Exogeneity assumption states that independent variables are uncorrelated with the error terms.
<br>**A4:** Homoskedasticity assumption states that the variance of all error terms is constant.
<br>**A5:** No Perfect Multi-Collinearity assumption states that none of the independent variables is constant and there are no exact linear relationships between the independent variables.



# Linear Regression Examples

Required Files: 
- <a href = "https://github.com/TatevKaren/mathematics-statistics-for-data-science/blob/main/MultipleLinearRegression_OLS.py"> Multiple Linear Regression OLS Python Code</a>
- <a href = "https://github.com/TatevKaren/mathematics-statistics-for-data-science/blob/main/Multiple_LinearRegression_Diabetes_example.py"> Multiple Linear Regression OLS Diabetes Data Example Python Code</a>
- <a href = "https://github.com/TatevKaren/mathematics-statistics-for-data-science/blob/main/Multiple_LinearRegression_Boston_example.py">Multiple Linear Regression OLS Boston Data Example Python Code</a>
- <a href = "https://github.com/TatevKaren/mathematics-statistics-for-data-science/blob/main/Multiple%20LR%20with%20Boston%20data.png">Multiple Linear Regression OLS Boston Data Output</a>
- <a href = "https://github.com/TatevKaren/mathematics-statistics-for-data-science/blob/main/Multiple%20LR%20with%20Boston%20data2.png">Multiple Linear Regression OLS Boston Data Output 2</a>

Linear regression is a linear approach to model the relationship between a scalar response (dependent varaible) and one or more explanatory variables (independent variables). The case of having single explanatory variable, the method is referred as simple linear regression. In case of having multiple explanatory variablea, the method is referred as multiple linear regression. Ordinary least squares (OLS) is a type of linear least squares method for estimating the unknown parameters in a linear regression model. OLS chooses the parameters of a linear function of a set of explanatory variables by using the principle of least squares that minimizes the sum of the squares of the residuals" (differences between the observed dependent variable and those predicted by the linear function). The method is largely applied in Econometrics, Finance, Data Science and other subject areas. 

### Sample output from example
<p align="left">
<img src="https://github.com/TatevKaren/Mathematics-Statistics-for-Data-Science/blob/main/Multiple LR with Boston data.png?raw=true"
  alt="Multivariate Linear Regression sample output"
  width="400" height="400">
</p>

<br>
<p align="left">
  <img src="https://github.com/TatevKaren/Mathematics-Statistics-for-Data-Science/blob/main/Multiple LR with Boston data2.png?raw=true"
  alt="Multivariate Linear Regression plot"
  width="350" height="250">
</p>
Publications:

- Kumari, K. and Yadav, S. (2018). Linear regression analysis study. 4101(4), 33
- Kaya, U., Neşe, G. (2013). A Study on Multiple Linear Regression Analysis. 1016(106), 234–240
<br> 

