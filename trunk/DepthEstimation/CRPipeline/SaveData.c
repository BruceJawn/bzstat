//save buffer to file
void SaveFile(const char* szFileName, unsigned char * st, unsigned int n)
{
  FILE *fp;
  unsigned int i;
  if((fp = fopen(szFileName,"wb"))==NULL)
    {
      printf("cant open the file");
      return;
    }
  for(i=0;i<n;i++)
    {
      if(fwrite(&st[i],sizeof(unsigned char),1,fp)!=1)
	printf("file write error\n");
    }
  fclose(fp);
}

void SaveData(char* FileName)
{
  int i;
  FILE *fp_color;
  FILE *fp_depth;

  char* ColorBinNM=(char*) malloc(strlen(FileName)+6);
  char* DepthBinNM=(char*) malloc(strlen(FileName)+6);
  char* ColorTxtNM=(char*) malloc(strlen(FileName)+10);
  char* DepthTxtNM=(char*) malloc(strlen(FileName)+10);

  strcpy(ColorBinNM,FileName);
  strcat(ColorBinNM,".color");
  strcpy(DepthBinNM,FileName);
  strcat(DepthBinNM,".depth");

  strcpy(ColorTxtNM,FileName);
  strcat(ColorTxtNM,"_color.txt");
  strcpy(DepthTxtNM,FileName);
  strcat(DepthTxtNM,"_depth.txt");

  SaveFile(ColorBinNM, (unsigned char *)ColorData, 256*256*sizeof(unsigned int));
  SaveFile(DepthBinNM, (unsigned char *)DepthData, 256*256*sizeof(unsigned int));

  fp_color=fopen(ColorTxtNM,"wb");
  fp_depth=fopen(DepthTxtNM,"wb");

  for(i=0;i<0xffff;i+=128)
    { 
      fprintf(fp_color,"%u\n",*(ColorData+i));
      fprintf(fp_depth,"%u\n",*(DepthData+i));
    }

  free(ColorBinNM);
  free(DepthBinNM);
  free(ColorTxtNM);
  free(DepthTxtNM);
  fclose(fp_color);
  fclose(fp_depth);
}
