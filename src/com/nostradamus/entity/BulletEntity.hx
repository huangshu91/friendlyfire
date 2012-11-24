package com.nostradamus.entity;

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

  public function new(x:Float, y:Float, game:GameScene) 
  {
    super(x-bulletSize, y-bulletSize, bulletSize, game, EntityType.BULLET);
    graphic = Image.createCircle(bulletSize, 0xDDEEFF);
  }
  
}