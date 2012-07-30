package com.fossilcleaner.core.control.startup
{
	import assets.uiassets.FossilGameUIFrame;
	
	import com.fossilcleaner.core.control.game.ChangeToolCommand;
	import com.fossilcleaner.core.control.game.FossilMouseDownCommand;
	import com.fossilcleaner.core.control.game.FossilMouseUpCommand;
	import com.fossilcleaner.core.control.game.GameFinishedCommand;
	import com.fossilcleaner.core.events.FossilCleanEvent;
	import com.fossilcleaner.core.game.BackgroundLayer;
	import com.fossilcleaner.core.game.FossilBoardMap;
	import com.fossilcleaner.core.model.FossilGameController;
	import com.fossilcleaner.core.view.BoardMouseInputMediator;
	import com.fossilcleaner.core.view.FossilBoardMediator;
	import com.fossilcleaner.core.view.FossilBoardView;
	import com.fossilcleaner.core.view.FossilUIFrameMediator;
	import com.pblabs.engine.time.ProcessManager;
	
	import factory.FossilBoardFactory;
	import factory.ToolFactory;
	
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	import org.robotlegs.mvcs.Command;
	
	public class StartupGameCommand extends Command
	{
		[Inject]
		public var processManager:ProcessManager;
		
		public function StartupGameCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			
			commandMap.mapEvent( MouseEvent.MOUSE_DOWN, FossilMouseDownCommand, MouseEvent );
			commandMap.mapEvent( MouseEvent.MOUSE_UP, FossilMouseUpCommand, MouseEvent );
			commandMap.mapEvent( FossilCleanEvent.GAME_FINISHED_EVENT, GameFinishedCommand );
			commandMap.mapEvent( FossilCleanEvent.CHANGE_TOOL_EVENT, ChangeToolCommand, FossilCleanEvent );
			
			// actors
			var gameController : FossilGameController = new FossilGameController();
			injector.mapValue( FossilGameController, gameController );
			
			// mediators
			mediatorMap.mapView( FossilGameUIFrame, FossilUIFrameMediator );
			mediatorMap.mapView( FossilBoardView, FossilBoardMediator );
			mediatorMap.mapView( BackgroundLayer, BoardMouseInputMediator );
			
			// factory for main board
			var boardFactory : FossilBoardFactory = new FossilBoardFactory ();
			var fossilBoard : FossilBoardMap = boardFactory.build(null);
			
			injector.mapValue( FossilBoardMap, fossilBoard );
			
			var fossilBoardView : FossilBoardView = new FossilBoardView();
			fossilBoardView.addBoard( fossilBoard );
			
			var fossilUIFrame : FossilGameUIFrame = new FossilGameUIFrame();
			
			fossilUIFrame.backgroundFrame.addChild( fossilBoardView );
			
			contextView.addChild( fossilUIFrame );
			
			processManager.addTickedObject( fossilBoardView );
			
			// build and set tools
			var toolFactory : ToolFactory = new ToolFactory();
			toolFactory.buildTools( gameController );
		
		
		}
	}
}

