package com.nostradamus.friendlyfire;

import com.haxepunk.HXP;

import com.nostradamus.util.Config;
import com.nostradamus.scene.GameScene;

/**
 * ...
 * @author maiev
 */

// Bound as in attached to something with no way to manually move x,y
class BoundCamera {
  private var cameraSpeed:Int;
  private var cameraX:Float;
  private var cameraY:Float;
  
  // (maiev): maybe unncessary
  private var camCenterX:Float;
  private var camCenterY:Float;
  
  public function new(world:GameScene) {
    cameraSpeed = Config.defaultCamSpd;
    cameraX = HXP.camera.x;
    cameraY = HXP.camera.y;
    
    camCenterY = cameraY + Config.screenHeight / 2;
    camCenterX = cameraX + Config.screenWidth / 2;
  }
  
  public function center(centerX:Float, centerY:Float) {
    /*
     * (maiev): In future we want the camera to "move" over to the
     * new location rather than teleport like this.
     */
     
    cameraX = centerX - Config.screenWidth / 2;
    cameraY = centerY - Config.screenHeight / 2;
    
    cameraX = (cameraX < 0) ? 0 : cameraX;
    cameraX = (cameraX + Config.screenWidth > Config.mapWidth) 
              ? Config.mapWidth - Config.screenWidth : cameraX;
              
    cameraY = (cameraY < 0) ? 0 : cameraY;
    cameraY = (cameraY + Config.screenHeight > Config.mapHeight) 
              ? Config.mapHeight - Config.screenHeight : cameraY;
              
    camCenterX = cameraX + Config.screenWidth / 2;
    camCenterY = cameraY + Config.screenHeight / 2;
    
    MoveCamera();
  }
  
  // (maiev): this is an alias for center in order to fit haxepunk's naming
  public function update(x:Int, y:Int) {
    center(x, y);
  }
  
  private function MoveCamera() {
    HXP.camera.x = cameraX;
    HXP.camera.y = cameraY;
  }
}
