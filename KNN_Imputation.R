#-----------------------------------------------------------------------------------------------------------
# Missing Values imputation, apply KNN one by one to avoid death kernel
#-----------------------------------------------------------------------------------------------------------
missingdat = data.frame(Frequency_s, Recency_s, Monetary_s, Age, Allow_analysis, Opt_in_com)
colnames(missingdat) = c("Frequency","Recency","Monetary","Age"," Allow_analysis", "Opt_in_com")
#the plot of missing variables
aggr(missingdat,numbers = TRUE,col = c("gray88","darkorange"),bars = TRUE, sortVars=TRUE, labels=names(missingdat), cex.axis=.65, gap=3, ylab=c("Histogram of missing data","Pattern"))
#partitioning data to 6 small parts otherwise kNN function in GCP can't handle it and leads to kernel death in case applied on whole data
n = nrow(missingdat)
n1 = floor(n/11)
n2 = 2*n1
n3 = 3*n1
n4 = 4*n1
n5 = 5*n1
n6 = 6*n1
n7 = 7*n1
n8 = 8*n1
n9 = 9*n1
n10 = 10*n1
n11 = n

#taking only the parts of the imputed data the remaing parts of KNN object conssits of the object with TRUE/FALSE logicals indicating value imputed or not
#KNN imputataions, running one by one
KNN_1 = kNN(data = missingdat[1:n1,])
KNN_2 = kNN(data = missingdat[n1+1:n2,])
KNN_3 = kNN(data = missingdat[n2+1:n3,])
KNN_4 = kNN(data = missingdat[n3+1:n4,])
KNN_5 = kNN(data = missingdat[n4+1:n5,])
KNN_6 = kNN(data = missingdat[n5+1:n6,])
KNN_7 = kNN(data = missingdat[n6+1:n7,])
KNN_8 = kNN(data = missingdat[n7+1:n8,])
KNN_9 = kNN(data = missingdat[n8+1:n9,])
KNN_10 = kNN(data = missingdat[n9+1:n10,])
KNN_11 = kNN(data = missingdat[n10+1:n11,])
imputed1 = KNN_1[,1:6]
imputed2 = KNN_2[,1:6]
imputed3 = KNN_3[,1:6]
imputed4 = KNN_4[,1:6]
imputed5 = KNN_5[,1:6]
imputed6 = KNN_6[,1:6]
imputed7 = KNN_7[,1:6]
imputed8 = KNN_8[,1:6]
imputed9 = KNN_9[,1:6]
imputed10 = KNN_10[,1:6]
imputed11 = KNN_11[,1:6]
#updating new imputed Age, Allow_analysis, Opt_in_com variables other three varaibles had no missing values
Imputed_data = rbind(imputed1,imputed2, imputed3, imputed4, imputed5, imputed6, imputed7, imputed8 ,imputed9, imputed10, imputed11)
Age = Imputed_data[,4]
Allow_analysis = Imputed_data[,5]
Opt_in_com = Imputed_data[,6]
