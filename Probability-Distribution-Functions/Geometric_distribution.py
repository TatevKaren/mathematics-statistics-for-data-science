import numpy as np
p = 0.5
N = 1000
X = np.random.geometric(p,N)


import matplotlib.pyplot as plt
count, bins,ignored = plt.hist(X, 30, density = True, color = 'purple', rwidth = 1)
plt.title("Randomly generating from Geometric Distribution with p = 0.5")
plt.xlabel("Number of trials needed until first success")
plt.ylabel("Probability")
plt.show()
