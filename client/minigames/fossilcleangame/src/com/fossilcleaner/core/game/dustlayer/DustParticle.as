
package com.fossilcleaner.core.game.dustlayer
{
	
	import com.suckerpunch.framework.math.Vector2D;
	import com.suckerpunch.framework.math.physics.IForce;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.getQualifiedClassName;
	
	
	/**
	 * The abstract base class for all particles.
	 *
	 * <p>
	 * You should not instantiate this class directly -- instead use one of the subclasses.
	 * </p>
	 */
	public class DustParticle extends Sprite
	{
		
		/** @private */
		internal var curr : Vector2D;
		
		/** @private */
		internal var prev : Vector2D;
		
		/** @private */
		
		private var temp : Vector2D;
		
		private var forces : Vector2D;
		
		private var forceList : Vector.<IForce>;
		
		private var _mass : Number;
		
		private var _invMass : Number;
		
		private var _position : Vector2D;
		
		public var displayObject : DisplayObject;
		
		public var displayObjectOffset : Vector2D;
		
		/**
		 * @private
		 */
		public function DustParticle( x : Number, y : Number, mass : Number )
		{
			
			
			curr = new Vector2D ( x, y );
			prev = new Vector2D ( x, y );
			
			_position = new Vector2D ();
			position = new Vector2D ( curr.x, curr.y );
			
			temp = new Vector2D ();
			
			forces = new Vector2D ();
			forceList = new Vector.<IForce> ();
			
			this.mass = mass;
		
		}
		
		public function destroyParticle() : void
		{
			forceList.length = 0;
			forceList = null;
		}
		
		/**
		 * The mass of the particle. Valid values are greater than zero. By default, all particles
		 * have a mass of 1. The mass property has no relation to the size of the particle.
		 *
		 * @throws ArgumentError ArgumentError if the mass is set less than zero.
		 */
		public function get mass() : Number
		{
			return _mass;
		}
		
		
		/**
		 * @private
		 */
		public function set mass( m : Number ) : void
		{
			if ( m <= 0 )
				throw new ArgumentError ( "mass may not be set <= 0" );
			_mass = m;
			_invMass = 1 / _mass;
		}
		
		/**
		 * The position of the particle. Getting the position of the particle is useful
		 * for drawing it or testing it for some custom purpose.
		 *
		 * <p>
		 * When you get the <code>position</code> of a particle you are given a copy of
		 * the current location. Because of this you cannot change the position of a
		 * particle by altering the <code>x</code> and <code>y</code> components of the
		 * Vector you have retrieved from the position property. You have to do something
		 * instead like: <code> position = new Vector(100,100)</code>, or you can use the
		 * <code>px</code> and <code>py</code> properties instead.
		 * </p>
		 *
		 * <p>
		 * You can alter the position of a particle three ways: change its position, set
		 * its velocity, or apply a force to it. Setting the position of a non-fixed
		 * particle is not the same as setting its fixed property to true. A particle held
		 * in place by its position will behave as if it's attached there by a 0 length
		 * spring constraint.
		 * </p>
		 */
		public function get position() : Vector2D
		{
			_position.x = curr.x;
			_position.y = curr.y;
			
			return _position;
		}
		
		
		/**
		 * @private
		 */
		public function set position( p : Vector2D ) : void
		{
			var temp : Vector2D = new Vector2D ( p.x, p.y );
			
			curr.copy ( temp );
			prev.copy ( temp );
			
			this.x = p.x;
			this.y = p.y;
		}
		
		
		/**
		 * The x position of this particle
		 */
		public function get px() : Number
		{
			return curr.x;
		}
		
		
		/**
		 * @private
		 */
		public function set px( x : Number ) : void
		{
			curr.x = x;
			prev.x = x;
		}
		
		
		/**
		 * The y position of this particle
		 */
		public function get py() : Number
		{
			return curr.y;
		}
		
		
		/**
		 * @private
		 */
		public function set py( y : Number ) : void
		{
			curr.y = y;
			prev.y = y;
		}
		
		
		/**
		 * The velocity of the particle. If you need to change the motion of a particle,
		 * you should either use this property, or one of the addForce methods. Generally,
		 * the addForce methods are best for slowly altering the motion. The velocity
		 * property is good for instantaneously setting the velocity, e.g., for
		 * projectiles.
		 *
		 */
		public function get velocity() : Vector2D
		{
			return curr.subtractedBy ( prev );
		}
		
		
		/**
		 * @private
		 */
		public function set velocity( v : Vector2D ) : void
		{
			prev = curr.subtractedBy ( v );
		}
		
		
		
		/**
		 * Assigns a DisplayObject to be used when painting this particle.
		 */
		public function setDisplay( d : DisplayObject, offsetX : Number = 0, offsetY : Number = 0, rotation : Number = 0 ) : void
		{
			
			displayObject = d;
			displayObjectOffset = new Vector2D ( offsetX, offsetY );
		}
		
		
		/**
		 * Adds a force to the particle. Using this method to a force directly to the
		 * particle will only apply that force for a single APEngine.step() cycle.
		 *
		 * @param f An IForce object.
		 */
		public function addForce( f : IForce ) : void
		{
			forceList.push ( f );
		}
		
		
		/**
		 * The <code>update()</code> method is called automatically during the
		 * APEngine.step() cycle. This method integrates the particle.
		 */
		public function update( dt2 : Number ) : void
		{
			
			accumulateForces ();
			
			temp.copy ( curr );
			var nv : Vector2D = velocity.addedTo ( forces.multipliedBy ( dt2 ) );
			curr.addTo ( nv.multiply ( ParticleLayer.damping ) );
			prev.copy ( temp );
			
			this.x = curr.x;
			this.y = curr.y;
			
			clearForces ();
		
		
		}
		
		/**
		 * @private
		 */
		public function initDisplay() : void
		{
			displayObject.x = displayObjectOffset.x;
			displayObject.y = displayObjectOffset.y;
			addChild ( displayObject );
		}
		
		/**
		 * @private
		 */
		internal function get invMass() : Number
		{
			return _invMass;
		}
		
		
		/**
		 * Accumulates both the particle forces and the global forces
		 */
		private function accumulateForces() : void
		{
			
			var f : IForce;
			
			var len : int = forceList.length;
			
			for ( var i : int = 0; i < len; i++ )
			{
				f = forceList[ i ];
				forces.addTo ( f.getValue ( _invMass ) );
			}
			
			var globalForces : Vector.<IForce> = ParticleLayer.forces;
			len = globalForces.length;
			
			for ( i = 0; i < len; i++ )
			{
				f = globalForces[ i ];
				forces.addTo ( f.getValue ( _invMass ) );
			}
		}
		
		
		/**
		 * Clears out all forces on the particle
		 */
		private function clearForces() : void
		{
			forceList.length = 0;
			forces.Set ( 0, 0 );
		}
	}
}

