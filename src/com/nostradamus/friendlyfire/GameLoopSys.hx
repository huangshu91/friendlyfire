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
  
  private var gameWorld:GameScene;
  
  public function new(world:GameScene) {
    numPlay = Config.numPlayers; 
    gameWorld = world;
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
     
    switch (currentTurn) {
      case playerOne: {
        HXP.world.getInstance("p1").update();
        id = "p1";
      }
      case playerTwo: {
        HXP.world.getInstance("p2").update();
        id = "p2";
      }
      case world: {
        endTurn();
        // Currently nothing is done here.
      }
      default:
    }
    var scene : GameScene = cast(HXP.world, GameScene);
    player = cast(HXP.world.getInstance(id), PlayerEntity);
    
    pt = player.getCenter();
    
    scene.worldCam.center(pt.x, pt.y);
    
  }
  
  public function endTurn() {

    // Change camera focus and inbetween turn logic.
    switch (currentTurn) {
      case playerOne: currentTurn = playerTwo;
      case playerTwo: currentTurn = world;
      case world: currentTurn = playerOne;
    }
  }
}
