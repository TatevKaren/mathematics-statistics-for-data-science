import numpy as np

# randomly sampling 100 obsev from t-distribution
N = 1000
df = N-1
X = np.random.standard_t(df, size = N)


import matplotlib.pyplot as plt
from scipy.stats import t

x_values = np.arange(-5,5,0.1)
y_values = t.pdf(x_values,df)
# Sample Distribution
count, bins, ignored = plt.hist(X, 20, density = True,color = 'purple',label = 'Sample Distribution')
# Population Distribution
plt.plot(x_values,y_values, color = 'y', linewidth = 2.5,label = 'Population Distribution')
#adding title and y-label
plt.title("Randomly sampled from standard Student t-distribution")
plt.ylabel("Probability")
plt.legend()
plt.show()
