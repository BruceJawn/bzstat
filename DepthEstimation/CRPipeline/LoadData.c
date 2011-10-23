unsigned int* VoxelData;

//return loaded buffer and record buffer length to filelength
unsigned char* LoadFile(/*const*/ char* szFileName)
{
  FILE * file;
  long fileSize;
  unsigned char* st;

  //printf("%s\n",szFileName);
  if( (file = fopen(szFileName,"rb") )  ==   NULL)
    {
      printf("%s can't be opened", szFileName);
      exit(1);
    }
  
  fseek(file, 0, SEEK_END);
 
  fileSize = ftell(file);
  rewind(file);
  
  st = (unsigned char*) malloc(sizeof(unsigned char)*fileSize);
  fread(st, 1, fileSize, file);
  fclose (file);
  return st;
}

void LoadData(char* FileName)
{

  VoxelData = (unsigned int*)LoadFile(FileName);
}
