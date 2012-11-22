package com.nostradamus.scene;

import com.haxepunk.HXP;
/**
 * ...
 * @author maiev
 */

/* (maiev): will work on it later.
 * This class is a state machine that will manage switching between scenes.
 * Any scene can call a switch function that will allow the manager to
 * detach the current scene and attach the next scene.
 */
class SceneSys 
{
  public static inline var menuScene:Int = 1;
  public static inline var gameScene:Int = 2;
  
  public function new() 
  {
    // Do nothing?
  }
  
  public function ChangeScene(scene:Int) {
    switch (scene) {
      case menuScene:
        HXP.world = new MenuScene();
      case gameScene:
        HXP.world = new GameScene();
      default:
    }
  }
}