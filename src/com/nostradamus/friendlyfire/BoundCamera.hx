package com.nostradamus.friendlyfire;

import com.haxepunk.HXP;

import com.nostradamus.util.Config;

/**
 * ...
 * @author maiev
 */

class BoundCamera {
  private var cameraSpeed:Int;
  private var cameraX:Int;
  private var cameraY:Int;
  
  // (maiev): maybe unncessary
  private var camCenterX:Int;
  private var camCenterY:Int;
  
  public function new() {
    cameraSpeed = Config.defaultCamSpd;
    cameraX = HXP.camera.x;
    cameraY = HXP.camera.y;
    
    camCenterX = cameraX + Config.screenWidth;
    camCenterY = cameraY + Config.screenHeight;
  }
  
  public function center(centerX:Int, centerY:Int) {
    /*
     * (maiev): In future we want the camera to "move" over to the
     * new rather than teleport like this currently.
     */
     
    cameraX = camCenterX - Config.screenWidth / 2;
    cameraY = camCenterY - Config.screenHeight / 2;
    
    cameraX = (cameraX < 0) : 0 ? cameraX;
    cameraX = (cameraX + Config.screenWidth > Config.mapWidth) 
              : Config.mapWidth - Config.screenWidth ? cameraX;
              
    cameraY = (cameraY < 0) : 0 ? cameraY;
    cameraY = (cameraY + Config.screenHeight > Config.mapHeight) 
              : Config.mapHeight - Config.screenHeight ? cameraY;
              
    camCenterX = cameraX + Config.screenWidth;
    camCenterY = cameraY + Config.screenHeight;
    
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