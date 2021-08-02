# Bootstrapping

It is used in many situations in which it is hard or even impossible to directly compute the standard deviation of a quantity of interest.
A very useful way to quantify the uncertainty associated with the statistical learning method. To obtain the standard errors/measure of variability.

In theory, if we are able to randomly sample 100/1000 samples from the population then we could estimate the Standard error of the target coefficients by calculating their standard deviation. But in practice, it's not possible to random samples from the population 100 or 1000 times. Hence, what Bootstrap does it emulate a new samples generation process from the population s.t. the variability of the estimated coefficients can be determined.

The sampling is performed with replacement, which means that the same observation can occur more than once in the bootstrap data set. So, what Bootstrap does is takes the original training sample and resamples from it by replacement, resulting in B different samples. Then for each of these simulated samples, the coefficient estimate is computed, then by taking the mean of these coefficient estimates and using the common formula for SE we calculate the Standard Error of the Bootrapt model.

<br>
<img width="457" alt="Screenshot_2021-06-07_at_9 18 33_AM" src="https://user-images.githubusercontent.com/76843403/127901830-d245eb24-0bd7-4929-9f68-e2993388ed46.png">

<img width="359" alt="Screenshot_2021-06-07_at_9 22 09_AM" src="https://user-images.githubusercontent.com/76843403/127901896-b9e3dea0-bc83-479e-aa01-9bba6b383253.png">






# Standard Error of Mean and Median
<br><br>
## Estimating Standard Error of Mean
Standard Error of Mean (SEM) is an inferencial statsitics quantifying the variability of the means in the sampling means. For estimating SEM we need the sampling distribution of means. Then using the standard deviation of sample mans and the sample size one can obtain the SEM as follows:<br>
<img width="127" alt="Screenshot 2021-06-30 at 9 01 35 AM" src="https://user-images.githubusercontent.com/76843403/123916300-c7bd1b80-d981-11eb-909b-446135dd5638.png">

## Estimating Standard Error of Median
<img width="459" alt="Screenshot 2021-06-30 at 8 18 30 AM" src="https://user-images.githubusercontent.com/76843403/123917077-ab6dae80-d982-11eb-9469-178ac6c6b7dc.png">
<br>

For **Normally Distributed Sample** we can use the following formula:<br>
<img width="543" alt="Screenshot 2021-06-30 at 9 05 23 AM" src="https://user-images.githubusercontent.com/76843403/123916762-4f0a8f00-d982-11eb-9e97-af6c3061588a.png">

<br>

For other, **Non-symmetric and Skewed Distributed Samples** we can't use the above forumla. We can estimate the SE of median by using **Bootsrapping** (if we have an initial sample) or **Monte Carlo Simulations** (if we have some idea how the distributionn looks like and can use similar distributioon to repreatadly sample from).

<br>


## Solution 1: Estimating SE of Median with Bootstrapping
``` 
import numpy as np
# B: number of Bootstrap samples

bootstrapped_medians = []
for i in range(B):
    #sampling from initial sample with replacement
    bootstrap_sample = np.random.choice(sample, replace=True, size=N)
    bootstrap_sample_median = np.median(bootstrap_sample)
    bootstrapped_medians.append(bootstrap_sample_median)
    
# this vector contains B medians from B bootstrapped samples    
bootstrapped_medians = np.array(bootstrapped_medians) 

# obtain the standard deviation of bootsrapped medians
SE_median = np.std(bootstrapped_medians)
```


<br>

## Solution 1: Estimating SE of Median with Monte Carlo Simulation
In case we do know the underlying population distribution or at least its form.

- Weibull Ditribution
- Exponential Distribution
- Gamma Distribution
- Chi2 Distribution
``` 
import numpy as np
# M: number of MC simulations

MC_medians = []
for i in range(M):
    #sampling from a proposed skewed distribution (e.g. Gamma(2,2))
    MC_sample = np.random.gamma(2,2,N)
    MC_sample_median = np.median(MC_sample)
    MC_medians.appeend(MC_sample_median)

# this vector contains M medians from M MC randomly simulated samples   

SE_median = np.std(MC_medians)/sp.sqrt(N)

```

<img width="968" alt="Screenshot 2021-06-30 at 9 32 49 AM" src="https://user-images.githubusercontent.com/76843403/123920359-27b5c100-d986-11eb-859e-33b69b982b7d.png">

## Testing the difference in means and medians using bootstrapping
![Difference_in_means](https://user-images.githubusercontent.com/76843403/127105780-485c5d0d-aea7-4c1f-aa05-c42fd6d7f14c.png)





