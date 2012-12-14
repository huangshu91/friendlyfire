package com.nostradamus.entity;

import com.haxepunk.graphics.Image;
import com.haxepunk.Entity;
import com.haxepunk.math.Vector;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.HXP;
import nme.display.Sprite;
import nme.geom.Point;

import com.nostradamus.scene.GameScene;
import com.nostradamus.entity.B2dEntity;
import com.nostradamus.util.Config;
import com.nostradamus.entity.DynamicEntity;
import com.nostradamus.math.Vector;

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
  private var hasFired:Bool;
  
  public var bullets:Array<BulletEntity>;
  
  public var dir:Facing;
  
  // tilt is is entity is on slope
  public var angle:Float;
  public var tilt:Float;
  private var angleInd:Sprite;
  
  private var keyHeld:Float;
  
  public var shotPower:Float;

  public function new(x:Float, y:Float, pName:String, size:Float, world:GameScene) {
    // (maiev): 16 is hardcoded for now but the idea is that we want
    // all coordinate to be center rather than top left.
    super(x - size, y - size, size, world, EntityType.PLAYER);
    graphic = Image.createRect(32, 32, 0xFF3333);
    hasFired = false;
    dir = Facing.RIGHT;
    keyHeld = 0;
    shotPower = 0;
    tilt = 0;
    angle = 0;
    angleInd = new Sprite();
    HXP.engine.addChild(angleInd);

    bullets = new Array<BulletEntity>();
    
    name = pName;
  }
  
  override public function update() {
    super.update();
    this.moveTo(bodyCenter.x - radius, bodyCenter.y - radius);
    
    // (maiev): move all drawing code to render in future
    angleInd.graphics.clear();
    angleInd.graphics.lineStyle(1, 0xFFFFFF);
    angleInd.graphics.moveTo(bodyCenter.x, bodyCenter.y);
    
    var newP:Vector = new Vector(30*Math.cos((angle + tilt)/Config.degInRad),
                                 30*Math.sin((angle + tilt)/Config.degInRad));
    if (dir == Facing.LEFT) {
      // default is facing right, reverse if left
      newP.x *= -1;
    }
    angleInd.graphics.lineTo(bodyCenter.x + newP.x, bodyCenter.y - newP.y);
    
  }

  public function UpdateTurn() {
    // Key down will be true for more than 1 frame so need to check for
    // key release instead.
    if (Input.released(Key.ENTER)) {
      scene.gameManager.EndTurn();
    }
    
    if (Input.check(Key.Z)) { // && hasFired == false
      shotPower += Config.chargeRate*HXP.elapsed;
      if (shotPower > 60) shotPower = Config.maxPower;
      HXP.log(shotPower);
    } else if (Input.released(Key.Z)) {
        hasFired = true;
        
        var xOffset:Float;
        xOffset = (dir == Facing.LEFT) ? -30 : 30;
        // 30 and 20 are offsets so bullet does not collide with body
        // in future, mask so they can't collide.
        var bullet = new BulletEntity(bodyCenter.x + xOffset, bodyCenter.y - 20, 
                                      scene, this);
        bullets.push(bullet);
        HXP.world.add(bullet);
        shotPower = 0;
    }
    
    if (Input.check(Key.UP) && !Input.check(Key.DOWN)) {
      keyHeld += HXP.elapsed;
      if (keyHeld > (1/Config.angleRate) && angle < 90) {
        angle++;
        keyHeld = 0;
      }
      
    } else if (Input.check(Key.DOWN) && !Input.check(Key.UP)) {
      keyHeld += HXP.elapsed;
      if (keyHeld > (1/Config.angleRate) && angle > 0) {
        angle--;
        keyHeld = 0;
      }
      
    } else {
      keyHeld = 0;
    }
    
    if (Input.pressed(Key.LEFT)) {
      dir = Facing.LEFT;
    } else if (Input.pressed(Key.RIGHT)) {
      dir = Facing.RIGHT;
    }
  }

  public function ResetFire() {
    hasFired = false;
  }
}
