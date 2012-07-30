package com.fossilcleaner.core.control.game
{
	import com.fossilcleaner.core.game.FossilBoardMap;
	import com.fossilcleaner.core.model.FossilGameController;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class FossilMouseUpCommand extends Command
	{
		
		[Inject]
		public var event : MouseEvent;
		
		[Inject]
		public var fossilBoardMap : FossilBoardMap;
		
		[Inject]
		public var gameController : FossilGameController;
		
		public function FossilMouseUpCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			fossilBoardMap.handleMouseUp();
		}
	}
}

