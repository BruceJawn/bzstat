#Global Varibles
GL_Arguments <- list();#dependent variables
GL_Responses <- list();#independent variables
GL_Estimators <- list();#

AppendFitted <- function(name, values, residuals = NULL)
  {
    GL_Estimators[[name]] <<- list();
    GL_Estimators[[name]]$Fitted <<- list();
    GL_Estimators[[name]]$Fitted$Values <<- values;
    #if(residuals == NULL)
    {GL_Estimators[[name]]$Fitted$Residuals <<- GL_Responses$Y - values;}#?GL_Responses$Y must be set first!
    #else
    #{GL_Estimators[[name]]$Fitted$Residuals <<- residuals;}
     GL_Estimators[[name]]$Fitted$MSE <<-
     sum((GL_Estimators[[name]]$Fitted$Residuals - mean(GL_Estimators[[name]]$Fitted$Residuals)) ^ 2)/length(GL_Estimators[[name]]$Fitted$Residuals);
  }

RecordTime <- function(name, time)
  {
    GL_Estimators[[name]]$Time <<- time;
  }

