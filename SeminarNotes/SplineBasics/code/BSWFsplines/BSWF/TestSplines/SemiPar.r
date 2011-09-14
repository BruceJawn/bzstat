#######################
####SemiPar package####
#######################
library(SemiPar);
fit<-spm(GL_Responses$Y~f(GL_Arguments$X));
#plot(fit);

tempFitted <- fit$fit$fitted;
rm(fit);
#Fit a SemiParametric regression Model
#spm(form,random=NULL,group=NULL,family="gaussian",
#spar.method="REML",omit.missing=NULL)
#######################
#######################
