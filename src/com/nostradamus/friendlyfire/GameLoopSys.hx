package com.nostradamus.friendlyfire;

import com.haxepunk.HXP;
import com.nostradamus.entity.PlayerEntity;
import nme.display.Sprite;
import nme.geom.Point;

import com.nostradamus.util.Config;
import com.nostradamus.scene.GameScene;
/**
 * ...
 * @author maiev
 */

enum TurnOrder {
  playerOne;
  playerTwo;
  world;
}

class GameLoopSys {
  private var numPlay:Int;
  private var currentTurn:TurnOrder;
  
  //(maiev): move all graphical elements to a HUD
  private var powerInd:Sprite;
  private var shotInd:Sprite;
  
  private var shotVal:Float;
  
  public function new() {
    numPlay = Config.numPlayers; 
    currentTurn = playerOne;
    powerInd = new Sprite();
    HXP.engine.addChild(powerInd);
    shotInd = new Sprite();
    HXP.engine.addChild(shotInd);
  }
  
  public function update() {
    /*
     * (maiev): for now the turn order is just 1->2->world
     * but in the future base it off speed or some other algo.
     * this is important so if its another persons turn (network)
     * then accept no input for your bot.
     */
    var pt:Point;
    var player:PlayerEntity;
    var id:String = "";
    
    var playerList:Array<PlayerEntity> = [];
    HXP.world.getClass(PlayerEntity, playerList);
    for (i in 0...playerList.length) {
      playerList[i].update();
    }
    
    switch (currentTurn) {
      case playerOne: {
        id = "p1";
        player = cast(HXP.world.getInstance(id), PlayerEntity);
        player.UpdateTurn();
        shotVal = player.shotPower;
      }
      case playerTwo: {
        id = "p2";
        player = cast(HXP.world.getInstance(id), PlayerEntity);
        player.UpdateTurn();
        shotVal = player.shotPower;
      }
      case world: {
        for (i in 0...playerList.length) {
          playerList[i].ResetFire();
        }
        EndTurn();
        return;
        // Currently nothing is done here.
      }
      default:
    }
    
    Render();
    
  }
  
  public function Render() {
    //(maiev): render hud/menus etc
    
    var xStart:Float = Config.screenWidth * Config.powerBar;
    var yStart:Float = Config.screenHeight * .1;
    var xEnd:Float = Config.screenWidth * (1 - Config.powerBar);
    
    powerInd.graphics.clear();
    powerInd.graphics.lineStyle(12, 0xFF0000);
    powerInd.graphics.moveTo(xStart, yStart);
    powerInd.graphics.lineTo(xEnd, yStart);
    
    shotInd.graphics.clear();
    shotInd.graphics.lineStyle(6, 0x00FF00);
    shotInd.graphics.moveTo(xStart, yStart);
    shotInd.graphics.lineTo(xStart+((xEnd-xStart)*(shotVal/Config.maxPower)), yStart);
    
  }
  
  public function EndTurn() {

    // Change camera focus and inbetween turn logic.
    switch (currentTurn) {
      case playerOne: currentTurn = playerTwo;
      case playerTwo: currentTurn = world;
      case world: currentTurn = playerOne;
    }
  }
}
