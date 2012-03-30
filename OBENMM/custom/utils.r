#util functions for the simulation

#n fold kronecker product function
#matrix:
#times:
##return: n fold kronecker product
kronecker_n<-function(matrix, times=2)
{
 returnVar <- matrix;
 for(i in 1:(times-1))
 {
  returnVar <- kronecker(returnVar,matrix);
 }#end of for
 return (returnVar);
}#end of kronecker_n

#convert a matrix to a string representation
#input_matrix
#rows: seperator for rows
#cols: seperator for columns
#return:
MToString<-function(input_matrix, rows=",", cols=";")
  {
    matrix <-  matrix(input_matrix);
    returnVar <- "";
    for(i in 1:length(matrix[,1]))
    {
        returnVar <- paste(returnVar, matrix[i,1]);
        if(length(matrix[1,])>1)
        for(j in 2:length(matrix[1,]))
        {
        returnVar <- paste(returnVar,rows,matrix[i,j]);
        }
        returnVar <- paste(returnVar,cols);
    }#end of for
    return (returnVar);
  }

#the inverse index mapping function for kronecker_n of a vector of length l
#l: length of the vector
#n: times/fold of the kronecker product 
#c: index in the kronecker product
##i: indices in factor vectors
vec_kronecker_n_Inv_index <- function(l,n,c)
  {
    i <- rep(0,n);
    i[n] <- c%%l;
    if(i[n]==0) i[n] <- l;
    if(n-1>1)
    for(j in (n-1):1)
      { 
        A <- 0;
        if(j+1<n)
        for(v in (j+1):(n-1))
          {
            A <- A+(i[v]-1)*l^(n-v);
          }
        
        B <- l^(n-j);
        
        if(j>1)
        {
          i[j] <- ((c-i[n]-A)/B)%%l+1;
        }
        else
        {
          i[j] <- ((c-i[n]-A)/B)+1;
        }
        
        if(i[j]==0) i[j] <- l;
      }
    return (i);
  }

#simple test function
#the c-th value of kronecker_n of a vector
vec_kronecker_n_value <- function(input,n,c)
  {
   #matrix to vector
   vec <- as.vector(input);
   l <- length(vec);
   i <- vec_kronecker_n_Inv_index(l,n,c);
   returnVar <- 1;
   for(j in 1:n)
     {
       returnVar <- returnVar*vec[i[j]];
     }
   #returnVar == kronecker_n(vec,n)[c]
   return (returnVar);
  }
#test:
#test<-c(1,2,3,4,5,6);
#vec_kronecker_n_value(test, 3, 6)
#kronecker_n(test , 3)[6]
