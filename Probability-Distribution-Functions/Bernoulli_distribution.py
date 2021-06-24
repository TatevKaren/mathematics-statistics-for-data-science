import numpy as np
# (coin tosses 10 times in each experiment)
n = 1
p = 0.5
N = 1000
# Bernoulli distribution  = binomial with n = 1
X = np.random.binomial(n,p,N)


import matplotlib.pyplot as plt
counts, bins, ignored = plt.hist(X, 2, density = True, rwidth = 0.1, color = 'purple')
plt.title("Randomly Sampling from Bernoulli Distribution")
plt.show()