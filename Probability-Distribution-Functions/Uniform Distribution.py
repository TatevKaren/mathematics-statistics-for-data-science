import numpy as np
# parameters for the Uniform Distribution
a = 2
b = 12
N = 100

# Ranopmly generating 1000 observations from Uniform
X = np.random.uniform(a,b,1000)


# plotting the histogram of generated data from Uniform distribution
import matplotlib.pyplot as plt
count, bins, ignored = plt.hist(X, 30, density = True, color = 'purple', label = 'Uniform Sampling Distribution')

# ------ adding the population distribution with a and b ----------
# for x-axis the values need to go from a to b
x_values = np.linspace(a,b)
# for y-axis the values need to be all the same equal to 1/b-1
y_values = np.repeat(1/(b-a), len(x_values))

plt.plot(x_values, y_values, linewidth = 2.5, color = 'y', label = 'Uniform Population Distribution')
plt.title("Randomly generating 1000 obs from Uniform distribution a = 2 b = 12")
plt.ylabel("Probability")
plt.legend()
plt.show()