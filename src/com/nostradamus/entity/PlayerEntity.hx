package com.nostradamus.entity;

import com.haxepunk.graphics.Image;
import com.haxepunk.Entity;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.HXP;
import nme.geom.Point;

import com.nostradamus.scene.GameScene;

/**
 * ...
 * @author maiev
 */

class PlayerEntity extends Entity, implements DynamicEntity {
  
  // The default Entity.centerX and centerY are for hitbox not plain loc
  private var locX:Float;
  private var locY:Float;

  public function new(x:Float, y:Float, pName:String) {
    super(x, y);
    graphic = Image.createRect(32, 32, 0xDDEEFF);
    locX = this.halfWidth + x;
    locY = this.halfHeight + y;
    name = pName;
  }
  
  override public function update() {
    super.update();

    // Key down will be true for more than 1 frame so need to check for
    // key release instead.
    if (Input.released(Key.ENTER)) {
      
    }
  }
  
  public function getCenter():Point {
    return new Point(locX, locY);
  }
}
