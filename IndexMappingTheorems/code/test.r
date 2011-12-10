source("indexMapping.r"); 
#self kronecker product for n times
kronecker_n<-function(matrix,times=2)
{
 returnVar<-matrix;
 for(i in 1:(times-1))
 {
  returnVar<-kronecker(returnVar,matrix);
 }#end of for
 return (returnVar);
}#end of kronecker_n

#simple test function
#the c-th value of kronecker_n of a vector
vec_kronecker_n_value <- function(input,n,c)
  {
   #matrix to vector
   vec <- as.vector(input);
   l <- rep(length(vec),n);
   i <- kronecker_inv_index(c,l);
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
#vec_kronecker_n_value(test, 3, 6);
#kronecker_n(test, 3)[6];

kronecker_inv_index(4,rep(4,3));
kronecker_index(c(1,1,4),rep(4,3));
