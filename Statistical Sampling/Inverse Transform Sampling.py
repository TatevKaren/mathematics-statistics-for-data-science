from scipy.stats import expon
import numpy as np

#inverse cdf of exponential
def Inverse_transform_sampling_Exponential(M,lambda_):
    expon_x = []

    for i in range(M):
        # random_sampling from uniform distribution/random generator
        u = np.random.uniform(0, 1)
        # inverse cdf of exponential
        x = expon.ppf(u, lambda_) - 1
        expon_x.append(x)

    return(np.array(expon_x))



exponential_random_samples = Inverse_transform_sampling_Exponential(M = 10000,lambda_ = 1)

import matplotlib.pyplot as plt
counts, bins, ignored = plt.hist(exponential_random_samples, 25, density = True, color = 'purple')
plt.title("Inverse Transform Sampling from Exponential Distribution with Unif(0,1) and Inverse CDF")
plt.ylabel("Probability")
plt.show()