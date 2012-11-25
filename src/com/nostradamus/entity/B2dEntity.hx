package com.nostradamus.entity;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import box2D.collision.shapes.B2CircleShape;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2FixtureDef;

import com.nostradamus.util.Config;
import com.nostradamus.scene.GameScene;

/**
 * ...
 * @author maiev
 */

class B2dEntity extends Entity {
  
  private var body:B2Body;
  private var scene:GameScene;
  
  private var bodyCenterX:Float;
  private var bodyCenterY:Float;
  
  private var radius:Float;

  public function new(x:Float, y:Float, size:Float,
                      game:GameScene, type:EntityType) {
    super(x, y);
    scene = game;
    
    switch (type) {
      case EntityType.PLAYER: {
        playerBody(x, y, size);
      }
      case EntityType.BULLET: {
        playerBody(x, y, size);
      }
      case EntityType.OBJECT: {
        
      }
      default:
    }
  }
  
  private function playerBody(x:Float, y:Float, size:Float) {
    bodyCenterX = (x+size) / Config.physScale;
    bodyCenterY = (y+size) / Config.physScale;
    radius = size;
    
    var bodyDef:B2BodyDef = new B2BodyDef();
    bodyDef.type = B2Body.b2_dynamicBody;
    bodyDef.position.set((x+size) / Config.physScale, (y+size) / Config.physScale);


    // (maiev): for now the size/radius is hardcoded but we can define
    var circShape:B2CircleShape = new B2CircleShape(radius / Config.physScale);
    
    var fixtureDef:B2FixtureDef = new B2FixtureDef();
    fixtureDef.shape = circShape;
    // fixed for now because testing
    fixtureDef.density = 1; 
    fixtureDef.friction = 0.9;
    fixtureDef.restitution = 0.5;
    
    body = scene.physicsWorld.CreateBody(bodyDef);
    body.createFixture(fixtureDef);
  }
 
  override public function update() {
    super.update();
    
    var newX:Float = Config.physScale * body.getPosition().x;
    var newY:Float = Config.physScale * body.getPosition().y;
    
    bodyCenterX = newX;
    bodyCenterY = newY;
  }
}
