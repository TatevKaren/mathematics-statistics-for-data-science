# Mathematics-Statistics 
# 1: Linear Regression 

File name: MultipleLinearRegression_OLS.py, MultipleLinearRegression_example.ipynb

Linear regression is a linear approach to model the relationship between a scalar response (dependent varaible) and one or more explanatory variables (independent variables). The case of having single explanatory variable, the method is referred as simple linear regression. In case of having multiple explanatory variablea, the method is referred as multiple linear regression. Ordinary least squares (OLS) is a type of linear least squares method for estimating the unknown parameters in a linear regression model. OLS chooses the parameters of a linear function of a set of explanatory variables by using the principle of least squares that minimizes the sum of the squares of the residuals" (differences between the observed dependent variable and those predicted by the linear function). The method is largely applied in Econometrics, Finance, Data Science and other subject areas. 

Publications:

- Kumari, K. and Yadav, S. (2018). Linear regression analysis study. 4101(4): 33
- Kaya, U., Neşe, G. (2013). A Study on Multiple Linear Regression Analysis. 1016(106): 234–240


# 2: Linear Discriminant Analysis (LDA) Algorithm 

File name: LDA.R

Note: the code contains LDA and robust LDA mannually written functions (checked with the library function's output)

Linear discriminant analysis (LDA) (don't confuss this with Latent Dirichlit Allocation which is Topic Modelling technique) is a generalization of Fisher's linear discriminant, which is a statistical method to find a linear combination of features that characterizes/separates two or more classes of objects. The resulting combination may be used as a linear classifier. LDA is closely related to analysis of variance (ANOVA) and regression analysis, which also attempt to express one (dependent) variable as a linear combination of other (independent) variables. However, ANOVA uses a continuous dependent variable and categorical independent variables, whereas LDA uses a categorical dependent variable (classes of LDA) and continuous independent variables. Logistic regression and Probit regression are more similar to LDA than ANOVA is, as they also explain a categorical (dependent) variable by the values of continuous (independent) variables. The key difference between Logistic Regression/Probit regression and LDA is the assumption about the probability distribution about the explanatory (independent) variables. In case of LDA , fundamental assumtion is that the independent variables are normally distributed. This can be checked by looking at the probability distribution of the variables. 

Linear discriminant analysis is largely used in the field of Computer Science and AI in the Face Recognition to reduce the number of features to a more manageable number before the process of classification. Each of the new dimensions generated is a linear combination of pixel values, which form a template. LDA is also used in Data Science for customer segementation. For instance LDA is used to identify the type of customers which are most likely to buy a particular product in a shopping mall. Finally LDA is used in Medicine: In this field, to classify patient's disease state to three categories (mild, moderate, severe) based upon the patient characteristics, symptoms and the type of treatment he is going through. This helps the doctors to intensify or reduce the pace of their treatment.

Publications:

- Nasar, S., Aldian, A., Nuredin, J., and Abusaeeda, I. (2016). Classification depend on linear discriminant analysis using desired outputs. 1109(10) 
- Zhao, H., Wang, Z., and Nie, F. (2019) A New Formulation of Linear Discriminant Analysis for Robust Dimensionality Reduction. 31(4):629-640, 


# 3: FastMCD algorithm 
File name: FastMCD.R, FastMCD.pdf

FastMCD statistical algorithm to estimate scaltter and location parameters FASTMCD computes the MCD estimator of a multivariate data set. This estimator is given by the subset of h observations with smallest covariance determinant. The MCD location estimate is then the mean of those h points,and the MCD scatter estimate is their covariance matrix.  The default value of h is roughly 0.75n (where n is the total number of observations), but the user may choose each value between n/2 and n.

The MCD method is intended for continuous variables, and assumes that the number of observations n is at least 5 times the number of variables p. If p is too large relative to n, it would be better to first reduce p by variable selection or principal components. It is a robust method in the sense that the estimates are not unduly influenced by outliers in the data, even if there are many outliers. Due to the MCD's robustness, we can detect outliers by their large robust distances. The latter are defined like the usual Mahalanobis distance, but based on the MCD location estimate and scatter matrix (instead of the nonrobust sample mean and covariance matrix).

The FASTMCD algorithm uses several time-saving techniques which make it available as a routine tool to analyze data sets with large n,and to detect deviating substructures in them. A full description of the algorithm can be found in: An important feature of the FASTMCD algorithm is that it allows for exact fit situations, i.e. when more than h observations lie on a (hyper)plane. Then the program still yields the MCD location and scatter matrix, the latter being singular (as it should be), as well as the equation of the hyperplane.

Publications:
   - Rousseeuw, P.J. (1984), "Least Median of Squares Regression," 
   Journal of the American Statistical Association, Vol. 79, pp. 871-881.
   - Rousseeuw, P.J. and Van Driessen, K. (1999), "A Fast Algorithm for the 
   Minimum Covariance Determinant Estimator," Technometrics, Vol. 41, pp. 212-223.

# 4: Kolmogorov-Smirnov test
File Name: KS_D_statistics.py, KS_D_statistics.py

Kolmogorov–Smirnov test (K–S test or KS test) is a nonparametric test of the equality of continuous, one-dimensional probability distributions that can be used to compare a sample with a reference probability distribution (one-sample K–S test), or to compare two samples (two-sample K–S test). The KS statistic quantifies a distance between the empirical distribution function of the sample and the cumulative distribution function of the reference distribution, or between the empirical distribution functions of two samples. In this case it has been calculated using Garch distribution. The null distribution of this statistic is calculated under the null hypothesis that the sample is drawn from the reference distribution (in the one-sample case) or that the samples are drawn from the same distribution (in the two-sample case). 

Publications:
   - Richard S. & Pierre L. (2011), "Computing the Two-Sided Kolmogorov-Smirnov Distribution,"
    Journal of Statistical Software, Vol. 39, pp. 1-18.
    
    
# 5: kNN Imputation to handle missing data
File Name: kNN_Imputation.R, kNN_Imputation.pdf

k-Nearest Neighbour Imputation techique is one of the most popular imputation techniques to handle missing data which can cause problems in many machine learning algorithms. Missing values exist in almost all datasets and it is essential to handle them properly in order to construct reliable machine learning models with optimal statistical power. This imputer utilizes the k-Nearest Neighbors method to replace the missing values in the datasets with the mean value from the parameter ‘n_neighbors’ nearest neighbors found in the training set. By default, it uses a Euclidean distance metric to impute the missing values. One thing to be aware of here is that the kNN Imputer does not recognize text data values. Using strings instead of numerical data values will result in errors. To solve this, one can use One-Hot-Encoder to transform string type varaibles to numerical ones. Another important point here is that the kNN Imptuer is a distance-based imputation method and it requires normalized data. 

Publications:
   - Pan, R., (2015). "Missing data imputation by K nearest neighbours based on grey relational structure and mutual information," The International Journal of Artificial Intelligence, Neural Networks, and Complex Problem-Solving Technologies, 42(4).



   
# 6: Principal Componennt Analysis (PCA)
File Name: PCA_Analysis.R

PCA is used in exploratory data analysis and for making predictive models. It is commonly used for dimensionality reduction by projecting each data point onto only the first few principal components to obtain lower-dimensional data while explaining as much possible variation in the data. PCA is scale-insensitive, therefore data normalization is not necessary. The first principal component can equivalently be defined as a direction that maximizes the variance of the projected data. The principal components are eigenvectors of the data's covariance matrix. To determine optimal number of PC's one can use one of the following methods: Keizer Rule, Elbow Rule

Publicatioons: 
   - Mishra, S., Sarkar, U., Taraphder, S., (2017). "Principal Component Analysis". International Journal of Livestock Research. 1(10)


