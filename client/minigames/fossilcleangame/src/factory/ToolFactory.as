package factory
{
	import com.fossilcleaner.core.game.tools.AirToolEmittor;
	import com.fossilcleaner.core.game.tools.CleanTool;
	import com.fossilcleaner.core.game.tools.Drill;
	import com.fossilcleaner.core.game.tools.Hammer;
	import com.fossilcleaner.core.model.FossilGameController;
	
	public class ToolFactory
	{
		[Embed( source = "../assets/hexknockout.png" )]
		public var hexStampClass : Class;
		
		public function ToolFactory()
		{
		}
		
		public function buildTools ( gameController : FossilGameController ) :  void
		{
			
			var  hammer : Hammer = new Hammer ();
			
			hammer.hexStamp = new hexStampClass().bitmapData;
			
			gameController.addTool ( hammer );
			
			
			var radius : Number = 30;
			var airTool : AirToolEmittor = new AirToolEmittor( null, radius );
			gameController.addTool( airTool );
			
			
			var drill : Drill = new Drill();
			gameController.addTool( drill );
			
			gameController.setCurrentTool( Hammer.NAME );
		
		
		
		}
	}
}

