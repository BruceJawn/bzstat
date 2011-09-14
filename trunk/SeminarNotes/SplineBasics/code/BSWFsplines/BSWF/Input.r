#Generate/Read Data
Input <- function(FileName=GL_Input_FileName)
  {
    print("======Input Begin... ======");
    source(FileName);#source(past("./Input", FileName, sep=""));
    print("======Input Finished!======");
  }
