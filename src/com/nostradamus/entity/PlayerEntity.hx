package com.nostradamus.entity;

import com.haxepunk.graphics.Image;
import com.haxepunk.Entity;
import com.haxepunk.math.Vector;
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

/*
 * (maiev): For now this class is used as is but in the future
 * extend this to create custom bot types.
 * 
 */

class PlayerEntity extends B2dEntity, implements DynamicEntity {
  
  // The default Entity.centerX and centerY are for hitbox not plain loc
  private var locX:Float;
  private var locY:Float;
  
  private var hasFired:Bool;
  
  public var bullets:Array<BulletEntity>;

  public function new(x:Float, y:Float, pName:String, size:Float, world:GameScene) {
    // (maiev): 16 is hardcoded for now but the idea is that we want
    // all coordinate to be center rather than top left.
    super(x - 16, y - 16, size, world, EntityType.PLAYER);
    graphic = Image.createRect(32, 32, 0xDDEEFF);
    hasFired = false;
    
    // (maiev): this is hardcoded until I find a method to get the halfsize
    locX = this.halfWidth + x + 16;
    locY = this.halfHeight + y + 16;
    name = pName;
  }
  
  override public function update() {
    super.update();
    
    this.moveTo(bodyCenterX-16, bodyCenterY-16);
  }
  
  public function UpdateTurn() {
    // Key down will be true for more than 1 frame so need to check for
    // key release instead.
    if (Input.released(Key.ENTER)) {
      scene.GetGameManager().EndTurn();
    }
    
    if (Input.released(Key.Z) && hasFired == false) {
      //create a bullet
      hasFired = true;
    }
  }
  
  public function getCenter():Point {
    return new Point(locX, locY);
  }
  
  public function GetBullets():Array<BulletEntity> {
    return bullets;
  }
  
  public function ResetFire() {
    hasFired = false;
  }
}
