################################
##generate data for simulation##
################################
                                        #ģ��������:
                                        #���س����Multivariate Normal and T Distribution
library(mvtnorm);
#set.seed(100); #set initial seed for random number generator

for(i in 1:n){
  #b_i q*1
  #����n�������Ԫ��̬�ֲ�����,��ֵ(0,0),Э����D 
  b[[i]] <- rmvnorm(n=1, mean=Eb_i, sigma=Db_i);
  dim(b[[i]]) <- c(q,1);

  #z_i: l_i*q
  for(j in 1:q)
    {
      z[[i]][,j] <- t(rnorm(n=l[i], mean=0, sd=1));
    }
  #e_i: l_i*1
  epsilon[[i]] <- rnorm(n=l[i], mean=0, sd=1);
  dim(epsilon[[i]]) <- c(l[i],1);
  
                                        #ml=10����׼��̬�ֲ�
  t[[i]] <- t(runif(n=l[i]));#t(rnorm(n=l[i], mean=0, sd=1));
  #t[[i]] <- 2*t[[i]]-1;
  t[[i]] <- sort(t[[i]]);#sorting
  dim(t[[i]]) <-  c(l[i],1);
  
                                        #��ʱf=cos
  ft[[i]] <- UnkownFunction(t[[i]]);
 
  y[[i]] <- ft[[i]]+z[[i]]%*%b[[i]]+epsilon[[i]];
}#end of for i

GL_Arguments$X <- t;
GL_Responses$Y <- y;
GL_Responses$TY <- ft;

                                        #Remove Temporary Variables
rm();

                                        #or you can read data from a file:
                                        #dat <- read.table("smooth_spline_example.dat", header=T);
                                        #attach(dat);
#######################
#######################
