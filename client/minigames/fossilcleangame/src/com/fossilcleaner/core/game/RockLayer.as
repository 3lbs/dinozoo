package com.fossilcleaner.core.game
{
	import com.fossilcleaner.core.game.tools.CleanTool;
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class RockLayer extends ATileLayer 
	{
		public function RockLayer(index : int, rect : Rectangle )
		{
			super( index, rect);
		}
		
		override public function handleMouseRequest(point:Point, tool:CleanTool):void
		{
			
			if ( tool.cleanLayer ( point, this ) )
			{
				successor.handleMouseRequest( point, tool );
			}
			else
			{
				trace("Hit this level: " + this);
			}
		}
	}
}

