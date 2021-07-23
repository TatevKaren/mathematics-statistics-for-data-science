
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

# Systematic Sampling
``` 
def systematic_sampling(df, step):

    id = pd.Series(np.arange(1,len(df),1))
    df = pd.Series(df)
    df_pd = pd.concat([id, df], axis = 1)
    df_pd.columns = ["id", "data"]
    # this indices will increase with the step amount not 1
    selected_index = np.arange(1,len(df),step)
    # using iloc for getting thee data with selected indices
    systematic_sampling = df_pd.iloc[selected_index]
    return(systematic_sampling)

n = 10
#steps
step = int(N/n)


print(systematic_sampling(population_df, step))

```

# Weighted Sampling
# Cluster Sampling
# Stratified Sampling
