package com.nostradamus.entity;

import box2D.common.math.B2Vec2;
import com.haxepunk.graphics.Image;

import com.nostradamus.scene.GameScene;
import com.nostradamus.util.Config;
import com.nostradamus.entity.DynamicEntity;

/**
 * ...
 * @author maiev
 */

/*
 * (maiev): This class for now is just for the creation of a single bullet.
 * however, in the future you will extend this and create a shot type that
 * different bots can use.
 */
class BulletEntity extends B2dEntity {
  private var locX:Float;
  private var locY:Float;
  
  // Use this for now but in future bullet size is determined by shot
  private var bulletSize:Int = 8;
  private var bulletSpeed:Float = 10;
  
  private var parent:PlayerEntity;
  
  private var initForce:Float;

  public function new(x:Float, y:Float, game:GameScene, owner:PlayerEntity) {
    super(x - bulletSize, y - bulletSize, bulletSize, game, EntityType.BULLET);
    parent = owner;
    initForce = parent.shotPower/Config.physScale;
    locX = x - bulletSize;
    locY = y - bulletSize;
    graphic = Image.createCircle(bulletSize, 0x3333FF);
    
    var impulse:B2Vec2 = 
      new B2Vec2(initForce * Math.cos((parent.angle + parent.tilt) / 57.3),
                 -initForce * Math.sin((parent.angle + parent.tilt) / 57.3));
    if (parent.dir == Facing.LEFT) {
      impulse.x *= -1;
    }
    var center:B2Vec2 = new B2Vec2(bodyCenterX, bodyCenterY);
    body.applyImpulse(impulse, center);
  }

  override public function update() {
    super.update();
    this.moveTo(bodyCenterX-8, bodyCenterY-8);
  }
}
