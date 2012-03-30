library(amer);

lambda <- 0.5;

#knots <- quantile(x=t[[i]], probs=seq(0, 1, 1/(K+1)));

D <- matrix(0, df, df);#diag(c(rep(0,s+1),rep(1,K)));
for(i in (s+2):(df))
  {
    D[i, i] <- 1;
  }


for(i in 1:n)
  {
  tpb <- tp(x=t[[i]], degree=s, k=K+s);
  #intercept?
  x[[i]][,1] <- rep(1,l[i]);
  x[[i]][,2:(s+1)] <- tpb$X;
  x[[i]][,(s+2):(df)] <- tpb$Z;
  }
                                      
SM<-array(data=0, dim=c(df,df));
SN<-array(data=0, dim=c(df,1));
for(i in 1:n)
  {
    SM=SM+t(x[[i]])%*%(Pz[[i]])%*%x[[i]];
    SN=SN+t(x[[i]])%*%Pz[[i]]%*%y[[i]];
  }#end of for i
SM=SM+n*lambda*D;

beta <- solve(SM)%*%SN; #Lapack routine dgesv: system is exactly singular£¿
tempFitted <- beta;

if(GL_CurSim_CNT == GL_Sim_CNT)
{
##
pdf("PSSnQ_graph.pdf");
#need sort first
plot(t(Q2[[n]])%*%t[[n]], t(Q2[[n]])%*%ft[[n]], xlab="Q2*t", ylab="Q2*f(t)", main="Penalized Spline Smoothing for the n-th Group", pch=14, col="blue", xlim=c(-2,2), ylim=c(-3,3));
points(t(Q2[[n]])%*%t[[n]], t(Q2[[n]])%*%y[[n]], pch=15, col="green");
points(t(Q2[[n]])%*%t[[n]], t(Q2[[n]])%*%x[[n]]%*%beta, pch=16, col="red");
legend("bottomleft", c("Real Value","Observed Value","Fitted Value"), pch=c(14,15,16), col=c("blue","green","red"));

#lines(t(Q2[[n]])%*%t[[n]], t(Q2[[n]])%*%ft[[n]], lty=1);
#lines(t(Q2[[n]])%*%t[[n]], t(Q2[[n]])%*%y[[n]], lty=2); #plot true function
#lty: The line type. 0=blank, 1=solid (default), 2=dashed, 3=dotted, 4=dotdash, 5=longdash, 6=twodash 
#lines(t(Q2[[n]])%*%t[[n]], t(Q2[[n]])%*%x[[n]]%*%beta, lty=3); #plot smooth spline fit
#legend(x=2, y=2, c("Real Value","Observed Value","Fitted Value"), lty=c(1,2,3));
dev.off();

pdf("PSSn_graph.pdf");
#need sort first
plot(t[[n]], ft[[n]], xlab="t", ylab="f(t)", main="Penalized Spline Smoothing for the n-th Group", pch=14, col="blue", xlim=c(min(t[[n]]),max(t[[n]])), ylim=c(min(y[[n]])-1,max(y[[n]])));
points(t[[n]], y[[n]], pch=15, col="green");
points(t[[n]], x[[n]]%*%beta, pch=16, col="red");
legend("bottomleft", c("Real Value","Observed Value","Fitted Value"), pch=c(14,15,16), col=c("blue","green","red"));

lines(t[[n]],ft[[n]], lwd=1.5, lty=1);
lines(t[[n]], y[[n]], lwd=1.5, lty=2); #plot true function
#lty: The line type. 0=blank, 1=solid (default), 2=dashed, 3=dotted, 4=dotdash, 5=longdash, 6=twodash 
lines(t[[n]], x[[n]]%*%beta, lwd=1.5, lty=6); #plot smooth spline fit
legend("bottomright", c("Real Curve","Observed Curve","Fitted Curve"), lty=c(1,2,6));
dev.off();
##
}
