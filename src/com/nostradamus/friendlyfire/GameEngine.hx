package com.nostradamus.friendlyfire;

import com.haxepunk.Engine;
import com.haxepunk.HXP;

import com.nostradamus.util.Config;

/**
 * ...
 * @author maiev
 */

class GameEngine extends Engine 
{
  function new()
  {
    super(Config.kScreenWidth, Config.kScreenHeight, Config.kFrameRate, false);	
  }
	
  override public function init()
  {
#if debug
  #if flash
    if (flash.system.Capabilities.isDebugger)
  #end
  {
      HXP.console.enable();
  }
#end
    HXP.screen.color = Config.kClearColor;
    HXP.screen.scale = 1;
//    HXP.world = new YourWorld();
  }

  public static function main()
  {
    var app = new GameEngine();
  }
}