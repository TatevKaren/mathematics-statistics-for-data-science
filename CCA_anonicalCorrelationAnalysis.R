#--------------------------------------------------------------------------- 
#Canonical Correlation Analysis 
#--------------------------------------------------------------------------- 

#Arts and Health Care are in one group
X= data_log10[,c(3,7)]
Y= data_log10[,-c(3,7)]
cor(X)
cor(Y)

cor(X,Y)
cca.almanac = cc(X,Y)
cca.almanac$cor # 2 canonical Correlations
# there is a substantial correlation between these two groups
# strong relation between groups 0.728 so the first one is important cca.almanac$xcoef; cca.almanac$ycoef
#Health Care is negativelyt correlated with Climate and Economy and #positively with everything else
#Arts is negatively correlated with Climate and Economy and #postively with everything else 
plot(-cca.almanac$scores$xscores[,1],-cca.almanac$scores$yscores[,1],
type="n",xlab="eta1",ylab="phi1")
text(x = -cca.almanac$scores$xscores[,1], y = -cca.almanac$scores$yscores[,1],
     labels = row.names(placesrating), cex=.75)


#the graph verifies the correlation
#we can inyterpret \eta as index of Arts
#\phi1 cosits mainly of Housingcost,Educ,Transportation but also Economy and Crime 
plot(-cca.almanac$scores$xscores[,2],-cca.almanac$scores$yscores[,2],
type="n",xlab="eta2",ylab="phi2")
text(x = -cca.almanac$scores$xscores[,2], y = -cca.almanac$scores$yscores[,2],
     labels = row.names(placesrating), cex=.75)
# as we see from the cca correlations the graph proves that we might consider # second canonical correlation as less important
