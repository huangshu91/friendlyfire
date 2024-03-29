package com.nostradamus.entity;

import box2D.common.math.B2Vec2;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.utils.Key;
import com.haxepunk.utils.Input;

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
  private var bulletSize:Int = 8;
  private var bulletSpeed:Float = 10;
  
  private var parent:PlayerEntity;
  
  private var initForce:Float;

  public function new(x:Float, y:Float, game:GameScene, owner:PlayerEntity) {
    super(x - bulletSize, y - bulletSize, bulletSize, game, EntityType.BULLET);
    parent = owner;
    initForce = parent.shotPower/Config.physScale;
    graphic = Image.createCircle(bulletSize, 0x3333FF);
    
    var impulse:B2Vec2 = 
      new B2Vec2(initForce*Math.cos((parent.angle + parent.tilt)/Config.degInRad),
                -initForce*Math.sin((parent.angle + parent.tilt)/Config.degInRad));
    if (parent.dir == Facing.LEFT) {
      impulse.x *= -1;
    }
    var center:B2Vec2 = new B2Vec2(bodyCenter.x, bodyCenter.y);
    body.applyImpulse(impulse, center);
  }
 
  override public function update() {
    super.update();
    this.moveTo(bodyCenter.x - bulletSize, bodyCenter.y - bulletSize);

    if (collidingWithTerrain()) {
      parent.bullets.remove(this);
      HXP.world.remove(this);
    }
  }

  private function collidingWithTerrain():Bool {
    return false;
  }
}
