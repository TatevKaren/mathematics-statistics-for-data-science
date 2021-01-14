# Mathematics-Statistics 
# 1: Linear Regression Analysis

File name: MultipleLinearRegression_OLS.py, MultipleLinearRegression_example.ipynb
Programming Language: Python, Jupiter Notebook

Linear regression is a linear approach to model the relationship between a scalar response (dependent varaible) and one or more explanatory variables (independent variables). The case of having single explanatory variable, the method is referred as simple linear regression. In case of having multiple explanatory variablea, the method is referred as multiple linear regression. Ordinary least squares (OLS) is a type of linear least squares method for estimating the unknown parameters in a linear regression model. OLS chooses the parameters of a linear function of a set of explanatory variables by using the principle of least squares that minimizes the sum of the squares of the residuals" (differences between the observed dependent variable and those predicted by the linear function). The method is largely applied in Econometrics, Finance, Data Science and other subject areas. 

Publications:

- Kumari, K. and Yadav, S. (2018). Linear regression analysis study. 4101(4): 33
- Kaya U., Neşe. G. (2013). A Study on Multiple Linear Regression Analysis. 1016(106): 234–240


# 2: Event Study Analysis

File name: EventStudy.do
Programming Language: STATA

In this STATA do file you can find the code of an entire event study analysis that investigates the impact of external event on (e.g. Trump Tweets) on the stock prices, where for the stock prices "daily" data frequency has been considered and for the event window intervals of [-100, 100] days & [-250, 250] days have been considered. The analysis contains stock prices for 45 unique company's. Per company we have run OLS regression where company's return has been regressed on the market return and event date. The do file consists of the following parts:

- Running OLS regressions for 45 companies
- Predicting residuals of the OLS model
- Use obtained residuals to build Empirical Model (GARCH(1/1) & ARCH(1/1))
- Obtain test statistics to test the hypothesis with KS-test (part of the Kolmogorov-Smirnov test)

File name: EventStudy.py
Programming Language: Python

Continuation of the STATA part of the analysis. The python file consists of the following parts:

- Obtaining Heteroskedasticity-consistent covariance matrix estimator
- Running another set of OLS regressions
- Obtain test statistics to test the hypothesis with KS-test 
- Determine the p-value of the test

Publications:

- 

# 3: FastMCD algorithm 
File name: FastMCD.R, FastMCD.pdf
Programming language: R (R-Studio)

FastMCD statistical algorithm to estimate scaltter and location parameters FASTMCD computes the MCD estimator of a multivariate data set. This estimator is given by the subset of h observations with smallest covariance determinant. The MCD location estimate is then the mean of those h points,and the MCD scatter estimate is their covariance matrix.  The default value of h is roughly 0.75n (where n is the total number of observations), but the user may choose each value between n/2 and n.

The MCD method is intended for continuous variables, and assumes that the number of observations n is at least 5 times the number of variables p. If p is too large relative to n, it would be better to first reduce p by variable selection or principal components. It is a robust method in the sense that the estimates are not unduly influenced by outliers in the data, even if there are many outliers. Due to the MCD's robustness, we can detect outliers by their large robust distances. The latter are defined like the usual Mahalanobis distance, but based on the MCD location estimate and scatter matrix (instead of the nonrobust sample mean and covariance matrix).

The FASTMCD algorithm uses several time-saving techniques which make it available as a routine tool to analyze data sets with large n,and to detect deviating substructures in them. A full description of the algorithm can be found in: An important feature of the FASTMCD algorithm is that it allows for exact fit situations, i.e. when more than h observations lie on a (hyper)plane. Then the program still yields the MCD location and scatter matrix, the latter being singular (as it should be), as well as the equation of the hyperplane.

Publications:
   - Rousseeuw, P.J. (1984), "Least Median of Squares Regression," 
   Journal of the American Statistical Association, Vol. 79, pp. 871-881.
   - Rousseeuw, P.J. and Van Driessen, K. (1999), "A Fast Algorithm for the 
   Minimum Covariance Determinant Estimator," Technometrics, 41, pp. 212-223.

# 4: Kolmogorov-Smirnov test
File Name: KS_D_statistics.py, KS_D_statistics.py
Programming language: Python (3)

Kolmogorov–Smirnov test (K–S test or KS test) is a nonparametric test of the equality of continuous, one-dimensional probability distributions that can be used to compare a sample with a reference probability distribution (one-sample K–S test), or to compare two samples (two-sample K–S test). The KS statistic quantifies a distance between the empirical distribution function of the sample and the cumulative distribution function of the reference distribution, or between the empirical distribution functions of two samples. In this case it has been calculated using Garch distribution. The null distribution of this statistic is calculated under the null hypothesis that the sample is drawn from the reference distribution (in the one-sample case) or that the samples are drawn from the same distribution (in the two-sample case). 

Publications:
   - Richard S. & Pierre L. (2011), "Computing the Two-Sided Kolmogorov-Smirnov Distribution,"
    Journal of Statistical Software, Vol. 39, pp. 1-18.
