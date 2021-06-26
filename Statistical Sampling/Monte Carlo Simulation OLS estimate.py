import numpy as np
import statsmodels.api as sm

np.random.seed(2021)
mu = 0
sigma = 1
# number of observations
n = 100

alpha = np.repeat(0.5, n)
beta = 1.5


def MC_estimation_slope(M):
    MC_betas = []
    MC_samples = {}

    for i in range(M):
        # to make sure the variance in X is bigger than the variance in the error term
        X = 9 * np.random.normal(mu, sigma, n)
        # random error term
        e = np.random.normal(mu, sigma, n)
        # determining Y
        Y = (alpha + beta * X + e)
        MC_samples[i] = Y

        # running regression
        model = sm.OLS(Y.reshape((-1, 1)), X.reshape((-1, 1)))
        ols_result = model.fit()

        # getting model slope
        coeff = ols_result.params
        MC_betas.append(coeff)

    MC_beta_hats = np.array(MC_betas).flatten()

    return (MC_samples, MC_beta_hats)

MS_samples, MC_beta_hats = MC_estimation_slope(M = 10000)
beta_hat_MC = np.mean(MC_beta_hats)

print(MC_beta_hats)
print(beta_hat_MC)
