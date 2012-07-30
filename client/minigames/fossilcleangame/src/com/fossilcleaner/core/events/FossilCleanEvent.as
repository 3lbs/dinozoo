package com.fossilcleaner.core.events
{
	import com.suckerpunch.framework.events.ObjectEvent;
	
	public class FossilCleanEvent extends ObjectEvent
	{
		
		public static const GAME_FINISHED_EVENT : String = "FossilCleanEvents:GameFinishedEvent";
		
		public static const GAME_START_EVENT : String = "FossilCleanEvents:GameStartEvent";
		
		public static const CHANGE_TOOL_EVENT : String = "FossilCleanEvents:ChangeToolEvent";
		
		public function FossilCleanEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
	}
}

