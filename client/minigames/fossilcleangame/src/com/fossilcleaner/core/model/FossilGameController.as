package com.fossilcleaner.core.model
{
	import com.fossilcleaner.core.game.tools.CleanTool;
	import com.fossilcleaner.core.game.tools.Hammer;
	
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	import org.casalib.events.RemovableEventDispatcher;
	
	public class FossilGameController extends RemovableEventDispatcher
	{
		
		private var _currentTool : CleanTool;
		
		private var tools : Dictionary;
		
		public function FossilGameController()
		{
			tools = new Dictionary();
		}
		
		public function get currentTool():CleanTool
		{
			return _currentTool;
		}
		
		public function setCurrentTool( name : String ):void
		{
			if ( tools[ name ] )
			{
				_currentTool = tools[name];
			}
		}
		
		public function addTool(tool:CleanTool):void
		{
			tools[tool.name] = tool;
		}
	}
}

