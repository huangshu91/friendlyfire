package com.nostradamus.util;

/**
 * ...
 * @author maiev
 */

enum EntityType {
  PLAYER;
  BULLET;
  OBJECT;
}

class Config {
  /*
   * (Maiev):
   * Need to scale this for mobile versions.
   */
  public static inline var screenWidth:Int = 640;
  public static inline var screenHeight:Int = 480;
  
  public static inline var frameRate:Int = 60;
  public static inline var clearColor:Int = 0x333333;
  public static inline var projectName:String = "FriendlyFire";
  
  public static inline var defaultCamSpd:Int = 100;
  
  //(amiev): Use this for now but in future define map size 
  public static inline var mapHeight:Int = 1000;
  public static inline var mapWidth:Int = 2000;
  
  public static inline var numPlayers:Int = 2;
  
  public static inline var physScale:Int = 30;
  
  // 5 degrees per second
  public static inline var angleRate:Int = 20;
  
  // shot charge rate 20 "impulse" per second
  public static inline var chargeRate:Int = 20;
  
  // Angle indicator length of 30 px
  public static inline var angleLength:Int = 30;
  
  public static inline var maxPower:Int = 60;
  // Offset from sides of the screen
  public static inline var powerBar:Float = 0.1;

  // How many degrees in one radian
  public static inline var degInRad:Float = 57.3;
}
