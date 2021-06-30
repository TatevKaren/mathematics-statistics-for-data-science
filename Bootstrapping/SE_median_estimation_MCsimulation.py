import numpy as np
k = 3
N = 100
M = 1000

def get_median_MC(M):
    medians = []
    for i in range(M):
        X = np.random.gamma(2,2, N)
        median_i = np.median(X)
        medians.append(median_i)
    return(np.array(medians))


medians = get_median_MC(M)[0]
print(medians)

medianMC = np.mean(medians)
print(medianMC)

medianMC_std = np.std(medians)
print(medianMC_std)

median_SE = medianMC_std/np.sqrt(N)
print(median_SE)

X = np.random.gamma(2,2,N)
import matplotlib.pyplot as plt
counts, bins, ignored = plt.hist(X,50,density = True,color = 'purple',label = 'Skewed Distribution: Gamma(2,2)')
plt.axvline(medianMC,0,10,color = 'y',label = 'median', linewidth = 2)
plt.legend()
plt.show()







