package factory
{
	import com.fossilcleaner.core.game.BackgroundLayer;
	import com.fossilcleaner.core.game.BoneLayer;
	import com.fossilcleaner.core.game.ErrorLayer;
	import com.fossilcleaner.core.game.FossilBoardMap;
	import com.fossilcleaner.core.game.GroupedCompletetionLayers;
	import com.fossilcleaner.core.game.RockLayer;
	import com.fossilcleaner.core.game.dustlayer.DustParticle;
	import com.fossilcleaner.core.game.dustlayer.ParticleLayer;
	import com.fossilcleaner.core.view.FossilBoardView;
	
	import flash.geom.Rectangle;
	
	public class FossilBoardFactory
	{
		
		[Embed( source = "../assets/bone_error_layer.png" )]
		private var BoneErrorLayerImage : Class;
		
		[Embed( source = "../assets/bone_layer.png" )]
		private var BoneLayerImage : Class;
		
		[Embed( source = "../assets/background.png" )]
		private var BackgroundImage : Class;
		
		[Embed( source = "../assets/dirt_layer0.png" )]
		private var DirtLayer0 : Class;
		
		[Embed( source = "../assets/dirt_layer1.png" )]
		private var DirtLayer1 : Class;
		
		public function FossilBoardFactory()
		{
		}
		
		public function build ( params : Object ) : FossilBoardMap
		{
			// consider this a VO game util object
			var fossilBoard : FossilBoardMap = new FossilBoardMap();
			
			var bounds : Rectangle = new Rectangle( 0, 0, 400, 300 );
			
			var dustLayer : ParticleLayer = new ParticleLayer( bounds );
			
			// 2 rock layers 
			var rockLayer0 : RockLayer = new RockLayer( 5, bounds );
			rockLayer0.layerBitmapImage =  new DirtLayer0();
			
			var rockLayer1 : RockLayer = new RockLayer( 4, bounds );
			rockLayer1.layerBitmapImage =  new DirtLayer1();
			
			fossilBoard.addLayer( rockLayer0 );
			fossilBoard.addLayer( rockLayer1 );
			
			// 2 fossil layer
			var fossilLayer0 : BoneLayer = new BoneLayer( 3, bounds );
			fossilLayer0.layerBitmapImage = new BoneLayerImage();
			
			var fossilLayer1 : BoneLayer = new BoneLayer( 2, bounds );
			fossilLayer1.layerBitmapImage = new BoneLayerImage();
			
			fossilBoard.addLayer( fossilLayer0 );
			fossilBoard.addLayer( fossilLayer1 );
			
			// 1 error too deep layer
			var errorLayer : ErrorLayer = new ErrorLayer( 1, bounds );
			errorLayer.layerBitmapImage = new BoneErrorLayerImage();
			
			fossilBoard.addLayer( errorLayer );
			
			// the background layer
			var backgroundLayer : BackgroundLayer = new BackgroundLayer( 0, bounds );
			backgroundLayer.layerBitmapImage = new BackgroundImage();
			
			fossilBoard.addLayer( backgroundLayer );
			
			fossilBoard.sortLayers();
			
			// Chain of responsibilty for MouseHit
			dustLayer.successor = rockLayer0;
			rockLayer0.successor = rockLayer1;
			rockLayer1.successor  = fossilLayer0;
			fossilLayer0.successor = fossilLayer1;
			fossilLayer1.successor = errorLayer;
			errorLayer.successor = backgroundLayer;
			
			fossilBoard.chainedDisplayLayers( dustLayer );
			
			// group the rock layers for game total bitmap transparncy
			var rockGroup : GroupedCompletetionLayers =  new GroupedCompletetionLayers();
			rockGroup.addLayer ( rockLayer0 ); 
			rockGroup.addLayer ( rockLayer1 );
			
			fossilBoard.addRockGroup( rockGroup );
			
			// group the bone layer for game bitmap transparncy
			var boneGroup : GroupedCompletetionLayers = new GroupedCompletetionLayers();
			boneGroup.addLayer( fossilLayer0 );
			boneGroup.addLayer( fossilLayer1 );
			
			fossilBoard.addBoneGroup ( boneGroup );
			
			return fossilBoard;
		}
	}
}

