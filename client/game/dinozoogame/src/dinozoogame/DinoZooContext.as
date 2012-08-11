package dinozoogame
{
	import dinozoogame.ui.TempUIMediator;
	import dinozoogame.ui.TempUIView;
	
	import flash.display.Sprite;
	
	import org.casalib.events.IRemovableEventDispatcher;
	import org.casalib.events.RemovableEventDispatcher;
	import org.swiftsuspenders.Injector;
	
	import totem.core.mvc.TotemContext;
	import totem.core.mvc.controller.command.ControllerSystemManager;
	import totem.core.mvc.view.MediatorSystemManager;
	import totem.core.mvc.view.ViewMap;

	public class DinoZooContext extends TotemContext
	{

		private var mediators:MediatorSystemManager;

		public function DinoZooContext(stage:Sprite, injector:Injector=null)
		{
			super(stage, injector);
		}

		
		override protected function initializeInjector():void
		{
			super.initializeInjector();
			
			if ( _injector )
			{
				eventDispatcher = new RemovableEventDispatcher();
				_injector.map( DinoZooContext ).toValue( this );
				_injector.map( IRemovableEventDispatcher ).toValue( eventDispatcher );
			}
		}
		
		override public function initialize():void
		{
			super.initialize();

			mediators=new MediatorSystemManager(this);
			registerManager(MediatorSystemManager, mediators);

			var controller:ControllerSystemManager=new ControllerSystemManager(this);
			registerManager(ControllerSystemManager, controller);

			var views:ViewMap=new ViewMap();
			registerManager(ViewMap, views);

		}

		override protected function start():void
		{
			mediators.mapView(TempUIView, TempUIMediator);

			var view : * = mainClass.addChild(new TempUIView());
			
			mainClass.removeChild( view );
		}
	}
}
