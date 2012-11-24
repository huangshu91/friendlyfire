package com.nostradamus.scene;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.World;

import com.nostradamus.entity.PlayerEntity;
import com.nostradamus.friendlyfire.BoundCamera;
import com.nostradamus.friendlyfire.GameLoopSys;
import com.nostradamus.physics.B2dMain;
import com.nostradamus.entity.EntitySys;
import com.nostradamus.map.Terrain;

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
  private var terrain:Terrain;
  private var entityManager:EntitySys;
  private var gameManager(GetGameManager, null):GameLoopSys;
  public var physicsWorld(GetPhysWorld, null):B2dMain;
  
  public var worldCam:BoundCamera;
  
  public function new() {
    super();
    // entityManager = new EntitySys(this);

    gameManager = new GameLoopSys();
    worldCam = new BoundCamera(this);
    physicsWorld = new B2dMain();
    terrain = new Terrain("gfx/map.png");
  }
  
  public override function begin() {
    HXP.screen.color = bgColor;
    
    // hack the values for now.
    add(new PlayerEntity(HXP.halfWidth + 50, 
        HXP.halfHeight + 50, "p1", 16, this));
    add(new PlayerEntity(500, 300, "p2", 16 , this));
    
  }
  
  public override function update() {
    super.update();
    physicsWorld.update();  
    gameManager.update();
  }

  public override function render() {
    super.render();
    physicsWorld.render();

  }
  
  public function GetCamera():BoundCamera {
    return worldCam;
  }
  
  public function GetGameManager():GameLoopSys {
    return gameManager;
  }
  
  public function GetPhysWorld():B2dMain {
    return physicsWorld;
  }
}
