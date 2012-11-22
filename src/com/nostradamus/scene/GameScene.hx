package com.nostradamus.scene;

import com.haxepunk.World;
import com.haxepunk.HXP;
import com.nostradamus.entity.PlayerEntity;

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
class GameScene extends World
{
  private static var bgColor:Int = 0x63524f;
  private var entityManager:EntitySys;
  
  public function new() 
  {
    super();
  }
  
  public override function begin()
  {
    HXP.screen.color = bgColor;
    
    //hack the values for now.
    add(new PlayerEntity(HXP.halfWidth - 16, HXP.halfHeight - 16));
  }
  
  public override function update() 
  {
    
    
  }
}