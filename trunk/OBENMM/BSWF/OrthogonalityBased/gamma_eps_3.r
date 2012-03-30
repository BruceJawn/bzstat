c3 <- 0;
for(i in 1:n)
  {
    for(j in 1:l[i])
      {
        for(k in (q+1):l[i])
          {
            c3 <- c3+Q[[i]][j,k]^3;
          }#end of for k
      }#end of for j
  }#end of for i
c3 <- c3/n;

M <- 0;
for(i in 1:n)
  {
    for(j in (q+1):l[i])
      {
        M <- M+(t(Q[[i]][,j])%*%(y[[i]]-x[[i]]%*%beta))^3
      }
  }#end of for i
gmeps3 <- M/(n*c3);
gmeps3 <- as.numeric(gmeps3);#gmeps3 <- gmeps3[1][1];
tempFitted <- gmeps3;
