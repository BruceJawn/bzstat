gmb4 <- rep(0,q^4);
dim(gmb4) <- c(q^4,1);
for(i in 1:n)
  {
    tM <- kronecker_n(t(z[[i]])%*%z[[i]],4);
    
    SMzij4 <- kronecker_n(z[[i]][1,],4);
    for(j in 2:l[i])
      {
        SMzij4 <- SMzij4+kronecker_n(z[[i]][j,],4);
      }#end of for j
    
    N <- kronecker_n(t(z[[i]])%*%(y[[i]]-x[[i]]%*%beta),4)-gmeps4*t(t(SMzij4));#(t(SMzij4)) not enough??? ignore the compicated part.
    #N <-...!!! 
    gmb4 <- gmb4+solve(tM)%*%N;
  }#end of for i
gmb4 <- gmb4/n;
tempFitted <- gmb4;
