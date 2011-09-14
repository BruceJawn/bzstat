#/**
# *Bruce Zhou
# *http://bzstat.wordpress.com
  
# *Copyright (c) <2011> <Bruce Zhou>
# *This software is released under the MIT License 
# *<http://www.opensource.org/licenses/mit-license.php>
# **/
################################
##generate data for simulation##
################################
set.seed(100); #set initial seed for random number generator

n <- 100;
x <- (1:n)/n;  #we will use 100 equally spaced design point from 0 to 1

true <- ((exp(1.2*x)+1.5*sin(7*x))-1)/3; #true function in this simulation

noise <- rnorm(n, 0, 0.15);
#generate n independent normal random number with 0 mean and variance 0.15

y <- true + noise; #y is observed values (true value + noise)

#or you can read data from a file:
#dat <- read.table("smooth_spline_example.dat", header=T);
#attach(dat);
#######################
#######################


#######################
#####loess {stats}##### 
#######################
d<-data.frame(response=y, obs=x);
re=loess(y ~ x, d, , , , FALSE,0.75, , 2,FALSE, FALSE, TRUE,"gaussian", , );
#Fit a polynomial surface determined by one or more numerical predictors, using local fitting. 

fy<-predict(re,x);
#points(x,fy);
fit0<-list(x=rep(0,n),y=rep(0,n));
fit0$x<-x;
fit0$y<-fy;
#######################
#######################

#######################
#smooth.spline {stats}#
#######################
fit1 <- smooth.spline(x, y);
#Fits a cubic smoothing spline to the supplied data. 
#smooth.spline(x, y = NULL, w = NULL, df, spar = NULL,
#              cv = FALSE, all.knots = FALSE, nknots = NULL,
#              keep.data = TRUE, df.offset = 0, penalty = 1,
#              control.spar = list())
#######################
#######################

#######################
####pspline package####
#######################
library(pspline); #load the package containing the smooth.Pspline function
fit2 <- smooth.Pspline(x, y,method=3);
#Fit a Polynomial Smoothing Spline of Arbitrary Order
#smooth.Pspline(x, y, w=rep(1, length(x)), norder=2, df=norder + 2,
#spar=0, method=1)
#fit smoothing spline on noisy data using GCV score (method=3). use method=1
#with a user specified smoothing parameter (spar) if you want to try different
#degree of smoothing.
#######################
#######################

#######################
##### lmeSplines ######
#######################
#Todo
#######################
#######################

#######################
####SemiPar package####
#######################
library(SemiPar);
fit<-spm(y~f(x));
#plot(fit);
fit3<-list(x=rep(0,n), y=rep(0,n));
fit3$x<-x;
fit3$y<-fit$fit$fitted;

#Fit a SemiParametric regression Model
#spm(form,random=NULL,group=NULL,family="gaussian",
#spar.method="REML",omit.missing=NULL)
#######################
#######################


#############################
####Polynomial Regression####
#############################
#Use the poly() function to fit a polynomial regression
#Returns or evaluates orthogonal polynomials of degree 1 to degree over the specified set of points x
#regression fit with power of 3:
polyfit <- lm(y ~ poly(x, 3));
#lm is used to fit linear models
fit4<-list(x=rep(0,n), y=rep(0,n));
fit4$x<-x;
fit4$y<-polyfit$fitted.values;
#############################
#############################

#################################################
####LS Spline/Piecewise Polynomial Regression####
#################################################
library(splines);
# Generate the B-spline basis matrix for a polynomial spline using bs(), basis function
# df: degrees of freedom; df = length(knots) + 3 + intercept = #knots + 4, since we make equal at knot points, first and second derivatives
# knots the internal breakpoints that define the spline. The default is NULL, 
# which results in a basis for ordinary polynomial regression. 
# degree: degree of the piecewise polynomial¡ªdefault is 3 for cubic splines. 
splinefit <- lm(y ~ bs(x, 3));
#lm is used to fit linear models
fit5<-list(x=rep(0,n), y=rep(0,n));
fit5$x<-x;
fit5$y<-splinefit$fitted.values;
#################################################
#################################################

#postscript("result.ps", height=4, width=5, horizo=F)
#initialize graphic output 
#(PS file for print, you can use Ghostview or gv command to view it)
#alternatively, you can use motif() to view it on screen

par(mfrow=c(2,3));

plot(x, y, xlab="x", ylab="y", cex=0.5); #plot data point
lines(x, true, lty=2); #plot true function
lines(fit0$x, fit0$y); #plot smooth spline fit

plot(x, y, xlab="x", ylab="y", cex=0.5); #plot data point
lines(x, true, lty=2); #plot true function
lines(fit1$x, fit1$y); #plot smooth spline fit

plot(x, y, xlab="x", ylab="y", cex=0.5); #plot data point
lines(x, true, lty=2); #plot true function
lines(fit2$x, fit2$y); #plot smooth spline fit

plot(x, y, xlab="x", ylab="y", cex=0.5); #plot data point
lines(x, true, lty=2); #plot true function
lines(fit3$x, fit3$y); #plot smooth spline fit

plot(x, y, xlab="x", ylab="y", cex=0.5); #plot data point
lines(x, true, lty=2); #plot true function
lines(fit4$x, fit4$y); #plot smooth spline fit

plot(x, y, xlab="x", ylab="y", cex=0.5); #plot data point
lines(x, true, lty=2); #plot true function
lines(fit5$x, fit5$y); #plot smooth spline fit

#graphics.off()
#output to PS file
#if you use motif(), you can shut down motif window by using dev.off()
#######################
#######################
