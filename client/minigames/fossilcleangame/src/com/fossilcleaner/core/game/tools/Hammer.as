package com.fossilcleaner.core.game.tools
{
	import com.fossilcleaner.core.game.ATileLayer;
	import com.fossilcleaner.core.game.HexCell;
	
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	
	public class Hammer extends CleanTool
	{
		
		public static const NAME : String = "Hammer";
		
		private var force : int = 25;
		
		public var hexStamp : BitmapData;
		
		public function Hammer()
		{
			super ( NAME );
		}
		
		override public function cleanLayer( point : Point, layer : ATileLayer ) : Boolean
		{
			var cellPosition : Point = layer.pointToGrid ( point );
			
			var hexCell : HexCell = layer.gridToCell ( cellPosition );
			
			// make hit grid
			
			var passToNextLayer : Boolean = true;
			
			if ( !hexCell.cleared )
			{
				var v : Number = hexCell.hitCell ( force );
				
				if ( v == 0 )
				{
					hexCell.cleared = true;
					
					var layerImage : BitmapData = layer.bitmapData;
					layerImage.copyChannel( hexStamp, hexStamp.rect, new Point( hexCell.x, hexCell.y ), BitmapDataChannel.ALPHA, BitmapDataChannel.ALPHA );
					
				}
				
				passToNextLayer = false;
			}
			
			
			
			return passToNextLayer;
		}
	
	}
}

