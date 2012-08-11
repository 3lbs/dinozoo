package dinozoogame.ui
{
	import org.casalib.events.IRemovableEventDispatcher;
	
	import totem.core.mvc.view.Mediator;
	
	public class TempUIMediator extends Mediator
	{
		
		public static const NAME : String = "TempUIMediator";
		
		
		[Inject]
		public var eventDispatcher : IRemovableEventDispatcher;
		
		public function TempUIMediator()
		{
			super( NAME );
		}
		
		override public function initialize() : void
		{
			trace( "test" );
		}
		
		
	}
}