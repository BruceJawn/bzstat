SDL_Surface* ColorCanvas;
SDL_Surface* DepthCanvas;

unsigned int* ColorData;
unsigned int* DepthData;

void putpixel(SDL_Surface *surface, int x, int y, Uint32 pixel)
{
  int bpp = surface->format->BytesPerPixel;
  // Here p is the address to the pixel we want to set
  Uint8 *p = (Uint8 *)surface->pixels + y * surface->pitch + x * bpp;

  // Print pixel
  switch(bpp)
    {
    case 1:
      *p = pixel;
      break;
    case 2:
      *(Uint16 *)p = pixel;
      break;
    case 3:
      if(SDL_BYTEORDER == SDL_BIG_ENDIAN)
	{
	  p[0] = (pixel >> 16) & 0xff;
	  p[1] = (pixel >> 8) & 0xff;
	  p[2] = pixel & 0xff;
	} else {
	p[0] = pixel & 0xff;
	p[1] = (pixel >> 8) & 0xff;
	p[2] = (pixel >> 16) & 0xff;
      }
      break;
    case 4:
      *(Uint32 *)p = pixel;
      break;
    }
}

void RenderData(int teyeX, int teyeY, int teyeZ)
{
  float rayX,rayY,rayZ,rayLen;
  unsigned int color;
  //good 128 80 120
  int eyeX =teyeX;
  int eyeY =teyeY;
  int eyeZ =teyeZ;
  int xx=0;
  int yy=0;
  int zz=0;

  unsigned int crayX,crayY,crayZ;
  ColorCanvas = SDL_CreateRGBSurface(SDL_HWSURFACE, 256, 256, 32, 0xff0000, 0xff00, 0xff, 0xff000000);
  DepthCanvas = SDL_CreateRGBSurface(SDL_HWSURFACE, 256, 256, 32, 0xff0000, 0xff00, 0xff, 0xff000000);

  ColorData = (unsigned int*) malloc(sizeof(unsigned int)*256*256);
  DepthData = (unsigned int*) malloc(sizeof(unsigned int)*256*256);

  for (xx=0; xx<256; xx++)
    for (yy=0; yy<256; yy++) {
      rayX=xx-eyeX;
      rayY=(256-yy)-eyeY;
      rayZ=- eyeZ;

      rayLen=sqrt(rayX*rayX+rayY*rayY+rayZ*rayZ);
      rayX/=rayLen;
      rayY/=rayLen;
      rayZ/=rayLen;
      color=0xffffffff;

      for (zz=0; zz<600; zz++) {
	crayX=rayX*zz+eyeX;
	crayY=rayY*zz+eyeY;
	crayZ=rayZ*zz+eyeZ;

	if ((crayX>256)||(crayY>128)||(crayZ>256)) {
	  break;
	}
					
	if (VoxelData[crayY<<16|crayZ<<8|crayX]>0) {
	  color=0xff<<24|VoxelData[crayY<<16|crayZ<<8|crayX];
	  break;
	}

      }
      putpixel(ColorCanvas,xx,yy,color);
      ColorData[yy<<8|xx] = color;
      putpixel(DepthCanvas,xx,yy,0xff<<24|zz<<16|zz<<8|zz);
      DepthData[yy<<8|xx] = zz;
    }

  apply_surface( 32, 100, ColorCanvas, screen, NULL );
  //Free the message
  SDL_FreeSurface( ColorCanvas );
  apply_surface( 352, 100, DepthCanvas, screen, NULL );
  //Free the message
  SDL_FreeSurface( DepthCanvas );
}
