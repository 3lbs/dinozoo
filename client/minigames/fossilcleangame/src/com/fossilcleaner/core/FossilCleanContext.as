package com.fossilcleaner.core
{
	import com.fossilcleaner.core.control.startup.InitFossilGameCommand;
	
	import flash.display.DisplayObjectContainer;
	import flash.system.ApplicationDomain;
	
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.core.IInjector;
	import org.robotlegs.utilities.modular.mvcs.ModuleContext;
	
	public class FossilCleanContext extends ModuleContext
	{
		public function FossilCleanContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true, parentInjector:IInjector=null, applicationDomain:ApplicationDomain=null)
		{
			super(contextView, autoStartup, parentInjector, applicationDomain);
		}
		
		override public function startup():void
		{
			commandMap.mapEvent ( ContextEvent.STARTUP_COMPLETE, InitFossilGameCommand, ContextEvent, true );
			
			super.startup();
		}
		
		override public function shutdown():void
		{
		
		}
	}
}

