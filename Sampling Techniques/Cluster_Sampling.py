import numpy as np
import pandas as pd
import random

price_vb  = pd.Series(np.random.uniform(1,4,size = N))
id = pd.Series(np.arange(0,len(price_vb),1))
event_type = pd.Series(np.random.choice(["type1","type2","type3"],size = len(price_vb)))
df = pd.concat([id,price_vb,event_type],axis = 1)
df.columns = ["id","price","event_type"]

def get_clustered_Sample(df, n_per_cluster, num_select_clusters):
    N = len(df)
    K = int(N/n_per_cluster)
    data = None
    for k in range(K):
        sample_k = df.sample(n_per_cluster)
        sample_k["cluster"] = np.repeat(k,len(sample_k))
        df = df.drop(index = sample_k.index)
        data = pd.concat([data,sample_k],axis = 0)

    random_chosen_clusters = np.random.randint(0,K,size = num_select_clusters)
    samples = data[data.cluster.isin(random_chosen_clusters)]
    return(samples)

print(get_clustered_Sample(df = df, n_per_cluster = 100, num_select_clusters = 2))