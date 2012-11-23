package com.nostradamus.friendlyfire;

import com.haxepunk.HXP;

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
  
  public function new(world:GameScene) {
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
    
    switch (currentTurn) {
      case playerOne: {
        HXP.world.getInstance("p1").update();
      }
      case playerTwo:
      case world:
      default:
    }
    
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
