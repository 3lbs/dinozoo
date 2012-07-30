package com.fossilcleaner.core.control.game
{
	import com.fossilcleaner.core.events.FossilCleanEvent;
	import com.fossilcleaner.core.game.FossilBoardMap;
	import com.fossilcleaner.core.game.tools.CleanTool;
	import com.fossilcleaner.core.model.FossilGameController;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import org.robotlegs.mvcs.Command;
	
	public class FossilMouseDownCommand extends Command
	{
		
		[Inject]
		public var event : MouseEvent;
		
		[Inject]
		public var fossilBoardMap : FossilBoardMap;
		
		[Inject]
		public var gameController : FossilGameController;
		
		public function FossilMouseDownCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			var mousePt : Point = new Point ( event.localX, event.localY );
			
			var currentTool:CleanTool = gameController.currentTool;
			
			fossilBoardMap.mouseStrikePoint ( mousePt, currentTool );
			
			var boneCleaned : Number = fossilBoardMap.isBoneClean ();
			
			if ( boneCleaned > 0 )
			{
				dispatch( new FossilCleanEvent( FossilCleanEvent.GAME_FINISHED_EVENT ) );
			}
		
		
		}
	}
}

