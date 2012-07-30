package com.fossilcleaner.core.game
{
	
	import com.fossilcleaner.core.game.tools.CleanTool;
	import com.suckerpunch.framework.display.BaseSprite;
	import com.suckerpunch.framework.utils.BitmapDataUtil;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.IBitmapDrawable;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import org.casalib.core.IDestroyable;
	
	public class ATileLayer extends BaseSprite implements IDestroyable
	{
		
		public var id : String;
		
		public var index : int;
		
		public var hardness : int = 20;
		
		protected var _layerBitmapImage : Bitmap;
		
		protected var bounds : Rectangle;
		
		private var tileHeight : Number;
		
		private var tileSize : Number;
		
		private var tileGridArray : Vector.<Vector.<HexCell>>;
		
		private var _successor : ATileLayer;
		
		public function ATileLayer( index : int, rect : Rectangle )
		{
			this.index = index;
			
			this.bounds = rect;
			
			mouseEnabled = false;
			mouseChildren = false;
		
		}
		
		public function getLayerByName( name : String ) : ATileLayer
		{
			if ( this.name == name )
			{
				return this;
			}
			else if ( successor )
			{
				return successor.getLayerByName ( name );
			}
			
			return null;
		}
		
		public function get layerBitmapImage() : Bitmap
		{
			return _layerBitmapImage;
		}
		
		public function set layerBitmapImage( value : Bitmap ) : void
		{
			if ( _layerBitmapImage )
				removeChild ( _layerBitmapImage );
			
			_layerBitmapImage = value;
			addChild ( layerBitmapImage );
		}
		
		public function handleMouseRequest( point : Point, tool : CleanTool ) : void
		{
			if ( successor )
			{
				successor.handleMouseRequest ( point, tool );
			}
		}
		
		public function buildHexGrid( a_tileHeight : Number ) : void
		{
			tileHeight = a_tileHeight;
			tileSize = tileHeight / Math.cos ( 30 * Math.PI / 180 ) / 2;
			
			var cellX : int = Math.ceil ( bounds.width / tileSize );
			var cellY : int = Math.ceil ( bounds.height / tileHeight );
			
			tileGridArray = new Vector.<Vector.<HexCell>> ( cellX, true );
			
			var hexCell : HexCell;
			
			for ( var row : int = 0; row < cellX; ++row )
			{
				var columnArray : Vector.<HexCell> = new Vector.<HexCell> ( cellY, true );
				
				for ( var col : int = 0; col < cellY; ++col )
				{
					hexCell = new HexCell ( hardness );
					hexCell.row = row;
					hexCell.col = col;
					hexCell.x = row * tileSize * 1.5;
					hexCell.y = col * tileHeight + ( row % 2 ) * tileHeight / 2;
					
					columnArray[ col ] = hexCell;
				}
				
				tileGridArray[ row ] = columnArray;
			}
		}
		
		public function pointToGrid( point : Point ) : Point
		{
			var xt : Number = Math.round ( point.x / tileSize / 1.5 );
			var yt : Number = Math.round ( ( point.y - ( xt % 2 ) * tileHeight / 2 ) / tileHeight );
			return new Point ( xt, yt );
		}
		
		public function gridToCell( point : Point ) : HexCell
		{
			var hexCell : HexCell = tileGridArray[ point.x ][ point.y ];
			return hexCell;
		}
		
		public function alphaPercentage() : Number
		{
			return BitmapDataUtil.alphaPercentage ( layerBitmapImage.bitmapData );;
		}
		
		override public function destroy() : void
		{
			super.destroy ();
			
			for ( var i : int = 0; i < tileGridArray.length; ++i )
			{
				var column : Vector.<HexCell> = tileGridArray[ i ];
				column.fixed = false;
				
				for ( var n : int = 0; n < column.length; ++n )
				{
					column[ n ].destroy ();
				}
				
				column.length = 0;
			}
			
			tileGridArray.fixed = false;
			tileGridArray.length = 0;
			tileGridArray = null;
			
			layerBitmapImage.bitmapData.dispose ();
			layerBitmapImage = null;
			
			successor = null;
		}
		
		public function get bitmapData() : BitmapData
		{
			return layerBitmapImage.bitmapData;
		}
		
		public function get successor() : ATileLayer
		{
			return _successor;
		}
		
		public function set successor( value : ATileLayer ) : void
		{
			_successor = value;
		}
	
	
	}
}


