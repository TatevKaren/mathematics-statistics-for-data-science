# Linar Regression

When the relationship between two variables is linear, then Linear Regression is a statistical method that can help to model the impact of a unit change in a variable, the independent variable on the values of another variable, the dependent variable.
Dependent variables are often referred to as response variables or explained variables, whereas independent variables are often referred to as regressors or explanatory variables. When the Linear Regression model is based on a single independent variable, then the model is called Simple Linear Regression and when the model is based on multiple independent variables, it’s referred to as Multiple Linear Regression. Simple Linear Regression can be described by the following expression:
<p href ="https://towardsdatascience.com/fundamentals-of-statistics-for-data-scientists-and-data-analysts-69d93a05aae7" align="left">
<img src = https://miro.medium.com/max/1936/1*EdKLk0rUW2Q3dqcbc_tquQ.png>

</p>
where Y is the dependent variable, X is the independent variable which is part of the data, β0 is the intercept which is unknown and constant, β1 is the slope coefficient or a parameter corresponding to the variable X which is unknown and constant as well. Finally, u is the error term that the model makes when estimating the Y values. The main idea behind linear regression is to find the best-fitting straight line, the regression line, through a set of paired ( X, Y ) data. One example of the Linear Regression application is modeling the impact of Flipper Length on penguins’ Body Mass, which is visualized below.
<br>
<p href ="https://towardsdatascience.com/fundamentals-of-statistics-for-data-scientists-and-data-analysts-69d93a05aae7" align="left">
<img align = "center" width = "500" src = https://miro.medium.com/max/1026/1*cS-5_yS2xa--V97U1RoAIQ.png>

</p>
<br>

## Ordinary Least Squares
The ordinary least squares (OLS) is a method for estimating the unknown parameters such as β0 and β1 in a linear regression model. The model is based on the principle of least squares that minimizes the sum of squares of the differences between the observed dependent variable and its values predicted by the linear function of the independent variable, often referred to as fitted values. This difference between the real and predicted values of dependent variable Y is referred to as residual and what OLS does, is minimizing the sum of squared residuals. This optimization problem results in the following OLS estimates for the unknown parameters β0 and β1 which are also known as coefficient estimates.
