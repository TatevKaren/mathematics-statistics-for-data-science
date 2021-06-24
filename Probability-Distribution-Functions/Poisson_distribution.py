import numpy as np
#arrival rate
lambda_ = 8
N = 1000
X = np.random.poisson(lambda_,N)


import matplotlib.pyplot as plt
counts, bins, ignored = plt.hist(X, 40, density = True, color = 'purple')
plt.title("Randomly generating from Poisson Distribution with lambda = 8")
plt.xlabel("Number of arrivals")
plt.ylabel("Probability")
plt.show()