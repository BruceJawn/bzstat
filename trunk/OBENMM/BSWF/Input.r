#Generate/Read Data
Input <- function(FileName=GL_Input_FileName)
  {
    cat("\n");
    writeLines("======Input Begin... ======");
    source(FileName);#source(past("./Input", FileName, sep=""));
    writeLines("======Input Finished!======");
  }
