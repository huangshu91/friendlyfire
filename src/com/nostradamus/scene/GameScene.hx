package com.nostradamus.scene;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.World;
import com.haxepunk.utils.Draw;

import com.nostradamus.entity.PlayerEntity;
import com.nostradamus.entity.EntitySys;
import com.nostradamus.friendlyfire.BoundCamera;
import com.nostradamus.friendlyfire.GameLoopSys;
import com.nostradamus.friendlyfire.B2dMain;
import com.nostradamus.friendlyfire.Terrain;

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
  public var entityManager:EntitySys;
  public var gameManager:GameLoopSys;
  public var physicsWorld:B2dMain;
  public var worldCam:BoundCamera;
  
  public function new() {
    super();
    // entityManager = new EntitySys(this);
    Draw.setTarget(HXP.buffer);

    terrain = new Terrain("gfx/map.png");
    gameManager = new GameLoopSys();
    worldCam = new BoundCamera(this);
    physicsWorld = new B2dMain();
    HXP.console.enable();
  }
  
  public override function begin() {
    HXP.screen.color = bgColor;
    
    // hack the values for now.
    add(new PlayerEntity(HXP.halfWidth + 50, 100, "p1", 16, this));
    add(new PlayerEntity(500, 100, "p2", 16 , this));
  }
  
  public override function update() {
    super.update();
    terrain.update();
    physicsWorld.update();  
    gameManager.update();
  }

  public override function render() {
    super.render();
    terrain.render();
    // physicsWorld.render();
  }
}
