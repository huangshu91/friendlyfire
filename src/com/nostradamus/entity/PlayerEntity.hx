package com.nostradamus.entity;

import com.haxepunk.graphics.Image;
import com.haxepunk.Entity;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.HXP;
import nme.geom.Point;

import com.nostradamus.scene.GameScene;
import com.nostradamus.entity.B2dEntity;
import com.nostradamus.util.Config;

/**
 * ...
 * @author maiev
 */

class PlayerEntity extends B2dEntity, implements DynamicEntity {
  
  // The default Entity.centerX and centerY are for hitbox not plain loc
  private var locX:Float;
  private var locY:Float;
  public var test:Float = 400;

  public function new(x:Float, y:Float, pName:String) {
    // (maiev): 16 is hardcoded for now but the idea is that we want
    // all coordinate to be center rather than top left.
    super(x-16, y-16);
    graphic = Image.createRect(32, 32, 0xDDEEFF);
    
    // (maiev): this is hardcoded until I find a method to get the halfsize
    locX = this.halfWidth + x + 16;
    locY = this.halfHeight + y + 16;
    name = pName;
  }
  
  override public function update() {
    super.update();

    // Key down will be true for more than 1 frame so need to check for
    // key release instead.
    if (Input.released(Key.ENTER)) {
      var scene : GameScene = cast(HXP.world, GameScene);
      scene.GetGameManager().endTurn();
    }
    
    this.moveTo(bodyCenterX-16, bodyCenterY-16);
  }
  
  public function getCenter():Point {
    return new Point(locX, locY);
  }
}
