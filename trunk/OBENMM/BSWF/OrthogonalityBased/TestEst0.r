#temporary list of estimators, values will be record using global var "GL_Estimators"
Estimators <- list();
#tempFitted#variable used for record fitted parameter and pass it to AppendFitted
#tempResidual
pushEst <- function(name, fileName, r_values)
  {
    index <- length(Estimators)+1;
    Estimators[[index]] <<- list(); 
    Estimators[[index]][[1]] <<- name;
    Estimators[[index]][[2]] <<- fileName;
    Estimators[[index]][[3]] <<- r_values;
  }
source("./BSWF/OrthogonalityBased/z_QR.r");#QR decomposition of z
pushEst("beta","./BSWF/OrthogonalityBased/spline_beta.r",rep(0,df));#Estimation of beta
#pushEst("beta","./BSWF/OrthogonalityBased/p_spline_beta.r",rep(0,df));#Estimation of beta
pushEst("gamma_eps_2", "./BSWF/OrthogonalityBased/gamma_eps_2.r",r_gamma_eps_2);#Estimation of gamma_eps_2
pushEst("gamma_eps_3", "./BSWF/OrthogonalityBased/gamma_eps_3.r",r_gamma_eps_3);#Estimation of gamma_eps_3
pushEst("gamma_eps_4", "./BSWF/OrthogonalityBased/gamma_eps_4.r",r_gamma_eps_4);#Estimation of gamma_eps_4
pushEst("gamma_b_2", "./BSWF/OrthogonalityBased/gamma_b_2.r",r_gamma_b_2);#Estimation of gamma_b_2
pushEst("gamma_b_3", "./BSWF/OrthogonalityBased/gamma_b_3.r",r_gamma_b_3);#Estimation of gamma_b_3
#pushEst("gamma_b_4", "./BSWF/OrthogonalityBased/gamma_b_4.r",r_gamma_b_4);#Estimation of gamma_b_4

#pb <- txtProgressBar(min = 1, max =length(Estimators), style = 3);
for(ind in 1:length(Estimators))
  {
    cat("\n");#writeLines("\n");
    cat("Executing",Estimators[[ind]][[1]],":",Estimators[[ind]][[2]],"\n");#print
    ctime <- system.time(source(Estimators[[ind]][[2]]));#run step get value "tempFitted"
    AppendFitted(name=Estimators[[ind]][[1]], values=tempFitted, real_values=Estimators[[ind]][[3]]);#record fitted  in "Global.r" using global var "GL_Estimators"
    RecordTime(name=Estimators[[ind]][[1]], time=ctime);#record time in "Global.r"
    #Sys.sleep(0.5);
    #setTxtProgressBar(pb, i);
  }
#close(pb);

rm(tempFitted);
