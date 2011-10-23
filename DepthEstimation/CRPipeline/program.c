/*
 *A simple proof-of-concept R & C implementation of the pipeline for depth estimation.
 *Special thanks to Lazy Foo' SDL tutorial.
 *
 *Copyright (c) <2011> <Bruce Zhou>
 *This software is released under the MIT License
 *<http://www.opensource.org/licenses/mit-license.php>
 */

//The headers
#include <math.h>
#include "SDL/SDL.h"
#include "SDL/SDL_image.h"
#include "SDL/SDL_ttf.h"
#include "SDL/SDL_mixer.h"

//Screen attributes
const int SCREEN_WIDTH = 640;
const int SCREEN_HEIGHT = 480;
const int SCREEN_BPP = 32;

//The surfaces
SDL_Surface *background = NULL;
SDL_Surface *message = NULL;
SDL_Surface *screen = NULL;

//The event structure
SDL_Event event;

//The font
TTF_Font *font = NULL;

//The color of the font
SDL_Color textColor = { 0, 0, 0 };
SDL_Color texbgColor = { 255, 255, 255 };

//The sound effects that will be used
Mix_Chunk *scratch = NULL;

SDL_Surface *load_image( const char* filename )
{
  //The image that's loaded
  SDL_Surface* loadedImage = NULL;

  //The optimized surface that will be used
  SDL_Surface* optimizedImage = NULL;

  //Load the image
  loadedImage = IMG_Load( filename );

  //If the image loaded
  if( loadedImage != NULL )
    {
      //Create an optimized surface
      optimizedImage = SDL_DisplayFormat( loadedImage );

      //Free the old surface
      SDL_FreeSurface( loadedImage );

      //If the surface was optimized
      if( optimizedImage != NULL )
        {
	  //Color key surface
	  SDL_SetColorKey( optimizedImage, SDL_SRCCOLORKEY, SDL_MapRGB( optimizedImage->format, 0, 0xFF, 0xFF ) );
        }
    }

  //Return the optimized surface
  return optimizedImage;
}

void apply_surface( int x, int y, SDL_Surface* source, SDL_Surface* destination, SDL_Rect* clip)
{
  //Holds offsets
  SDL_Rect offset;

  //Get offsets
  offset.x = x;
  offset.y = y;

  //Blit
  SDL_BlitSurface( source, clip, destination, &offset );
}

int init()
{
  //Initialize all SDL subsystems
  if( SDL_Init( SDL_INIT_EVERYTHING ) == -1 )
    {
      return 1;
    }

  //Set up the screen
  screen = SDL_SetVideoMode( SCREEN_WIDTH, SCREEN_HEIGHT, SCREEN_BPP, SDL_SWSURFACE );

  //If there was an error in setting up the screen
  if( screen == NULL )
    {
      return 1;
    }

  //Initialize SDL_ttf
  if( TTF_Init() == -1 )
    {
      return 1;
    }

  //Initialize SDL_mixer
  if( Mix_OpenAudio( 22050, MIX_DEFAULT_FORMAT, 2, 4096 ) == -1 )
    {
      return 1;
    }

  //Set the window caption
  SDL_WM_SetCaption( "Ray Tracing Voxel Data Render By Bruce Zhou", NULL );

  //If everything initialized fine
  return 0;
}

int load_files()
{
  //Load the background image
  background = load_image( "background.png" );

  //Open the font
  font = TTF_OpenFont( "lazy.ttf", 30 );

  //If there was a problem in loading the background
  if( background == NULL )
    {
      return 1;
    }

  //If there was an error in loading the font
  if( font == NULL )
    {
      return 1;
    }

  //Load the soud effect
  scratch = Mix_LoadWAV( "scratch.wav" );

  //If there was a problem loading the sound
  if( scratch == NULL )
    {
      return 1;
    }

  //If everything loaded fine
  return 0;
}

#include "LoadData.c"
#include "RenderData.c"
#include "SaveData.c"

void clean_up()
{
  
  free(VoxelData);
  free(ColorData);
  free(DepthData);

  //Free the surfaces
  SDL_FreeSurface( background );

  //Free the sound effect
  Mix_FreeChunk( scratch );

  //Close the font
  TTF_CloseFont( font );

  //Quit SDL_mixer
  Mix_CloseAudio();

  //Quit SDL_ttf
  TTF_Quit();

  //Quit SDL
  SDL_Quit();
}

void onLButtonDown(Uint16 x, Uint16 y)
{
  int info = 0;
  char buffer[32];
  memset(buffer, 0, 32);

  if(y<100||y>356) return;
  if(x>31&&x<288)
    {
	   
      info=ColorData[(y-100)<<8|(x-32)];
	   
      sprintf(buffer, "%X", info);
      message = TTF_RenderText_Shaded( font, buffer, textColor, texbgColor );

      if( message == NULL )
	{
	  return;
	}
      //Show the message on the screen
      apply_surface( ( SCREEN_WIDTH/2 - message->w ) / 2, 60, message, screen, NULL );

      //Free the message
      SDL_FreeSurface( message );
      //Update the screen
      if( SDL_Flip( screen ) == -1 )
	{
	  return;
	}
    }
  else if(x>351&&x<608)
    {
      info=DepthData[(y-100)<<8|(x-352)];
      sprintf(buffer, "%d", info);
      message = TTF_RenderText_Shaded( font, buffer, textColor, texbgColor );

      if( message == NULL )
	{
	  return;
	}
      //Show the message on the screen
      apply_surface( ( SCREEN_WIDTH/2 - message->w ) / 2 + 320, 60, message, screen, NULL );

      //Free the message
      SDL_FreeSurface( message );
      //Update the screen
      if( SDL_Flip( screen ) == -1 )
	{
	  return;
	}
    }
}

