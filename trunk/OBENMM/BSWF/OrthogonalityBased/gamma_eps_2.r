c2 <- 0;
for(i in 1:n)
  {
    for(j in 1:l[i])
      {
        for(k in (q+1):l[i])
          {
            c2<-c2+Q[[i]][j,k]^2;#c2<-c2+Q[i,j,k]^2;
          }#end of for k
      }#end of for j
  }#end of for i
c2 <- c2/n;

M <- 0;
for(i in 1:n)
  {
    M<-M+t(y[[i]]-x[[i]]%*%beta)%*%Pz[[i]]%*%(y[[i]]-x[[i]]%*%beta);
  }#end of for i
gmeps2 <- M/(n*c2);
gmeps2 <- as.numeric(gmeps2);#gmeps2 <- gmeps2[1][1];
tempFitted <- gmeps2;
