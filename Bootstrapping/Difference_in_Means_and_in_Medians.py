import numpy as np
import pandas as pd
from scipy.stats import norm

N = 100
X = pd.Series(np.random.binomial(300,0.7,size =N))
Y1 = np.repeat("Exp",N/2)
N_exp = len(Y1)
Y2 = np.repeat("Cont",N/2)
N_con = len(Y2)

Y = pd.Series(np.append(Y1,Y2))
data = pd.concat([X,Y],axis = 1)
print(data)
means_per_group = data.groupby(1, group_keys = False)[0].mean()
medians_per_group = data.groupby(1)[0].median()

alpha = 0.05
def Bootrapping_for_diff_means_medians(data,B):
    boot_mean_diff = []
    boot_medians_diff = []

    boot_means_con = []
    boot_means_exp = []

    count_num_positives_meandiff = 0
    count_num_positives_mediandiff = 0

    for i in range(B):

        boot_sample = data.sample(frac = 1, replace = True)

        #means of bootstrap sample for control and experimental group
        boot_means_per_group = boot_sample.groupby(1)[0].mean()
        boot_sample_mean_con = boot_means_per_group["Cont"]
        boot_sample_mean_exp = boot_means_per_group["Exp"]

        boot_means_con.append(boot_sample_mean_con)
        boot_means_exp.append(boot_sample_mean_exp)

        # calculating the difference in means per bootstrap sample
        diff_means = boot_sample_mean_exp - boot_sample_mean_con

        #counting number of times is the difference positive
        if diff_means > 0:
            count_num_positives_meandiff += 1

        #medians of bootstrap sample for control and experimental group
        boot_medians_per_group = boot_sample.groupby(1)[0].median()


        #calculating the difference in medians per bootstrap sample
        diff_medians = boot_medians_per_group["Exp"] - boot_medians_per_group["Cont"]
        if diff_medians > 0:
            count_num_positives_mediandiff += 1

        boot_mean_diff.append(diff_means)
        boot_medians_diff.append(diff_medians)


    return(boot_means_con,boot_means_exp,count_num_positives_meandiff,count_num_positives_mediandiff,boot_mean_diff)

B = 10000
X_bars_con,X_bars_exp ,n_means, n_medians,boot_mean_diff = Bootrapping_for_diff_means_medians(data,B)
Z_mean = np.mean(X_bars_exp)- np.mean(X_bars_con)
Z_sigma = np.sqrt((np.var(X_bars_exp)/N_exp + np.var(X_bars_con)/N_con))
CI = [Z_mean - norm.ppf(1-alpha/2)*Z_sigma, Z_mean + norm.ppf(1-alpha/2)*Z_sigma]

print("Mean of X_bar_exp - X_bar_con", Z_mean)
print("Standard Error of X_bar_exp - X_bar_con", Z_sigma)
print("CI of X_bar_exp - X_bar_con", CI)

# 0th percentile
MIN = sorted(boot_mean_diff)[0]
print("0th percentile, min difference in means", MIN)

# 100th percentile
MAX = sorted(boot_mean_diff)[len(boot_mean_diff)-1]
print("100th percentile, max difference in means", MAX)

# 2.5th percentile
percentile_2_5 = sorted(boot_mean_diff)[int(2.5/100 *(len(boot_mean_diff)-1))]
print("2.5th percentile", percentile_2_5)
percentile_50_median = sorted(boot_mean_diff)[int(50/100 *(len(boot_mean_diff)-1))]
print("50 th percentile", percentile_50_median)
print(np.median(boot_mean_diff))
percentile_97_5 = sorted(boot_mean_diff)[int(97.5/100 *(len(boot_mean_diff)-1))]
print("97.5 th percentile", percentile_97_5)





import matplotlib.pyplot as plt
counts,bins,ignored = plt.hist(boot_mean_diff,50,density = True,color = 'purple')
plt.xlabel("mean difference")
plt.title("Distribution of Bootstrapped samples mean difference")

plt.axvline(MIN, 0,1,label = "0th percentile")
plt.axvline(percentile_2_5, 0,1,label = "2.5th percentile")
plt.axvline(Z_mean, 0,1,label = "mean of Z = X_exp_bar-X_con_bar", color = 'y',linewidth = 3)
plt.axvline(percentile_50_median, 0,1,label = "50th percentile/median")
plt.axvline(percentile_97_5, 0,1,label = "97.5th percentile")
plt.axvline(MAX, 0,1,label = "100th percentile")
plt.legend()
plt.show()


p_value_diff_means = n_means/B
p_value_diff_medians = n_medians/B
print(p_value_diff_means)
print(p_value_diff_medians)

#Z_crit = norm.ppf(1 - alpha / 2)