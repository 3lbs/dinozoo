package com.fossilcleaner.core.game
{
	import com.fossilcleaner.core.game.tools.CleanTool;
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class ErrorLayer extends ATileLayer
	{
		public function ErrorLayer( index : int, rect : Rectangle )
		{
			super ( index, rect );
		}
		
		override public function buildHexGrid(a_tileHeight:Number):void
		{
			// do nothing
		}
		
		override public function handleMouseRequest(point:Point, tool:CleanTool):void
		{
			// test to see if it hit pixels
			//  the next one should be the background.
			// do not cut this layer
			
			var color : uint = bitmapData.getPixel( point.x, point.y );
			// if no pixels u hit straight background!
			if ( color == 0 )
			{
				super.handleMouseRequest( point, tool );
			}
		}
	}
}


