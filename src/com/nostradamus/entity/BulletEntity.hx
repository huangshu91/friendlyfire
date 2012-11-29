package com.nostradamus.entity;

import box2D.common.math.B2Vec2;
import com.haxepunk.graphics.Image;

import com.nostradamus.scene.GameScene;
import com.nostradamus.util.Config;

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

  public function new(x:Float, y:Float, game:GameScene, owner:PlayerEntity) {
    super(x - bulletSize, y - bulletSize, bulletSize, game, EntityType.BULLET);
    parent = owner;
    locX = x - bulletSize;
    locY = y - bulletSize;
    graphic = Image.createCircle(bulletSize, 0x3333FF);
    
    var impulse:B2Vec2 = new B2Vec2(10/Config.physScale, -10/Config.physScale);
    var center:B2Vec2 = new B2Vec2(0, 0);
    body.applyImpulse(impulse, center);
  }

  override public function update() {
    super.update();
    this.moveTo(bodyCenterX-8, bodyCenterY-8);
  }
}
