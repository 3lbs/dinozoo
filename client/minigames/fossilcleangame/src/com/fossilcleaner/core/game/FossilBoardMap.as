
package com.fossilcleaner.core.game
{
	
	import com.fossilcleaner.core.game.tools.CleanTool;
	import com.fossilcleaner.core.model.FossilGameController;
	import com.suckerpunch.framework.display.BaseSprite;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class FossilBoardMap extends BaseSprite
	{
		
		[Inject]
		public var gameController : FossilGameController;
		
		protected var _id : String;
		
		protected var _widthTiles : int;
		
		protected var _heightTiles : int;
		
		protected var _widthPixel : uint;
		
		protected var _heightPixel : uint;
		
		protected var _layers : Array = new Array ();
		
		private var tileHeight : Number = 10;
		
		private var boneGroup : GroupedCompletetionLayers;
		
		private var rockGroup : GroupedCompletetionLayers;
		
		public var tolerance : int = 10;
		
		private var _chainedLayers : ATileLayer;
		
		private var currentTool : CleanTool;
		
		public function FossilBoardMap()
		{
			super ();
			
			addEventListener( Event.ENTER_FRAME, handleToolUpdate );
		}
		
		public function addLayer( layer : ATileLayer ) : void
		{
			if ( _layers.length == 0 )
			{
				//_widthPixel = _widthTiles * layer.tileSet.tileWidth;
				//_heightPixel = _heightTiles * layer.tileSet.tileHeight;
			}
			
			_layers[ layer.index ] = layer;
			
			layer.buildHexGrid ( tileHeight );
		}
		
		public function sortLayers() : void
		{
			_layers.sortOn ( "index", Array.NUMERIC );
			
			for ( var i : int = 0; i < _layers.length; ++i )
			{
				addChildAt ( _layers[ i ], i );
			}
		}
		
		public function getLayer( index : int ) : ATileLayer
		{
			return _layers[ index ];
		}
		
		
		public function get layers() : Array
		{
			return _layers;
		}
		
		public function addBoneGroup( group : GroupedCompletetionLayers ) : void
		{
			boneGroup = group;
			boneGroup.initialze ( this );
		}
		
		public function addRockGroup( group : GroupedCompletetionLayers ) : void
		{
			rockGroup = group;
			rockGroup.initialze ( this );
		
		}
		
		public function mouseStrikePoint( mousePt : Point, tool : CleanTool ) : void
		{
			_chainedLayers.handleMouseRequest ( mousePt, tool );
			
			if ( tool.isPresureTool )
			{
				currentTool = tool;
			}
		}
		
		public function handleMouseUp() : void
		{
			currentTool = null;
		}
		
		public function handleToolUpdate( event : Event ) : void
		{
			if ( currentTool )
			{
				_chainedLayers.handleMouseRequest ( null, currentTool );
			}
		}
		
		public function isBoneClean() : Number
		{
			var boneBitmapData : BitmapData = boneGroup.mergedBitmapData ();
			var boneVector : Vector.<uint> = boneBitmapData.getVector ( boneBitmapData.rect );
			
			var rockBitmpData : BitmapData = rockGroup.mergedBitmapData ();
			var rockVector : Vector.<uint> = rockBitmpData.getVector ( rockBitmpData.rect );
			
			boneBitmapData.dispose ();
			rockBitmpData.dispose ();
			
			return precentBoneIsCleaned ( boneVector, rockVector, tolerance );
		}
		
		private function precentBoneIsCleaned( v0 : Vector.<uint>, v1 : Vector.<uint>, threshold : int = 0 ) : Number
		{
			var l : int = v0.length;
			
			for ( var i : int = 0; i < l; ++i )
			{
				if ( v0[ i ] > threshold && v1[ i ] > threshold )
				{
					return 0;
				}
			}
			return 1;
		}
		
		override public function destroy() : void
		{
			super.destroy ();
			
			rockGroup.destroy ();
			boneGroup.destroy ();
			
			
			_layers.length = 0;
			_layers = null;
		
		}
		
		public function chainedDisplayLayers( chain : ATileLayer ) : void
		{
			_chainedLayers = chain;
		}
	}
}

