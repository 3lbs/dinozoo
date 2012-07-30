
package com.fossilcleaner.core.game.dustlayer
{
	
	import com.fossilcleaner.core.game.ATileLayer;
	import com.fossilcleaner.core.game.tools.AirToolEmittor;
	import com.fossilcleaner.core.game.tools.CleanTool;
	import com.suckerpunch.framework.math.physics.IForce;
	
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import org.casalib.util.NumberUtil;
	
	public class ParticleLayer extends ATileLayer
	{
		
		public static const NAME : String = "DustLayer";
		
		private var particles : Vector.<DustParticle>;
		
		private var layerWidth : Number;
		
		private var layerHeight : Number;
		
		private static var _damping : Number;
		
		internal static var forces : Vector.<IForce>;
		
		public function ParticleLayer( bounds : Rectangle )
		{
			super ( 20, bounds );
			
			forces = new Vector.<IForce> ();
			
			_damping = .90;
			
			particles = new Vector.<DustParticle>();
			
			addEventListener( Event.ENTER_FRAME, update );
		}	
		
		override public function handleMouseRequest( point : Point, tool : CleanTool ) : void
		{
			if ( tool is AirToolEmittor )
			{
				if ( particles.length > 0 )
				{
					var airTool : AirToolEmittor = tool as AirToolEmittor;
					airTool.addForces ( particles );
				}
			}
			else if ( successor )
			{
				successor.handleMouseRequest ( point, tool );
			}
		}
		
		
		override public function buildHexGrid( a_tileHeight : Number ) : void
		{
			return;
		}
		
		/**
		 * The global damping. Values should be between 0 and 1. Higher numbers result
		 * in less damping. A value of 1 is no damping. A value of 0 won't allow any
		 * particles to move. The default is 1.
		 *
		 * <p>
		 * Damping will slow down your simulation and make it more stable. If you find
		 * that your sim is "blowing up', try applying more damping.
		 * </p>
		 *
		 * @param d The damping value. Values should be >=0 and <=1.
		 */
		public static function get damping() : Number
		{
			return _damping;
		}
		
		
		/**
		 * @private
		 */
		public static function set damping( d : Number ) : void
		{
			_damping = d;
		}
		
		public function init( w : Number, h : Number ) : void
		{
			particles = new Vector.<DustParticle> ();
			
			layerWidth = w;
			layerHeight = h;
		
		}
		
		public function update( event : Event ) : void
		{
			// update the particles for thier motion
			var l : int = particles.length;
			
			if ( l > 0 )
			{
				var i : int;
				for ( i = 0; i < l; ++i )
				{
					particles[ i ].update ( .033 );
					
					if ( !bounds.contains( particles[i].x, particles[i].y ) )
					{
						removeParticle( particles[i] );
					}
				}
			}
		}
		
		public function addParticles () : void
		{
			var px : Number = NumberUtil.randomWithinRange( 10, bounds.width );
			var py : Number = NumberUtil.randomWithinRange( 10, bounds.height );
			
			var p : DustParticle = new DustParticle( px, py, 5 );
			
			particles.push( p );
		}
		
		public function addParticle( particle : DustParticle ) : void
		{
			particles.push ( particle );
			
			addChild ( particle );
		}
		
		public function removeParticle( particle : DustParticle ) : void
		{
			var idx : int = particles.indexOf ( particle );
			
			if ( idx > -1 )
			{
				particles.splice ( idx, 1 );
			}
		}
		
		
		/**
		 * Adds a force to all particles in the system. The forces added to the APEngine
		 * class are persistent - once a force is added it is continually applied each
		 * APEngine.step() cycle.
		 *
		 * @param f A IForce object
		 */
		public static function addForce( f : IForce ) : void
		{
			forces.push ( f );
		}
		
		
		/**
		 * Removes a force from the engine.
		 */
		public static function removeForce( f : IForce ) : void
		{
			var fpos : int = forces.indexOf ( f );
			
			if ( fpos == -1 )
				return;
			forces.splice ( fpos, 1 );
		}
		
		
		/**
		 * Removes all forces from the engine.
		 */
		public static function removeAllForce() : void
		{
			forces.length = 0;
		}
		
		
		override public function destroy():void 
		{
			super.destroy();
			removeEventListener( Event.ENTER_FRAME, update );
		}
	}
}

