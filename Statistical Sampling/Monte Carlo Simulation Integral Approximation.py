import numpy as np
from scipy.stats import norm

def MC_prob(M,mu,sigma):
    prob_larger_than3 = []

    for i in range(M):
        # Probability of getting X<=3 with CDF p(Z<=3)
        p = 1- norm.cdf(3, mu, sigma)
        # Probability of X >=3 with Survival Function which is also equal to 1-cdf of that value: P[Z>=3] = 1-P[Z<=3]
        p = norm.sf(3, mu, sigma)
        prob_larger_than3.append(p)
    MC_approximation_prob = np.array(prob_larger_than3).mean()
    return(MC_approximation_prob)


print(MC_prob(M = 10000, mu = 10, sigma = 2))