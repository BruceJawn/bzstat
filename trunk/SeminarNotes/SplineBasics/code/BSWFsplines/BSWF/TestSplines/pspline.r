#######################
####pspline package####
#######################
library(pspline); #load the package containing the smooth.Pspline function
fit2 <- smooth.Pspline(GL_Arguments$X, GL_Responses$Y, method=3);
#Fit a Polynomial Smoothing Spline of Arbitrary Order
#smooth.Pspline(x, y, w=rep(1, length(x)), norder=2, df=norder + 2,
#spar=0, method=1)
#fit smoothing spline on noisy data using GCV score (method=3). use method=1
#with a user specified smoothing parameter (spar) if you want to try different
#degree of smoothing.
tempFitted <- fit2$y;
rm(fit2);
#######################
#######################
