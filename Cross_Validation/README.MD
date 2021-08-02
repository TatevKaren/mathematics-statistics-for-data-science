# Validation Set Approach
A simple approach to randomly split the data into training and validation sets. the train the model on the train set and use it to predict the values for the hold-out or Validation set and this is the test error rate. 

# LOOCV
LOOCV is similar to the Validation set approach but what it does differently is that each time it leaves one observation out of the training set and uses the remaining N-1 to train the model and calculates the MSE for that one observation, then this is repeated for all observations and N MSEs are calculated. the mean of the MSEs is the CV(n) Cross-Validation error rate. 
<br>

<img width="188" alt="Screenshot_2021-06-06_at_6 42 41_PM" src="https://user-images.githubusercontent.com/76843403/127901402-8f465507-b175-4a22-8e04-131bf24027d9.png">


# K-fold CV
In this case the data is randomly sampled into K equally sized samples (K-folds) and then each time 1 is used as validation and the rest as training and the model is fit K times. and the mean of K MSEs forms the Cross validation test error rate.
<br>

<img width="178" alt="Screenshot_2021-06-06_at_6 54 30_PM" src="https://user-images.githubusercontent.com/76843403/127901474-dc365594-d216-4992-8229-1898e968db4a.png">


**Bias Variance trade-off**

Usually, K-Fold CV and LOOCV provide similar results and their performance can be evaluated using simulated data. LOOCV has lower bias (unbiased) compared to K-fold CV because LOOCV uses more training data than K-fold CV does. But LOOCV has higher variance than K-fold does because LOOCV is fitting the model on almost identical data each item and the outcomes are highly correlated than the outcomes of K-Fold which are less correlated. Since the mean of highly correlated outcomes has higher variance than the one of less correlated the LOOCV varaince is higher.


