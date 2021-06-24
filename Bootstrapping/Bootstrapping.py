import numpy as np
import matplotlib.pyplot as plt

# ---------- Population Distribution --------------#
np.random.seed(2021)
min_value = 130
max_value = 250
N = 50000
# simulated population distribution
height_pop = np.random.randint(min_value,max_value,size = N)

# population mean
pop_mean = np.mean(height_pop)
print(pop_mean)

# population std
pop_std = np.std(height_pop)
print(pop_std)


# population median
pop_median = np.median(height_pop)
print(pop_median)

# ---------- Sampling from Population Distribution --------------#
height_sample = np.random.choice(height_pop, size = 1000)

#sample mean
sample_mean = np.mean(height_sample)
print(sample_mean)

#sample std
sample_std = np.std(height_sample)
print(sample_std)


# sample median
sample_median = np.median(height_sample)
print(sample_median)


# ---------- Sampling from Population Distribution Bootrapping--------------#
def get_Bootstrapped_samples(B):

    bootsraped_means = []
    bootsraped_medians = []

    for i in range(B):
        bootstrap_height_sample = np.random.choice(height_pop, replace=True, size=1000)

        # Bootstrap sample mean
        b_sample_mean = np.mean(bootstrap_height_sample)
        bootsraped_means.append(b_sample_mean)

        # Bootstrap sample std
        b_sample_std = np.std(bootstrap_height_sample)

        # Bootstrap sample median
        b_sample_median = np.median(bootstrap_height_sample)
        bootsraped_medians.append(b_sample_median)

    return(bootsraped_means,bootsraped_medians)

B = 1000
bootsrap_means,bootstrap_medians = get_Bootstrapped_samples(B)


SE_mean = np.std(np.array(bootsrap_means))
SE_median = np.std(np.array(bootstrap_medians))
print(SE_mean)
print(SE_median)







