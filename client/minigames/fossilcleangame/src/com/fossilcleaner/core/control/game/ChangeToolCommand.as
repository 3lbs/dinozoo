package com.fossilcleaner.core.control.game
{
	import com.fossilcleaner.core.events.FossilCleanEvent;
	import com.fossilcleaner.core.model.FossilGameController;
	
	import org.robotlegs.mvcs.Command;
	
	public class ChangeToolCommand extends Command
	{
		
		[Inject]
		public var event : FossilCleanEvent;
		
		[Inject]
		public var gameController : FossilGameController;
		
		public function ChangeToolCommand()
		{
			super ();
		}
		
		override public function execute() : void
		{
			var toolName : String = event.data as String;
			
			if ( gameController.currentTool.name != toolName )
				gameController.setCurrentTool ( toolName);
		}
	}
}

