#��z[i]��QR�ֽ�
#z_i: l_i*q
#Q_i: l_i*l_i
#Q_i1: l_i*q
#Q_i2: l_i*(l_i-q)
#R_i: l_i*q
#Pz: l_i*l_i
Q <- list();
R <- list();
Q1 <- list();
Q2 <- list();
Pz <- list();
for(i in 1:n)
  {
    qrstr <- qr(z[[i]]); 
    Q[[i]]<-qr.Q(qrstr,TRUE);
    R[[i]]<-qr.R(qrstr,TRUE);
    #Q1ΪQ��ǰq=���� 
    Q1[[i]]<-Q[[i]][,1:q];
    #Q2ΪQ�ĺ�l-q=���� 
    Q2[[i]]<-Q[[i]][,(q+1):l[i]];
    Pz[[i]]<-Q2[[i]]%*%t(Q2[[i]]);
  }#end of for i
