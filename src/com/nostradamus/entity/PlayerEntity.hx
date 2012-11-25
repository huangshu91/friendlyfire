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
import com.nostradamus.entity.DynamicEntity;

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
  
  public var dir:Facing;

  public function new(x:Float, y:Float, pName:String, size:Float, world:GameScene) {
    // (maiev): 16 is hardcoded for now but the idea is that we want
    // all coordinate to be center rather than top left.
    super(x - size, y - size, size, world, EntityType.PLAYER);
    graphic = Image.createRect(32, 32, 0xFF3333);
    hasFired = false;
    dir = Facing.RIGHT;
    
    bullets = new Array<BulletEntity>();
    
    // (maiev): this is hardcoded until I find a method to get the halfsize
    locX = this.halfWidth + x + size;
    locY = this.halfHeight + y + size;
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
      scene.gameManager.EndTurn();
    }
    
    if (Input.released(Key.Z)){// && hasFired == false) {
      //create a bullet
      hasFired = true;
      var bullet = new BulletEntity(bodyCenterX + 10, bodyCenterY - 10, scene);
      bullets.push(bullet);
      HXP.world.add(bullet);
    }
  }

  public function ResetFire() {
    hasFired = false;
  }
  


  public function GetCenter():Point {
    return new Point(locX, locY);
  }
}
