package com.fossilcleaner.core.control.startup
{
	import com.fossilcleaner.core.view.FossilBoardMediator;
	import com.fossilcleaner.core.view.FossilBoardView;
	import com.pblabs.engine.time.ProcessManager;
	
	import factory.FossilBoardFactory;
	
	import flash.display.Stage;
	
	import org.robotlegs.mvcs.Command;
	import org.robotlegs.utilities.macrobot.SequenceCommand;
	
	public class InitFossilGameCommand extends SequenceCommand
	{
		public function InitFossilGameCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			//
			addCommand( LocalPlayInitCommand );
			addCommand( StartupGameCommand );
			
			super.execute();
		}
	}
}

