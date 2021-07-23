import numpy as np
import pandas as pd
import random
N = 10000

price_vb  = pd.Series(np.random.uniform(1,4,N))
id = pd.Series(np.arange(0,len(price_vb),1))
df = pd.concat([id,price_vb],axis = 1)
df.columns = ["id","price"]

def get_systematic_sample(df,n):
    n_pop = len(df)
    step = int(n_pop/n)
    step_index_tbs = np.arange(0,len(df),step)
    systamatic_sample = df.iloc[step_index_tbs]
    return(systamatic_sample)

print(get_systematic_sample(df = df,n = 100))