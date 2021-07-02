
# Random Sampling
- With or without replacement


```
import numpy as np

N = 10000
mu = 10
std = 2
population_df = np.random.normal(mu,std,N)


def random_sampling(df, replace, n):
    random_sample = np.random.choice(df,replace = replace, size = n)
    return(random_sample)
    
```
