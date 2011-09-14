## If you want to source() a bunch of files, something like
## the following may be useful:
sourceDir <- function(path, trace = TRUE, ...) {
  for (nm in list.files(path, pattern = "\\.[RrSsQq]$")) {
    if(trace) cat(nm,":")           
    source(file.path(path, nm), ...)
    if(trace) cat("\n")
  }
}
Import <- function(ConfigPath){
  print("======Import Begin... ======");
  source(ConfigPath);
  sourceDir("./BSWF/");
  print("======Import Finished!======");}
