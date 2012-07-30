package com.fossilcleaner.core.game
{
	import com.fossilcleaner.core.game.tools.CleanTool;
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class BackgroundLayer extends ATileLayer
	{
		public static const ID : String = "BackgroundLayer";
		
		public function BackgroundLayer( index : int, rect : Rectangle )
		{
			super ( index, rect );
			
			
			mouseEnabled = true;
			mouseChildren = true;
		}
		
		override public function buildHexGrid(a_tileHeight:Number):void
		{
			// do nothing
		}
		
		override public function handleMouseRequest(point:Point, tool:CleanTool):void 
		{
			// shack background
			trace( "shake background" );
		}
	}
}

