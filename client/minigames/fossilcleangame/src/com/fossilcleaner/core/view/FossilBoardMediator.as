package com.fossilcleaner.core.view
{
	import org.robotlegs.mvcs.Mediator;
	
	public class FossilBoardMediator extends Mediator
	{
		
		[Inject]
		public var fossilBoard : FossilBoardView;
		
		public function FossilBoardMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			trace("tdfsdf dsf");
		
		
		}
		
		override public function onRemove():void
		{
			fossilBoard.dispose();	
		}
	}
}

