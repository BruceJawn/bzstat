#######################
#####loess {stats}##### 
#######################
d <- data.frame(response=GL_Responses$Y,obs=GL_Arguments$X);
re=loess(GL_Responses$Y ~ GL_Arguments$X, d, , , , FALSE,0.75, , 2,FALSE, FALSE, TRUE,"gaussian", , );
#Fit a polynomial surface determined by one or more numerical predictors, using local fitting. 

fy <- predict(re,GL_Arguments$X);
#points(x,fy);

tempFitted <- fy;
rm(d, re, fy);
#######################
#######################
