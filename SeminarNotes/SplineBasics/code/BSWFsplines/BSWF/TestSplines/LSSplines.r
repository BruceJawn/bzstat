#################################################
####LS Spline/Piecewise Polynomial Regression####
#################################################
library(splines);
# Generate the B-spline basis matrix for a polynomial spline using bs(), basis function
# df: degrees of freedom; df = length(knots) + 3 + intercept = #knots + 4, since we make equal at knot points, first and second derivatives
# knots the internal breakpoints that define the spline. The default is NULL, 
# which results in a basis for ordinary polynomial regression. 
# degree: degree of the piecewise polynomial¡ªdefault is 3 for cubic splines. 
splinefit <- lm(GL_Responses$Y ~ bs(GL_Arguments$X, 3));
#lm is used to fit linear models

tempFitted <- splinefit$fitted.values;
rm(splinefit);
#################################################
#################################################
