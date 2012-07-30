package com.fossilcleaner.core.view
{
	import assets.uiassets.FossilGameUIFrame;
	
	import com.fossilcleaner.core.events.FossilCleanEvent;
	import com.fossilcleaner.core.game.tools.AirToolEmittor;
	import com.fossilcleaner.core.game.tools.Drill;
	import com.fossilcleaner.core.game.tools.Hammer;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class FossilUIFrameMediator extends Mediator
	{
		[Inject]
		public var view : FossilGameUIFrame;
		
		public function FossilUIFrameMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			view.hammerBt.addEventListener( MouseEvent.CLICK, handleHammerBt );
			view.drillBt.addEventListener( MouseEvent.CLICK, handleDrillBt );
			view.brushBt.addEventListener( MouseEvent.CLICK, handleBrushBt );
		}
		
		protected function handleBrushBt(event:MouseEvent):void
		{
			dispatch( new FossilCleanEvent( FossilCleanEvent.CHANGE_TOOL_EVENT, AirToolEmittor.NAME ) );
			resetButtons();
			view.brushBt.gotoAndStop( 2 );
		}		
		
		protected function handleDrillBt(event:MouseEvent):void
		{
			dispatch( new FossilCleanEvent( FossilCleanEvent.CHANGE_TOOL_EVENT, Drill.NAME ) );
			resetButtons();
			view.drillBt.gotoAndStop( 2 );
		}
		
		protected function handleHammerBt(event:MouseEvent):void
		{
			dispatch( new FossilCleanEvent( FossilCleanEvent.CHANGE_TOOL_EVENT, Hammer.NAME ) );
			resetButtons();
			view.hammerBt.gotoAndStop( 2 );
		}
		
		private function resetButtons () : void
		{
			view.hammerBt.gotoAndStop( 1 );
			view.drillBt.gotoAndStop( 1 );
			view.brushBt.gotoAndStop( 1 );
		}
	}
}

