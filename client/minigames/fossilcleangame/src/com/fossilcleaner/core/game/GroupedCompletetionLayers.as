

package com.fossilcleaner.core.game
{
	import com.fossilcleaner.core.game.FossilBoardMap;
	import com.fossilcleaner.core.game.RockLayer;
	
	import flash.display.BitmapData;
	import flash.events.IEventDispatcher;
	
	import org.casalib.events.RemovableEventDispatcher;
	
	public class GroupedCompletetionLayers extends RemovableEventDispatcher
	{
		
		private var layers : Vector.<ATileLayer>;
		
		private var parent : FossilBoardMap;
		
		private var normalPercentage : Number;
		
		public function GroupedCompletetionLayers()
		{
			layers = new Vector.<ATileLayer>();
		}
		
		public function addLayer( layer : ATileLayer ) : void
		{
			layers.push ( layer );
		}
		
		public function initialze( param : FossilBoardMap ) : void
		{
			parent = param;
			
			normalPercentage = currentPixelPrecentage ();
		}
		
		public function currentPixelPrecentage() : Number
		{
			var precent : Number = 0;			
			for ( var i : int = 0; i < layers.length; ++i )
			{
				precent += layers[ i ].alphaPercentage ();
			}
			
			precent /= layers.length;
			
			return precent;
		}
		
		public function mergedBitmapData () : BitmapData
		{
			if ( layers.length == 0 )
				return null;
			
			var bitmapData : BitmapData = new BitmapData ( layers[0].width, layers[0].height, true );
			
			for each ( var layer  : ATileLayer in layers );
			{
				bitmapData.draw( layer.bitmapData );
			}
			return bitmapData;
		}
		
		override public function destroy() : void
		{
			super.destroy ();
			parent = null;
		}
	}
}

