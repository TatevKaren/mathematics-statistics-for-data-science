import numpy as np
from scipy.stats import t
mu_s = [9,30]
sigma_cov = [[1,0.1],[0.1,1]]

n = 10
p = 0.8
N = 100
num_pred =2
M = [N,num_pred]
mu = 0
sigma = 1
np.random.seed(3)

# sampling betas from multivariate normal for the true parameters beta
betas = np.random.multivariate_normal(mu_s, sigma_cov).reshape((2, 1))
# intercept alpha
alpha = np.random.uniform(0, 2, [1, 1])

# the intecept, and the slope coeffitients
beta = np.append(alpha, betas, axis=0)

# sampling from the binomial distribution with 100 observations and 2 columns
X = np.random.binomial(n, p, M)
# adding a ones column for the intercept here carefull with [N,1] and with np.append, axis =1
I = np.ones([N, 1])
X = np.append(X, I, axis=1)

# error terms need to be normally distributed
e = np.random.normal(mu, sigma, N).reshape((N, 1))

# getting eth outcome variable
Y = np.dot(X, beta) + e


# getting eth outcome variable
Y =  np.dot(X,beta) + e