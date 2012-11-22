package com.nostradamus.scene;

import com.haxepunk.World;
import com.haxepunk.HXP;

/**
 * ...
 * @author maiev
 */

class GameScene extends World
{

  private static var bgColor:Int = 0x63524f;
  
  public function new() 
  {
    super();
  }
  
  public override function begin()
  {
    HXP.screen.color = bgColor;
  }
  
}