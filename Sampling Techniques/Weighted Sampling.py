
price_vb = pd.Series(np.random.uniform(1, 4, size=N))
id = pd.Series(np.arange(0, len(price_vb), 1))
event_type = pd.Series(np.random.choice(["type1", "type2", "type3"], size=len(price_vb)))
df = pd.concat([id, price_vb, event_type], axis=1)
df.columns = ["id", "price", "event_type"]



def get_weighted_sample(df,n):

    def get_class_prob(x):
        weight_x = int(np.rint(n * len(x[x.click != 0]) / len(df[df.click != 0])))
        sampled_x = x.sample(weight_x).reset_index(drop=True)
        return (sampled_x)
        # we are grouping by the target class we use for the proportions

    weighted_sample = df.groupby('event_type').apply(get_class_prob)
    print(weighted_sample["event_type"].value_counts())
    return (weighted_sample)

print(get_weighted_sample(df,100))