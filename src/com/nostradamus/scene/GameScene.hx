package com.nostradamus.scene;

import com.haxepunk.HXP;
import com.haxepunk.World;

import com.nostradamus.entity.PlayerEntity;
import com.nostradamus.friendlyfire.BoundCamera;
import com.nostradamus.friendlyfire.GameLoopSys;
import com.nostradamus.physics.B2dMain;
import com.nostradamus.entity.EntitySys;

/**
 * ...
 * @author maiev
 */

/*
 * (maiev): 
 * For now this can will be the "game" and we put all logic here.
 * In the future, decide what map to load, add networking code, etc
 */
class GameScene extends World {
  
  private static var bgColor:Int = 0x63524f;
  private var entityManager:EntitySys;
  private var gameManager:GameLoopSys;
  private var b2d:B2dMain;
  
  public var worldCam:BoundCamera;
  
  public function new() {
    super();
    // entityManager = new EntitySys(this);
    gameManager = new GameLoopSys(this);
    worldCam = new BoundCamera(this);
    b2d = new B2dMain();
  }
  
  public override function begin() {
    HXP.screen.color = bgColor;
    
    // hack the values for now.
    add(new PlayerEntity(HXP.halfWidth - 16, HXP.halfHeight - 16, "p1"));
    add(new PlayerEntity(500, 300, "p2"));
  }
  
  public override function update() {
    b2d.update();    
  }

  public override function render() {
    super.render();
    b2d.render();
  }
  
  public function getCamera():BoundCamera {
    return worldCam;
  }
}
