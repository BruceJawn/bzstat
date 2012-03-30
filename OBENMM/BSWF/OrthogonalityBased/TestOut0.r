#postscript("result.ps", height=4, width=5, horizo=F)
#initialize graphic output 
#(PS file for print, you can use Ghostview or gv command to view it)
#alternatively, you can use motif() to view it on screen

#plot
#par(mfrow=c(2,length(GL_Estimators)/2));

#for(i in 1:length(GL_Estimators))
#  {
#    name <- Estimators[[i]][[1]];
#    plot(GL_Arguments$X, GL_Responses$Y, xlab="t", ylab="f(t)", cex=0.5, main=name,); #plot data point
#    lines(GL_Arguments$X, GL_Responses$TY, lty=2); #plot true function
#    lines(GL_Arguments$X, GL_Estimators[[name]]$Fitted$Values); #plot smooth spline fit
#  }

#graphics.off()
#output to PS file
#if you use motif(), you can shut down motif window by using dev.off()
#dev.print(device=postscript, "test.eps", onefile=FALSE, horizontal=FALSE) ;#

#table
library(xtable);
names <- rep(0,length(GL_Estimators));
mses <- rep(0,length(GL_Estimators));
times <- rep(0,length(GL_Estimators));
values <- rep(0,length(GL_Estimators));
vars <- rep(0,length(GL_Estimators));
real_values <- rep(0,length(GL_Estimators));
Residuals <- rep(0,length(GL_Estimators));
for(i in 1:length(GL_Estimators))
  {
    names[i] <- names(GL_Estimators)[i];
    mses[i] <- GL_Estimators[[i]]$Fitted$MSE;
    times[i] <- GL_Estimators[[i]]$Time[["elapsed"]];
    values[i] <- MToString(GL_Estimators[[i]]$Fitted$Mean);
    vars[i] <- MToString(GL_Estimators[[i]]$Fitted$Var);
    real_values[i] <-  MToString(GL_Estimators[[i]]$Fitted$RealValues);
    Residuals[i] <-  MToString(GL_Estimators[[i]]$Fitted$Residuals);
  }


resultTable <- data.frame(Name=names, Value_Mean=values, Value_Var=vars, Real_Value=real_values, Residual=Residuals, MSE=mses, Time=times);

Mytable <- xtable(resultTable, caption="result");
print(Mytable, file="testtable.html", type="html");
print(Mytable, file="testtable.tex", type="latex");
#######################
#######################
