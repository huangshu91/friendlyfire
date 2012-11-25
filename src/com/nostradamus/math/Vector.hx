package com.nostradamus.math;

/* (adn): Vector class because HaXePunk's sucks dick.
 * Can add operator overloading later with hxop, but that seems like a waste 
 * of time now.
 */
class Vector
{
  public var x:Float;
  public var y:Float;
  public var length(GetLength, null):Float;

  public function new(?inX:Float=0, ?inY:Float=0) {
    x = inX;
    y = inY;
  }

  /* (adn): Most functions will return a new vector so we can concatenate
   * vector operations. i.e.:
   * var target = new Vector(2, 2);
   * var position = new Vector(1, 1);
   * var velocity = target.sub(position).normalized().mul(max_velocity)
   */

  public function print() {
    trace("(" + Std.string(x) + ", " + Std.string(y) + ")");
  }
  
  public function add(vector:Vector):Vector {
    return new Vector(x + vector.x, y + vector.y);
  }

  public function sub(vector:Vector):Vector {
    return new Vector(x - vector.x, y - vector.y);
  }

  public function div(n:Float):Vector {
    return new Vector(x/n, y/n);
  }

  public function mul(n:Float):Vector {
    return new Vector(x*n, y*n);
  }

  public function clone():Vector {
    return new Vector(x, y);
  }

  public function normalize():Vector {
    var l = length;
    if (l > 0) {
      x /= l;
      y /= l;
    }
    return this;
  }

  public function normalized():Vector {
    return clone().normalize();
  }

  public function perp():Vector {
    return new Vector(y, -x);
  }

  public function dot(vector:Vector):Float {
    return x*vector.x + y*vector.y;
  }

  public function angle():Float {
    return Math.atan2(y, x);
  }

  public function distance(vector:Vector):Float {
    return sub(vector).length;
  }

  public function truncate(max_length:Float):Vector {
    var s = max_length/length;
    if (s >= 1) {
      s = 1;
    }
    return new Vector(x*s, y*s);
  }



  private function GetLength():Float {
    return Math.sqrt(x*x + y*y);
  }
}
