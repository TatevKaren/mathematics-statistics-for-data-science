import numpy as np
import statsmodels.api as sm
import pandas as pd

N = 1000
X = np.random.binomial(30,0.5,size = [N,1])
Y = np.random.randint(2,size = [N,1])

data = pd.DataFrame(np.append(X,Y,axis = 1))
data.columns = ["X","Y"]

data_train = data.sample(int(N*0.8))
data_test = data.drop(index = data_train.index)

X_train = data_train["X"]
Y_train = data_train["Y"]

X_test = data_test["X"]
Y_test = data_test["Y"]

# Logistic regression model
logit_model = sm.Logit(Y_train,X_train)
fitted_model = logit_model.fit()
print(fitted_model.summary())

# predicted log odds
logodds_pred = fitted_model.predict(X_test)
prob_pred = np.exp(logodds_pred)/(1+np.exp(logodds_pred))

def get_y_pred(p_x):
    if p_x>=0.5:
        y_pred = 1
    else:
        y_pred = 0
    return(y_pred)

def get_deviance(Y,Y_pred):
    sum = 0
    Y= np.array(Y)
    Y_pred = np.array(Y_pred)
    for i in range(len(Y)):
        if Y[i] == Y_pred[i]:
              sum += 1
    return(sum/len(Y))


Y_pred = prob_pred.apply(get_y_pred)
deviance_test_error_rate = get_deviance(Y_test,Y_pred)
print(deviance_test_error_rate)

