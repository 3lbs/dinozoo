
package com.fossilcleaner.core.view
{
	import com.fossilcleaner.core.game.ATileLayer;
	import com.fossilcleaner.core.game.FossilBoardMap;
	import com.pblabs.engine.time.ITickedObject;
	
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	public class FossilBoardView extends Sprite implements ITickedObject
	{
		
		private var layerMap : Dictionary = new Dictionary ();
		
		public static var ROCK_LAYER_0 : String = "RockLayer0";
		
		public static var ROCK_LAYER_1 : String = "RockLayer1";
		
		public static var BONE_LAYER_0 : String = "BoneLayer0";
		
		public static var BONE_LAYER_1 : String = "BoneLayer1";
		
		public static var ERROR_LAYER : String = "ErrorLayer";
		
		private var gameBoard : FossilBoardMap;
		
		/* game hex board and bitmapdata logic */
		public function FossilBoardView()
		{
			super ();
		}
		
		public function onTick( deltaTime : Number ) : void
		{
		
		}
		
		public function addBackground() : void
		{
		
		}
		
		public function dispose() : void
		{
		
		}
		
		public function addBoard( fossilBoard : FossilBoardMap ) : void
		{
			gameBoard = fossilBoard;
			addChild ( gameBoard );
		
		}
		
		public function getFossilBoard ()  : FossilBoardMap
		{
			return gameBoard;
		}
	}
}

