#############################
####Polynomial Regression####
#############################
#Use the poly() function to fit a polynomial regression
#Returns or evaluates orthogonal polynomials of degree 1 to degree over the specified set of points x
#regression fit with power of 3:
polyfit <- lm(GL_Responses$Y ~ poly(GL_Arguments$X, 3));
#lm is used to fit linear models

tempFitted <- polyfit$fitted.values;
rm(polyfit);
#############################
#############################
