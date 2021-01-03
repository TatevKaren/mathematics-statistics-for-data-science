# Mathematics-Statistics Repository

# 1: FastMCD algorithm 
File called: KS_D_statistics.py

FastMCD statistical algorithm to estimate scaltter and location parameters FASTMCD computes the MCD estimator of a multivariate data set. This estimator is given by the subset of h observations with smallest covariance determinant. The MCD location estimate is then the mean of those h points,and the MCD scatter estimate is their covariance matrix.  The default value of h is roughly 0.75n (where n is the total number of observations), but the user may choose each value between n/2 and n.

The MCD method is intended for continuous variables, and assumes that the number of observations n is at least 5 times the number of variables p. If p is too large relative to n, it would be better to first reduce p by variable selection or principal components. It is a robust method in the sense that the estimates are not unduly influenced by outliers in the data, even if there are many outliers. Due to the MCD's robustness, we can detect outliers by their large robust distances. The latter are defined like the usual Mahalanobis distance, but based on the MCD location estimate and scatter matrix (instead of the nonrobust sample mean and covariance matrix).

The FASTMCD algorithm uses several time-saving techniques which make it available as a routine tool to analyze data sets with large n,and to detect deviating substructures in them. A full description of the algorithm can be found in: An important feature of the FASTMCD algorithm is that it allows for exact fit situations, i.e. when more than h observations lie on a (hyper)plane. Then the program still yields the MCD location and scatter matrix, the latter being singular (as it should be), as well as the equation of the hyperplane.

Publications:
   - Rousseeuw, P.J. (1984), "Least Median of Squares Regression," 
   Journal of the American Statistical Association, Vol. 79, pp. 871-881.
   - Rousseeuw, P.J. and Van Driessen, K. (1999), "A Fast Algorithm for the 
   Minimum Covariance Determinant Estimator," Technometrics, 41, pp. 212-223.
