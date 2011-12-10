#This software is released under the MIT License
#<http://www.opensource.org/licenses/mit-license.php>
#*Copyright (c) <2011> <Bu Zhou>

#simple function to calculate product of the elements in a vector l
mul <- function(l)
  {
    len <- length(l);
    returnVar <- 1;
    for(i in 1:len)
      {
        returnVar <- returnVar*l[i];
      }
    return (returnVar);
  }#end of mul

#the modified module function
mmod <- function(p,q)
  {
    returnVar <- p%%q;
    if(returnVar==0)returnVar=p;
    return (returnVar);
  }#end of mmod

#The Index Mapping Function
#i: the row/column indexes of the factor matrices
#l: the length vector of the factor matrices
#return: the row/column index of kronecker product matrix
kronecker_index <- function(i,l)
  {
    returnVar <- 0;
    len <- length(i);
    for(j in 1:(len-1))
      {
        returnVar <- returnVar + (i[j]-1)*mul(l[(j+1):len]);
      }
    returnVar <- returnVar+i[len];
    return (returnVar);
  }#end of kronecker_index

#The Inverse Index Mapping Function
#c: the row/column index of kronecker product matrix
#l: the length vector of the factor matrices
#return: the row/column indexes of the factor matrices
kronecker_inv_index <- function(c,l)
  {
    n <- length(l);
    i <- rep(0,n);
    i[n] <- mmod(c,l[n]);
    
    if(n-1>0)
    for(j in (n-1):1)
      { 
        A <- 0;
        if(j+1<n)
        for(v in (j+1):(n-1))
          {
            A <- A+(i[v]-1)*mul(l[(v+1):n]);
          }
        
        B <- mul(l[(j+1):n]);
       
        if(j>1)
        {
          i[j] <- mmod((c-i[n]-A)/B,l[j])+1;
        }
        else
        {
          i[j] <- ((c-i[n]-A)/B)+1;
        }

      }#end of if&for
    return (i);
  }#end of kronecker_inv_index
