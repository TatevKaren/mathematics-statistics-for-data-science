import numpy as np
import matplotlib.pyplot as plt

#function in the expected value
def h(x):
    value = np.exp(-1*x + np.cos(x))
    return(value)

#proposal function which we have access to Exp(2)
def f(x):
    value = np.exp(-2*x)
    return(value)

#target distribution function
def g(x):
    value = np.exp(-1*x)
    return(value)

def Importance_sampling(M):

    importance_samples = []
    for i in range(M):
        #drawing from our proposal distribution
        x = np.random.exponential(2)
        importance_weight = g(x)/f(x)
        importance_sample = importance_weight*h(x)
        importance_samples.append(importance_sample)

    return(importance_samples)



importance_values = Importance_sampling(M = 1000)
Importance_Sampling_expected_value = np.mean(importance_values)
print(Importance_Sampling_expected_value)
x_values = np.arange(0,2.5,0.001)
y_proposal = np.array(f(x_values))
y_target = np.array(g(x_values))
y_h = np.array(h(x_values)*g(x_values))
plt.plot(x_values,y_proposal, color ='black',linewidth = 2,label = 'Proposal Distribution f(x)')
plt.plot(x_values,y_target, color ='purple',linewidth = 2,label = 'Target Distribution g(x)')
plt.plot(x_values,y_h, color ='orange',linewidth = 2,label = 'Function for Expected Value h(x)*g(x)')
plt.title("Importance Sampling with Exp(1)")
plt.xlabel("Expected Values = " + str(Importance_Sampling_expected_value))
plt.legend()
plt.show()