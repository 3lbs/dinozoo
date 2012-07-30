package com.fossilcleaner.core.game.tools
{
	import com.fossilcleaner.core.game.dustlayer.DustParticle;
	import com.suckerpunch.framework.math.Vector2D;
	import com.suckerpunch.framework.math.physics.IForce;
	import com.suckerpunch.framework.math.physics.VectorForce;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class AirToolEmittor extends CleanTool
	{
		public static const NAME : String = "AirTool";
		
		private var _position : Vector2D;
		
		private var airRadius : Number;
		
		private var force : Number;
		
		public var displayObject : DisplayObject;
		
		private var _activateTool : Boolean;
		
		public function AirToolEmittor( display : DisplayObject, radius : Number )
		{
			super ( NAME );
			_position = new Vector2D ();
			airRadius = radius;
			//displayObject = display;
			//addChild ( displayObject );
			
			activateTool = false;
			
			force = 195;
			
			mouseChildren = false;
			mouseEnabled = false;
			
			isPresureTool = true;
		}
		
		public function get activateTool() : Boolean
		{
			return _activateTool;
		}
		
		public function set activateTool( value : Boolean ) : void
		{
			_activateTool = value;
			//displayObject.visible = _activateTool;
		}
		
		public function get position() : Vector2D
		{
			return _position;
		}
		
		public function set position( value : Vector2D ) : void
		{
			_position = value;
		}
		
		public function addForces( particles : Vector.<DustParticle> ) : void
		{
			
			if ( !_activateTool )
				return;
			
			// TODO Auto Generated method stub
			var l : int = particles.length;
			var particle : DustParticle;
			
			_position.x = x;
			_position.y = y;
			
			var dist : Number;
			var rad : Number;
			var angularForce : IForce;
			var angularVector : Vector2D;
			
			for ( var i : int = 0; i < l; ++i )
			{
				angularVector = particles[ i ].position.subtractedBy ( position );
				dist = angularVector.length;
				
				if ( dist < ( airRadius + ( particles[ i ].width * 0.50 ) ) )
				{
					//rad = Math.atan2( particles[i].y - this.y, particles[i].x - this.x);
					//angularVector = new Vector2D( Math.cos( rad ), Math.sin( rad ));//.normalize();
					
					angularVector.normalize ();
					
					angularVector.multiply ( force );
					
					angularForce = new VectorForce ( true, angularVector.x, angularVector.y );
					particles[ i ].addForce ( angularForce );
					
				}
			}
		}
	}
}

