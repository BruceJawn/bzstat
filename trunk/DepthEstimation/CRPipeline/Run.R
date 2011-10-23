#dir <- "G:/SDLOpenGL/PaperEX";
#getwd();
#setwd(dir);
ProgramURL <- '"myprogram.exe"';
InputName <- "voxdata.vd";
OutputName <- "test";
eyeX <- 128;
eyeY <- 80;
eyeZ <- 120;
system(paste(ProgramURL, InputName, OutputName, eyeX, eyeY, eyeZ), wait = TRUE);

print("runed!");
ColorDataURL <- paste(OutputName,"_color.txt",sep="");
DepthDataURL <- paste(OutputName,"_depth.txt",sep="");

ColorData <- read.table(ColorDataURL);
DepthData <- read.table(DepthDataURL);

print(DepthData);
