package com.fossilcleaner.core.view
{
	import com.fossilcleaner.core.game.BackgroundLayer;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class BoardMouseInputMediator extends Mediator
	{
		
		[Inject]
		public var fossilTable : BackgroundLayer;
		
		
		public function BoardMouseInputMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			fossilTable.addEventListener( MouseEvent.MOUSE_DOWN, handleMouseDown );
		}
		
		override public function onRemove():void 
		{
			fossilTable.removeEventListener( MouseEvent.MOUSE_DOWN, handleMouseDown );
		}
		
		protected function handleMouseDown(event:MouseEvent):void
		{
			fossilTable.stage.addEventListener( MouseEvent.MOUSE_UP, handleMouseUp );
			dispatch( event );	
		}
		
		protected function handleMouseUp(event:MouseEvent):void
		{
			fossilTable.stage.removeEventListener( MouseEvent.MOUSE_UP, handleMouseUp );
			dispatch( event );	
		}
	}
}

