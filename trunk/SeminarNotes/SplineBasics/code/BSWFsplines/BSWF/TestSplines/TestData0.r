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

GL_Arguments$X <- x;
GL_Responses$Y <- y;
GL_Responses$TY <- true;

#Remove Temporary Variables
rm(x,y,n,true,noise);

#or you can read data from a file:
#dat <- read.table("smooth_spline_example.dat", header=T);
#attach(dat);
#######################
#######################
