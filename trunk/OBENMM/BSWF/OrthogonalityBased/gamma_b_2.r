gmb2 <- rep(0,q^2);
dim(gmb2) <- c(q^2,1);
for(i in 1:n)
  {
    tM <- kronecker_n(t(z[[i]])%*%z[[i]]);
    
    SMzij2 <- kronecker_n(z[[i]][1,]);
    for(j in 2:l[i])
      {
        SMzij2 <- SMzij2+kronecker_n(z[[i]][j,]);
      }#end of for j
    
    N <- kronecker_n(t(z[[i]])%*%(y[[i]]-x[[i]]%*%beta))-gmeps2*t(t(SMzij2));
    #(t(SMzij2)) not enough because z[[i]][j,] is a c(...)
    gmb2 <- gmb2+solve(tM)%*%N;
  }#end of for i
gmb2 <- gmb2/n;
tempFitted <- gmb2;
