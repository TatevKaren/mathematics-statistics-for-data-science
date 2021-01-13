# Mathematics-Statistics 

# 1: FastMCD algorithm 
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

# 2: Kolmogorov-Smirnov test
File Name: KS_D_statistics.py, KS_D_statistics.py
Programming language: Python (3)

Kolmogorov–Smirnov test (K–S test or KS test) is a nonparametric test of the equality of continuous, one-dimensional probability distributions that can be used to compare a sample with a reference probability distribution (one-sample K–S test), or to compare two samples (two-sample K–S test). The KS statistic quantifies a distance between the empirical distribution function of the sample and the cumulative distribution function of the reference distribution, or between the empirical distribution functions of two samples. In this case it has been calculated using Garch distribution. The null distribution of this statistic is calculated under the null hypothesis that the sample is drawn from the reference distribution (in the one-sample case) or that the samples are drawn from the same distribution (in the two-sample case). 

Publications:
   - Richard S. & Pierre L. (2011), "Computing the Two-Sided Kolmogorov-Smirnov Distribution,"
    Journal of Statistical Software, Vol. 39, pp. 1-18.
