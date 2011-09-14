BSWF_init <- function(ConfigPath = "./Config.r"){
#Import Required Pacakge and Source Files                                  
source("./Import.r");
Import(ConfigPath);
}

BSWF_run <- function(){
Input();#Generate/Read Data for Simulation

Estimate();#Estimate the Parameters

Output();#Output Graphics and Tables
}

BSWF_skeleton <- function(path = "./"){
  dir.create(path, showWarnings = TRUE, recursive = FALSE, mode = "0777")
  file.copy(from = "./skeleton/", to = path, overwrite = recursive, recursive = FALSE);
}


