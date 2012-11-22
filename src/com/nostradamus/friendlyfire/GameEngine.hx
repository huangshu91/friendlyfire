package com.nostradamus.friendlyfire;

import com.haxepunk.Engine;
import com.haxepunk.HXP;
import com.nostradamus.scene.SceneSys;

import com.nostradamus.util.Config;
import com.nostradamus.scene.MenuScene;

/**
 * ...
 * @author maiev
 */

class GameEngine extends Engine 
{
  public static var sceneManager:SceneSys;
  
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
    
    sceneManager = new SceneSys();
    
    sceneManager.ChangeScene(SceneSys.menuScene);
  }

  public static function main()
  {
    var app = new GameEngine();
  }
}