library(splines);
# Generate the B-spline basis matrix for a polynomial spline using bs(), basis function
# df: degrees of freedom; df = length(knots) + 3 + intercept = #knots + 4, since we make equal at knot points, first and second derivatives
# knots the internal breakpoints that define the spline. The default is NULL, 
# which results in a basis for ordinary polynomial regression. 
# degree: degree of the piecewise polynomial¡ªdefault is 3 for cubic splines.
# return A matrix of dimension c(length(x), df)

for(i in 1:n)
  {
  knots <- quantile(x=t[[i]], probs=seq(0, 1, 1/(K+1)));
  knots <- knots[2:(length(knots)-1)];
  #x_i: l_i*(s+K+1)
  x[[i]] <- bs(x=t[[i]], knots=knots, degree=s, intercept=TRUE);#s=3
  }

SM<-array(data=0, dim=c(df,df));
SN<-array(data=0, dim=c(df,1));
for(i in 1:n)
  {  
    SM=SM+t(x[[i]])%*%Pz[[i]]%*%x[[i]];
    SN=SN+t(x[[i]])%*%Pz[[i]]%*%y[[i]];
  }#end of for i
                      
beta <- solve(SM)%*%SN; #Lapack routine dgesv: system is exactly singular£¿
tempFitted <- beta;

if(GL_CurSim_CNT == GL_Sim_CNT)
{
##
pdf("RegSSnQ_graph.pdf");
#need sort first
plot(t(Q2[[n]])%*%t[[n]], t(Q2[[n]])%*%ft[[n]], xlab="Q2*t", ylab="Q2*f(t)", main="Regression Spline Smoothing for the n-th Group", pch=14, col="blue", xlim=c(-2,2), ylim=c(-3,3));
points(t(Q2[[n]])%*%t[[n]], t(Q2[[n]])%*%y[[n]], pch=15, col="green");
points(t(Q2[[n]])%*%t[[n]], t(Q2[[n]])%*%x[[n]]%*%beta, pch=16, col="red");
legend("bottomleft", c("Real Value","Observed Value","Fitted Value"), pch=c(14,15,16), col=c("blue","green","red"));

#lines(t(Q2[[n]])%*%t[[n]], t(Q2[[n]])%*%ft[[n]], lty=1);
#lines(t(Q2[[n]])%*%t[[n]], t(Q2[[n]])%*%y[[n]], lty=2); #plot true function
#lty: The line type. 0=blank, 1=solid (default), 2=dashed, 3=dotted, 4=dotdash, 5=longdash, 6=twodash 
#lines(t(Q2[[n]])%*%t[[n]], t(Q2[[n]])%*%x[[n]]%*%beta, lty=3); #plot smooth spline fit
#legend(x=2, y=2, c("Real Value","Observed Value","Fitted Value"), lty=c(1,2,3));
dev.off();

pdf("RegSSn_graph.pdf");
#need sort first
plot(t[[n]], ft[[n]], xlab="t", ylab="f(t)", main="Regression Spline Smoothing for the n-th Group", pch=14, col="blue", xlim=c(min(t[[n]]),max(t[[n]])), ylim=c(min(y[[n]])-1,max(y[[n]])));
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
