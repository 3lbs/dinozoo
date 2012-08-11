package
{
	import dinozoogame.DinoZooContext;

	import flash.display.Sprite;
	import flash.events.Event;

	import org.swiftsuspenders.Injector;

	import totem.core.TotemGameSprite;

	public class DinoZooGame extends TotemGameSprite
	{
		private var dinoZooContext : DinoZooContext;

		public function DinoZooGame()
		{
		}

		override protected function handleAddToStage( event : Event ) : void
		{
			super.handleAddToStage( event );


		}
		
		override public function set parentInjector( injector : Injector ) : void
		{
			injector ||= new Injector()
			dinoZooContext = new DinoZooContext( this, injector );
		}
		
	}
}
