package dinozoogame
{
	import flash.display.Sprite;
	import flash.display.Stage;

	import org.swiftsuspenders.Injector;

	import totem.core.mvc.TotemContext;

	public class DinoZooContext extends TotemContext
	{
		public function DinoZooContext( stage : Sprite, injector : Injector = null )
		{
			super( stage, injector );
		}
	}
}
