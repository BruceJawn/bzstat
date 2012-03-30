#Global Varibles
GL_Arguments <- list();#dependent variables, not record/will change after one simulation step
GL_Responses <- list();#independent variables, not record/will change after one simulation step
GL_Estimators <- list();#estimators of parameters, record/sum to after one simulation step

AppendFitted <- function(name, values, real_values)
  {
    cat("\n");
    cat("Appending Fitted:",name,"...","\n");
                                        #name: differnt parameters to be estimated and/or different methods of estimation
    if(GL_CurSim_CNT == 1)
      {
                                        #for the first time, init the list of estimators
        GL_Estimators[[name]] <<- list();
        GL_Estimators[[name]]$Fitted <<- list();
        GL_Estimators[[name]]$Fitted$AllValues <<- list();#values;
        GL_Estimators[[name]]$Fitted$RealValues <<- real_values;
      }
    #else
      {
        GL_Estimators[[name]]$Fitted$AllValues[[GL_CurSim_CNT]] <<- values;
      }
    cat("Appending Finished!","\n");
  }

RecordTime <- function(name, time)
  {
    if(GL_CurSim_CNT == 1)
      {
        GL_Estimators[[name]]$Time <<- time;
      }
    else
      {
        GL_Estimators[[name]]$Time <<- GL_Estimators[[name]]$Time+time;
      }
  }

AverageFitted <- function()
  {
    cat("\n");
    writeLines("Averaging results...");
    for(i in 1:length(GL_Estimators))
      {
        GL_Estimators[[i]]$Fitted$Mean <<- GL_Estimators[[i]]$Fitted$AllValues[[1]];
        if(GL_Sim_CNT>=2)
        for(j in 2:GL_Sim_CNT)
          {
            GL_Estimators[[i]]$Fitted$Mean <<- GL_Estimators[[i]]$Fitted$Mean + GL_Estimators[[i]]$Fitted$AllValues[[j]];
          }
      
        GL_Estimators[[i]]$Fitted$Mean <<- GL_Estimators[[i]]$Fitted$Mean/GL_Sim_CNT;
        
        temp <- GL_Estimators[[i]]$Fitted$AllValues[[1]] - GL_Estimators[[i]]$Fitted$Mean;
        GL_Estimators[[i]]$Fitted$Var <<- temp*temp;
        if(GL_Sim_CNT>=2)
        for(j in 2:GL_Sim_CNT)
          {
            temp <- GL_Estimators[[i]]$Fitted$AllValues[[j]] - GL_Estimators[[i]]$Fitted$Mean;
            GL_Estimators[[i]]$Fitted$Var <<- GL_Estimators[[i]]$Fitted$Var + temp*temp;
          }
        GL_Estimators[[i]]$Fitted$Var <<- GL_Estimators[[i]]$Fitted$Var/GL_Sim_CNT;
        
        GL_Estimators[[i]]$Fitted$Residuals <<- GL_Estimators[[i]]$Fitted$RealValues - GL_Estimators[[i]]$Fitted$Mean;
        GL_Estimators[[i]]$Fitted$MSE <<-
        sum((GL_Estimators[[i]]$Fitted$Residuals - mean(GL_Estimators[[i]]$Fitted$Residuals)) ^ 2)/length(GL_Estimators[[i]]$Fitted$Residuals);
        
      }
     writeLines("Average Finished!");
    
  }