int main( int argc, char * argv[] )
{

  //
  char Voxdata_Name[120]; /* voxdata file name */
  char Output_Name[120]; /* output file name */
  int eyeX = 128;
  int eyeY = 80;
  int eyeZ = 120;

  if (argc <3)
    { fprintf(stderr,"usage: %s <input filename> <output filename> [eyeX, eyeY, eyeZ]\n",argv[0]);
      exit(1);
    } 
  strcpy(Voxdata_Name,argv[1]) ;
  if (strchr (Voxdata_Name, '.') == NULL)
    strcat(Voxdata_Name,".vd");

    
  strcpy(Output_Name,argv[2]) ;

  if(argc==6)
    {
      eyeX=atoi(argv[3]);
      eyeY=atoi(argv[4]);
      eyeZ=atoi(argv[5]);
    }

  //Quit flag
  int quit = 0;

  //Initialize
  if( init() == 1 )
    {
      return 1;
    }

  //Load the files
  if( load_files() == 1 )
    {
      return 1;
    }

  //Apply the background
  apply_surface( 0, 0, background, screen, NULL );

  //Render the text
  message = TTF_RenderText_Solid( font, "Ray Tracing Voxel Data Render", textColor );

  //If there was an error in rendering the text
  if( message == NULL )
    {
      return 1;
    }

  //Show the message on the screen
  apply_surface( ( SCREEN_WIDTH - message->w ) / 2, 0, message, screen, NULL );

  //Free the message
  SDL_FreeSurface( message );

  //Render the text
  message = TTF_RenderText_Solid( font, "Color=", textColor );

  //If there was an error in rendering the text
  if( message == NULL )
    {
      return 1;
    }

  //Show the message on the screen
  apply_surface( ( SCREEN_WIDTH/2 - message->w ) / 2, 30, message, screen, NULL );

  //Free the message
  SDL_FreeSurface( message );

  //Render the text
  message = TTF_RenderText_Solid( font, "Depth=", textColor );

  //If there was an error in rendering the text
  if( message == NULL )
    {
      return 1;
    }

  //Show the message on the screen
  apply_surface( ( SCREEN_WIDTH/2 - message->w ) / 2 + 320, 30, message, screen, NULL );

  //Free the message
  SDL_FreeSurface( message );

	
    
  char buffer[32];
  char eyePOSstr[120];
  memset(eyePOSstr, 0, 120);
  strcat(eyePOSstr, "Eye Position: ");
  strcat(eyePOSstr, "X=");

  sprintf(buffer, "%d", eyeX);
  strcat(eyePOSstr, buffer);

  strcat(eyePOSstr, " Y=");
  sprintf(buffer, "%d", eyeY);
  strcat(eyePOSstr, buffer);

  strcat(eyePOSstr, " Z=");
  sprintf(buffer, "%d", eyeZ);
  strcat(eyePOSstr, buffer);
 
  //Render the text
  message = TTF_RenderText_Solid( font, eyePOSstr, textColor );

  //If there was an error in rendering the text
  if( message == NULL )
    {
      return 1;
    }

  //Show the message on the screen
  apply_surface( ( SCREEN_WIDTH - message->w ) / 2, 360, message, screen, NULL );

  //Free the message
  SDL_FreeSurface( message );
    
  //
  LoadData(Voxdata_Name);
  RenderData(eyeX,eyeY,eyeZ);
  SaveData(Output_Name);
  //

  //Update the screen
  if( SDL_Flip( screen ) == -1 )
    {
      return 1;
    }

  //While the user hasn't quit
  while( quit == 0 )
    {
      //While there's events to handle
      while( SDL_PollEvent( &event ) )
        {
	  //If a key was pressed
	  if( event.type == SDL_KEYDOWN )
            {
			
	      if( event.key.keysym.sym == SDLK_ESCAPE )
		{
		  quit = 1;
		}
            }
	  if( event.type == SDL_MOUSEBUTTONDOWN)
	    {
	      if( event.button.button == SDL_BUTTON_LEFT )
		{
		  //Play the scratch effect
		  if( Mix_PlayChannel( -1, scratch, 0 ) == -1 )
                    {
		      return 1;
                    }
		  onLButtonDown( event.button.x, event.button.y);
		}
	    }
	  //If the user has Xed out the window
	  if( event.type == SDL_QUIT )
            {
	      //Quit the program
	      quit = 1;
            }
        }
    }

  //Free surfaces, fonts and sounds
  //then quit SDL_mixer, SDL_ttf and SDL
  clean_up();

  return 0;
}
