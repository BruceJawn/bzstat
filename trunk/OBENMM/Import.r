#source() a bunch of files
sourceDir <- function(path, trace = TRUE, ...) {
  for (nm in list.files(path, pattern = "\\.[RrSsQq]$")) {
    if(trace) cat(nm,":")           
    source(file.path(path, nm), ...)
    if(trace) cat("\n")
  }
}
#Import Configuration Variables, Required Pacakge and Source Files
#called by BSWF_init in "BSWF.r"
Import <- function(ConfigPath){
  cat("\n");
  writeLines("======Import Begin... ======");
  source(ConfigPath);
  sourceDir("./BSWF/");
  sourceDir("./custom/");
  writeLines("======Import Finished!======");
  }
