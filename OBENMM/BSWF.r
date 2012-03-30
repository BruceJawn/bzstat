#Import Configuration Variables, Required Pacakge and Source Files
#called in "Main.r"
BSWF_init <- function(ConfigPath = "./Config.r"){                                 source("./Import.r");
  Import(ConfigPath);
}

#run the simulation
#called in "Main.r"
BSWF_run <- function(){
#create a text based progress bar
pb <- txtProgressBar(min = 0, max = GL_Sim_CNT, style = 3);

  for(i_CSC in 1:GL_Sim_CNT)
    {
      GL_CurSim_CNT <<- i_CSC;
      
      Input();#Generate/Read Data for Simulation

      Estimate();#Estimate the Parameters

      Sys.sleep(0.5);
      setTxtProgressBar(pb, GL_CurSim_CNT);
    }
  close(pb);

  AverageFitted();

  Output();#Output Graphics and Tables
}

BSWF_skeleton <- function(path = "./"){
  dir.create(path, showWarnings = TRUE, recursive = FALSE, mode = "0777")
  file.copy(from = "./skeleton/", to = path, overwrite = recursive, recursive = FALSE);
}


