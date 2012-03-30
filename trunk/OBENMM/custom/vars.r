#global variables used as control varibles to specify the model

#number of groups
n <- 100;

#number of samples for each group
#l[i]: 第i组数据的个数 
l <- array(data=20, dim=c(n));#假设每组数据个数都为10 

#number of columns for z_i(l_i*q)/dimension of b(q*1) [z_ij或b的维数] 
q <- 2;

#number of columns for basis matrix x_i/dimnesion of noparametrical parameters beta(p*1)
p <- 3;##??

#z_i:=z[[i]] 随机效应b_i的设计矩阵z_i(l_i*q)的数据集(*n个)
#声明q=行*li=列*n=i数组
z <- list();
for(i in 1:n)
  {
    z[[i]] <- array(data=0, dim=c(l[i],q));
  }

#b_i:=b[[i]] 随机效应q*1
b <- list();
for(i in 1:n)
  {
    b[[i]] <- (rep(0,q));
    dim(b[[i]]) <- c(q,1);
  }

#epsilon_i:=epsilon[[i]] 随机误差的epsilon_i(l_i*1)数据集(*n个), E(epsilon_i,j)=0, D(epsilon_i,j)=1;  
epsilon <- list();
for(i in 1:n)
  {
    epsilon[[i]] <- rep(0,l[i]);
    dim(epsilon[[i]]) <- c(l[i],1);
  }

#t_i:=t[[i]] 输入变量向量t_i(l_i*1)数据集(*n个) 
t <- list();
for(i in 1:n)
  {
    t[[i]] <- rep(0,l[i]);
    dim(epsilon[[i]]) <- c(l[i],1);
  }

#s: degree(=order-1) of spline used, 1,...,t^s
s <- 3;
#K: number of knots, exclude of 0 and 1
K <- 8;
df <- s+K+1;

#x_i:=x[[i]] base matrix l_i*(s+K+1), 
x <- list();
for(i in 1:n)
  {
    x[[i]] <- array(data=0, dim=c(l[i],df));
  }

#ft_i:=ft[[i]] 真实函数值
ft <- list();
for(i in 1:n)
  {
    ft[[i]] <- rep(0,l[i]);
    dim(ft[[i]]) <- c(l[i],1);
  }

#y_i:=y[[i]] 输出变量向量y_i(l_i*1)数据集(*n个) 
y <- list();
for(i in 1:n)
  {
    y[[i]] <- rep(0,l[i]);
    dim(y[[i]]) <- c(l[i],1);
  }

#b_i 二元正态分布的均值
Eb_i <- c(0,0);
dim(Eb_i) <- c(q,1);

#b_i 二元正态分布的协方差D
Db_i <- matrix(data = c(1,0.5,0.5,1), nrow = q, ncol = q);

#要估计的未知函数为cos函数
UnkownFunction <- function(input)
  {
    return (((exp(1.2*input)+1.5*sin(7*input))-1)/3);#(1.5*sin(7*input));#(((exp(1.2*input)+1.5*sin(7*input))-1)/3);#cos(input);
  }

#function to test whether elements are even in different kinds or only has one kind
testEK <- function(vec)
  {
    kinds <- vec[1];
    for(i in 1:length(vec))
      {
        had <- FALSE;
        for(j in 1:length(kinds))
          {
            if(vec[i]==kinds[j])
              {
                had <- TRUE;
                break;
              }
          }
        if(!had)kinds[length(kinds)+1] <- vec[i];
      }
    
    cnts <- rep(0,length(kinds));
    for(i in 1:length(vec))
     {
       for(j in 1:length(kinds))
         {
           if(vec[i]==kinds[j])
             {
               cnts[j] <- cnts[j]+1;
             }
         }
        
     }
     returnVar <- list();
     returnVar$groups <- length(kinds);
     returnVar$balanced <- TRUE;
     for(i in 1:length(cnts))
      {
        if(cnts[i]%%2!=0)
          {
            returnVar$balanced <- FALSE;
          }
      }
     if(length(kinds)==1)
       returnVar$balanced <- TRUE;
    
    return (returnVar);
  }

#http://en.wikipedia.org/wiki/Normal_distribution#Moments
#\mathrm{E}\left[(X-\mu)^p\right] =
#  \begin{cases} 0 & \text{if }p\text{ is odd,} \\
#  \sigma^p\,(p-1)!! & \text{if }p\text{ is even.}
#  \end{cases}
# p=4 (p-1)!!=3*1=3

#real values of gamma_b_2
r_gamma_b_2 <- c(1,0,0,1);#c(1,0.5,0.5,1);
dim(r_gamma_b_2) <- c(q^2,1);

#real values of gamma_b_3
r_gamma_b_3 <- rep(0,q^3);
dim(r_gamma_b_3) <- c(q^3,1);

#real values of gamma_b_4
r_gamma_b_4 <- rep(0,q^4);
dim(r_gamma_b_4) <- c(q^4,1);
#group
#1 4
#2 2+2 1+3
#3 1+1+2
#4 1 1 1 1
for(index in 1:(q^4))
  {
    i <- vec_kronecker_n_Inv_index(q,4,index);
    test <- testEK(i)
    if(test$groups == 4)
      {
        r_gamma_b_4[index] <- 0;
      }
    if(test$groups == 3)
      {
        r_gamma_b_4[index] <- 0;
      }
    if(test$groups == 1)
      {
        r_gamma_b_4[index] <- 3;
      }
    if(test$groups == 2)
      {
        if(test$balanced)
          {
            r_gamma_b_4[index] <- 1;
          }
          else
            {
              r_gamma_b_4[index] <- 0;
            }
      }
  }

#real values of gamma_eps_2
r_gamma_eps_2 <- 1;
#real values of gamma_eps_3
r_gamma_eps_3 <- 0;
#real values of gamma_eps_4
r_gamma_eps_4 <- 3;
