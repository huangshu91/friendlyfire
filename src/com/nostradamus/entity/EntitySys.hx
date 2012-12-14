package com.nostradamus.entity;

import com.haxepunk.HXP;
import com.haxepunk.Entity;

/**
 * ...
 * @author maiev
 */

// ???
class EntitySys {

  public function new() {

  }

  public function add(entity: Entity) {
    HXP.world.add(entity);
  }

  public function remove(entity: Entity) {
    HXP.world.remove(entity);
  }

  /* 
  // I assume this class is for stuff like this...
  // Just creating some stubs~ 
  public function GetEntitiesAroundPoint(x:Float, y:Float, 
                                         radius:Float):Array<Entity> {
    // ...
  }

  public function GetClosestEntityToPoint(x:Float, y:Float):Entity {
    // ...
  }
  */
}
