/**
*Pseudo3D Parallax Mapping Demo
*November 27, 2011
*Bruce Jawn
*http://bruce-lab.blogspot.com
*Ref: http://actionsnippet.com/?p=562
* 
*Copyright (c) <2011> <Bruce Zhou>
*This software is released under the MIT License
*<http://www.opensource.org/licenses/mit-license.php>
**/
package
{
	import flash.display.*;
	import flash.filters.*;
	import flash.events.*;
	import flash.geom.*;
	public class ParallaxMapping extends Sprite
	{
		[Embed(source="DEMO_trace2.png")]
		public static var texClass:Class;
		
		[Embed(source="DEMO_depth2.png")]
		public static var depthClass:Class;
		
		private var DepthData:BitmapData = new depthClass().bitmapData;
		private var TexData:BitmapData =new texClass().bitmapData;
		
		private var displacementMap:DisplacementMapFilter;
        private var displace:BitmapData;
		private var canvas:BitmapData;

		public function ParallaxMapping():void
		{
			displace=DepthData.clone();
            canvas=TexData.clone();
            addChild(new Bitmap(canvas));
	        displacementMap=new DisplacementMapFilter(displace,new Point(0,0),1,1,0,0,DisplacementMapFilterMode.WRAP);//DisplacementMapFilterMode.CLAMP
			addEventListener(Event.ENTER_FRAME,onLoop);
		}

		private var scale:Number = 50 / stage.stageWidth;
		
		private function onLoop(evt:Event):void 
        {	
			canvas.copyPixels(TexData, canvas.rect, new Point(0,0));
			displacementMap.scaleX=25-this.mouseX*scale;
			displacementMap.scaleY=25-this.mouseY*scale;
			canvas.applyFilter(canvas, canvas.rect, new Point(0,0), displacementMap);
		}

	}//end of class
}//end of package