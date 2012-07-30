package
{
	import com.fossilcleaner.core.FossilCleanContext;
	import com.suckerpunch.framework.engine.GameRootSprite;
	
	import flash.display.Sprite;
	
	import org.robotlegs.core.IInjector;
	
	[SWF(height="400", width="550", frameRate="30")]
	public class FossilCleanGame extends GameRootSprite
	{
		public function FossilCleanGame()
		{
			super();
		
		}
		
		[Inject]
		override public function set parentInjector( value : IInjector ) : void
		{
			context = new FossilCleanContext( this, true, value );
		}
	
	}
}

