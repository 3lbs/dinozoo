package com.fossilcleaner.core.control.startup
{
	import com.pblabs.engine.time.ProcessManager;
	
	import flash.display.Stage;
	
	import org.robotlegs.mvcs.Command;
	
	public class LocalPlayInitCommand extends Command
	{
		public function LocalPlayInitCommand()
		{
			super ();
		}
		
		override public function execute() : void
		{
			
			if ( !injector.hasMapping ( ProcessManager ) )
			{
				var processManager : ProcessManager = new ProcessManager ( contextView.stage );
				injector.mapValue ( ProcessManager, processManager );
			}
			
			super.execute ();
		}
	}
}


