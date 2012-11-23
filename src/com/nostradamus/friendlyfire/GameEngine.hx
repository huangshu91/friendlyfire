package com.nostradamus.friendlyfire;

import com.haxepunk.HXP;
import com.haxepunk.Engine;

import com.nostradamus.scene.SceneSys;
import com.nostradamus.scene.MenuScene;
import com.nostradamus.util.Config;
import com.nostradamus.math.Vector;

/**
 * ...
 * @author maiev
 */

class GameEngine extends Engine {
  public static var sceneManager:SceneSys;
  
  function new(){
    super(Config.screenWidth, Config.screenHeight, Config.frameRate, false);	
  }
	
  override public function init() {
#if debug
  #if flash
    if (flash.system.Capabilities.isDebugger)
  #end
  {
      HXP.console.enable();
  }
#end
    HXP.screen.color = Config.clearColor;
    HXP.screen.scale = 1;
    
    sceneManager = new SceneSys();
    
    sceneManager.ChangeScene(SceneSys.menuScene);
  }

  public static function main() {
    var app = new GameEngine();
  }
}
