#postscript("result.ps", height=4, width=5, horizo=F)
#initialize graphic output 
#(PS file for print, you can use Ghostview or gv command to view it)
#alternatively, you can use motif() to view it on screen

par(mfrow=c(2,length(Estimators)/2));

for(i in 1:length(Estimators))
  {
    name <- Estimators[[i]][[1]];
    plot(GL_Arguments$X, GL_Responses$Y, xlab="t", ylab="f(t)", cex=0.5, main=name,); #plot data point
    lines(GL_Arguments$X, GL_Responses$TY, lty=2); #plot true function
    lines(GL_Arguments$X, GL_Estimators[[name]]$Fitted$Values); #plot smooth spline fit
  }

#graphics.off()
#output to PS file
#if you use motif(), you can shut down motif window by using dev.off()
dev.print(device=postscript, "test.eps", onefile=FALSE, horizontal=FALSE) ;#

library(xtable);
names <- rep(0,length(Estimators));
mses <- rep(0,length(Estimators));
times <- rep(0,length(Estimators));
for(i in 1:length(Estimators))
  {
    name <- Estimators[[i]][[1]];
    names[i] <- name;
    mses[i] <- GL_Estimators[[name]]$Fitted$MSE;
    times <- GL_Estimators[[name]]$Time[["elapsed"]];
  }


resultTable <- data.frame(name=names, mse=mses, time=times);

Mytable <- xtable(resultTable, caption="result");
print(Mytable, file="testtable.html", type="html");
#######################
#######################
