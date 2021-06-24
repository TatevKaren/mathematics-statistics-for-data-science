
def runOLS(Y,X):

        # OLS esyimation Y = Xb + e --> beta_hat = (X'X)^-1(X'Y)
        beta_hat = np.dot(np.linalg.inv(np.dot(np.transpose(X), X)), np.dot(np.transpose(X), Y))

        # OLS prediction
        Y_hat = np.dot(X,beta_hat)
        residuals = Y-Y_hat
        RSS = np.sum(np.square(residuals))
        sigma_squared_hat = RSS/(N-2)

        TSS = np.sum(np.square(Y-np.repeat(Y.mean(),len(Y))))

        MSE = sigma_squared_hat
        RMSE = np.sqrt(MSE)
        R_squared = (TSS-RSS)/TSS


        # Standard error of regression estimates is the square root of the varaince of the estimates
        var_beta_hat = np.linalg.inv(np.dot(np.transpose(X),X))*sigma_squared_hat
        SE = []
        t_stats = []
        p_values = []
        CI_s = []
        for i in range(len(beta)):

            #standard errors
            SE_i = np.sqrt(var_beta_hat[i,i])
            SE.append(np.round(SE_i,3))

            #t-statistics
            t_stat = np.round(beta_hat[i,0]/SE_i,3)
            t_stats.append(t_stat)

            #p-value of t-stat p = p[|t_stat| >= t-treshhold two sided] N-1 df
            p_value = t.sf(np.abs(t_stat),N-2) * 2
            p_values.append(np.round(p_value,3))

            #Confidence intervals = beta_hat -+ margin_of_error
            t_critical = t.ppf(q =1-0.05/2, df = N-2)
            margin_of_error = t_critical*SE_i
            CI = [np.round(beta_hat[i,0]-margin_of_error,3), np.round(beta_hat[i,0]+margin_of_error,3)]
            CI_s.append(CI)

        return(beta_hat, SE, t_stats, p_values,CI_s, MSE, RMSE, R_squared)

