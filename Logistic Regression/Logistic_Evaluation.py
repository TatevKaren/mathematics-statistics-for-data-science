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

# predicted log odds
logodds_pred = fitted_model.predict(X_test)
# using the logistic function to transform log odds to probabilities
p_pred = np.exp(logodds_pred)/(1+np.exp(logodds_pred))
def get_y_pred(p_x):
    if p_x>=0.5:
        y_pred = 1
    else:
        y_pred = 0
    return(y_pred)

Y_pred = pd.Series(np.array(p_pred.apply(get_y_pred)))
Y_test = pd.Series(np.array(Y_test))


def get_typeI_typeII_error(Y_test,Y_pred):
    Y = pd.concat([Y_test,Y_pred],axis = 1)
    Y.columns = ["true","pred"]
    # False postives: number of times the label was 1 while it was 0 in reality
    # False negtaives: number of cases when the prediction is 0 but true Y = 1

    # False Positives
    TypeI_error = len(Y[(Y["true"] == 1) & (Y["pred"] == 0)])/len(Y)
    # True Positives
    TP = len(Y[(Y["true"] == 1) & (Y["pred"] == 1)])/len(Y)

    # False Negatives
    TypeII_error = len(Y[(Y["true"] == 0) & (Y["pred"] == 1)])/len(Y)
    # True Negatives
    TN = len(Y[(Y["true"] == 1) & (Y["pred"] == 1)])/len(Y)

    return(TP,TypeI_error,TN,TypeII_error)

True_positives, False_positives, True_negatives,False_negatives = get_typeI_typeII_error(Y_test,Y_pred)
Precision = True_positives/(True_positives + False_positives)
Recall = True_positives/(True_positives + False_negatives)
F_1_score  = 2/(1/Precision + 1/Recall)
print(Precision)
print(Recall)
print(F_1_score)

#
#
#
# def K_fold_CV(data,K):
#     folds = {}
#     num_obs_fold = int(len(data) / K)
#     for i in range(K):
#
#         fold_i = data.sample(num_obs_fold)
#         data.drop(index = fold_i.index)
#         folds[i] = fold_i
#     return(folds)
#
# K = 5
# folds = K_fold_CV(data,K)
# Y_predcitions = {}
# for k in range(K):
#     Y_pred = []
#     test = folds[k]
#     train = data.drop(index = test.index)
#     X_test = test["X"]
#     Y_test = test["click"]
#     X_train = train["X"]
#     Y_train = train["click"]
#
#     logit_model_k = sm.Logit(Y_train, X_train)
#     fitted_model_k = logit_model_k.fit()
#     loggodds_pred_test = fitted_model_k.predict(X_test)
#
#     for i in loggodds_pred_test:
#         if i <= 0.5:
#             Y_pred.append(0)
#         else:
#             Y_pred.append(1)
#     Y_predcitions[k] = Y_pred
# print(Y_predcitions)
#
#
#
#
#
#
#
#
#
#
# # import numpy as np
# # data = np.array([5,6,8,9,11,12,14,15,16,16,17,19,20,22,23,25])
#
# def get_p(data,percentile):
#     # obtaining X number of numbers less then X
#     X = len(data[data<percentile])
#     n = len(data)
#     #number of times X appears
#     Y = len(data[data == percentile])
#     #dont forget *100
#     p = (X+0.5*Y)*100/n
#
#     return(p)
#
# print(get_p(data,16))