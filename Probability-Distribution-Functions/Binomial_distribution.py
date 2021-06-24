import numpy as np
#Random Generations of 1000 independent Binomial samples
# (fair coin tosses 10 times in each experiment) 1000 times
n = 10
p = 0.5
N = 1000
X = np.random.binomial(n,p,N)

#Plotting Binomial distribution and adding Normal distribution line
import matplotlib.pyplot as plt
from scipy.stats import norm

# population mean and sigma
mu = n*p
sigma = np.sqrt(n*p*(1-p))
x_values = np.arange(0,10,0.1)


# histogram of Binomial distribution
counts, bins, ignored = plt.hist(X, 10, density = True, rwidth = 0.8, color = 'purple')

# Plot of Normal distribution
plt.plot(x_values, norm.pdf(x_values, mu,sigma), color = 'y', linewidth = 1.5)
plt.title("Randomly generated 1000 obs from Binomial distribution with p = 0.5")
plt.xlabel("Number of successes")
plt.ylabel("Probability")
plt.show()


