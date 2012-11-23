package com.nostradamus.scene;

import com.haxepunk.World;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.Engine;

import com.nostradamus.friendlyfire.GameEngine;

/**
 * ...
 * @author maiev
 */

class MenuScene extends World {

  private static var bgColor:Int = 0x7f629f;
  
  public function new() {
    super();
  }
  
  public override function begin() {
    HXP.screen.color = bgColor;
  }
  
  public override function update() {

    // (maiev): add button entities in future with callback
    if (Input.mouseDown) {
      GameEngine.sceneManager.ChangeScene(SceneSys.gameScene);
    }
  }
}
