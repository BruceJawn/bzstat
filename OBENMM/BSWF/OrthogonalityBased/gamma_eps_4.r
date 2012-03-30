c4 <- 0;
for(i in 1:n)
  {
    for(j in 1:l[i])
      {
        for(k in (q+1):l[i])
          {
            c4 <- c4+Q[[i]][j,k]^4;
          }#end of for k
      }#end of for j
  }#end of for i
c4 <- c4/n;

M <- 0;
for(i in 1:n)
  {
    for(j in (q+1):l[i])
      {
        M <- M+(t(Q[[i]][,j])%*%(y[[i]]-x[[i]]%*%beta))^4;
      }
  }#end of for i
gmeps4 <- M/(n*c4);
gmeps4 <- gmeps4[1][1]-3*(gmeps2)^2*(c2/c4-1);
tempFitted <- gmeps4;
