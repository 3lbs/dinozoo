
package com.fossilcleaner.core.game.tools
{
	import com.fossilcleaner.core.game.ATileLayer;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class CleanTool extends Sprite
	{
		
		private var _isPresureTool : Boolean = false;
		
		public function CleanTool( name : String )
		{
			this.name = name;	
		}
		
		public function get isPresureTool():Boolean
		{
			return _isPresureTool;
		}
		
		public function set isPresureTool(value:Boolean):void
		{
			_isPresureTool = value;
		}
		
		public function handleToolOn () : void
		{
		
		}
		
		public function handleToolOff () : void
		{
		
		}
		
		public function cleanLayer( point : Point, param0: ATileLayer ):Boolean
		{
			return false;
		}
	}
}

