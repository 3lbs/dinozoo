
package com.fossilcleaner.core.game
{
	import com.fossilcleaner.core.game.tools.CleanTool;
	
	import flash.events.IEventDispatcher;
	
	import org.casalib.events.RemovableEventDispatcher;
	
	public class HexCell extends RemovableEventDispatcher
	{
		private var _weight : Number;
		
		public var x : int;
		
		public var y : int;
		public var row:int;
		public var col:int;
		
		private var _cleared : Boolean = false;
		
		public function HexCell( hardness : int )
		{
			weight = hardness;
			cleared = false;
			x = 0;
			y = 0;
		}
		
		override public function destroy() : void
		{
			super.destroy ();
		
		}
		
		public function get weight() : Number
		{
			return _weight;
		}
		
		public function set weight( value : Number ) : void
		{
			_weight = value;
		}
		
		public function hitCell( force : Number ) : Number
		{
			weight = Math.max( 0, weight - force ); 
			
			return weight;
		}
		
		override public function toString () : String
		{
			return "HexCell ["+ x + ", " + y + "]";
		}
		
		public function get cleared():Boolean
		{
			return _cleared;
		}
		
		public function set cleared(value:Boolean):void
		{
			_cleared = value;
		}
	
	}
}

