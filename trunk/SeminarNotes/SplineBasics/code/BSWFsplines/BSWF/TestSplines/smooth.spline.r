#######################
#smooth.spline {stats}#
#######################
fit1 <- smooth.spline(GL_Arguments$X, GL_Responses$Y);
#Fits a cubic smoothing spline to the supplied data. 
#smooth.spline(x, y = NULL, w = NULL, df, spar = NULL,
#              cv = FALSE, all.knots = FALSE, nknots = NULL,
#              keep.data = TRUE, df.offset = 0, penalty = 1,
#              control.spar = list())
tempFitted <- fit1$y;
rm(fit1);
#######################
#######################
