package com.nostradamus.util;

/**
 * ...
 * @author maiev
 */

class Config 
{
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
}
