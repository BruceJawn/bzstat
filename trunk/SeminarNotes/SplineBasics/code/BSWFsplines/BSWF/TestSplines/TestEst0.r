Estimators <- list();
#tempFitted
#tempResidual
pushEst <- function(name, fileName)
  {
    index <- length(Estimators)+1;
    Estimators[[index]] <<- list(); 
    Estimators[[index]][1] <<- name;
    Estimators[[index]][2] <<- fileName;
  }

pushEst("Local Polynomial", "./BSWF/TestSplines/loess.r");
pushEst("smooth.spline","./BSWF/TestSplines/smooth.spline.r");
pushEst("pspline", "./BSWF/TestSplines/pspline.r");
pushEst("SemiPar", "./BSWF/TestSplines/SemiPar.r");
pushEst("Polynomial Regression", "./BSWF/TestSplines/PolynomialRegression.r");
pushEst("LSSpline", "./BSWF/TestSplines/LSSplines.r");

pb <- txtProgressBar(min = 1, max =length(Estimators), style = 3)
for(i in 1:length(Estimators))
  {
    ctime <- system.time(source(Estimators[[i]][[2]]));
    AppendFitted(name=Estimators[[i]][[1]], values=tempFitted);
    RecordTime(name=Estimators[[i]][[1]], time=ctime);
    Sys.sleep(0.5);
    setTxtProgressBar(pb, i);
  }
close(pb);

rm(tempFitted);
