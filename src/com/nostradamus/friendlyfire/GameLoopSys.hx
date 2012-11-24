package com.nostradamus.friendlyfire;

import com.haxepunk.HXP;
import com.nostradamus.entity.PlayerEntity;
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
  
  public function new() {
    numPlay = Config.numPlayers; 
    currentTurn = playerOne;
  }
  
  public function update() {
    /*
     * (maiev): for now the turn order is just 1->2->world
     * but in the future base it off speed or some other algo.
     * this is important so if its another persons turn (network)
     * then accept no input for your bot.
     */
    var pt : Point;
    var player : PlayerEntity;
    var id : String = "";
    
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
        HXP.log("player1 turn");
      }
      case playerTwo: {
        id = "p2";
        player = cast(HXP.world.getInstance(id), PlayerEntity);
        player.UpdateTurn();
        HXP.log("player2 turn");
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
    
    var scene:GameScene = cast(HXP.world, GameScene);
    
    //pt = player.getCenter();
    
    //scene.worldCam.center(pt.x, pt.y);
    
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
