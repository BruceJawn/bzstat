gmb3 <- rep(0,q^3);
dim(gmb3) <- c(q^3,1);
for(i in 1:n)
  {
    tM <- kronecker_n(t(z[[i]])%*%z[[i]],3);
    
    SMzij3 <- kronecker_n(z[[i]][1,],3);
    for(j in 2:l[i])
      {
        SMzij3 <- SMzij3+kronecker_n(z[[i]][j,],3);
      }#end of for j
    
    N <- kronecker_n(t(z[[i]])%*%(y[[i]]-x[[i]]%*%beta),3)-gmeps3*t(t(SMzij3));#(t(SMzij3)) not enough???
    gmb3 <- gmb3+solve(tM)%*%N;
  }#end of for i
gmb3 <- gmb3/n;
tempFitted <- gmb3;
