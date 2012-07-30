package com.fossilcleaner.core.game.tools
{
	import flash.events.IEventDispatcher;
	
	public class Drill extends CleanTool
	{
		
		public static const NAME : String = "drill";
		
		public function Drill()
		{
			super( NAME );
			
			isPresureTool = true;
		}
	}
}

