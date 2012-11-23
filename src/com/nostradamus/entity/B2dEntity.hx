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

  public function new(x:Float, y:Float) {
    super(x, y);
    var fixtureDef:B2FixtureDef = new B2FixtureDef();
    fixtureDef.density = 1; 
    fixtureDef.friction = 0.6;
    fixtureDef.restitution = 0.5;
    
    var bodyDef:B2BodyDef = new B2BodyDef();
    bodyDef.type = B2Body.b2_dynamicBody;
    bodyDef.position.set(x/Config.physScale, y/Config.physScale);

    // (maiev): for now the size/radius is hardcoded but we can define
    var circShape:B2CircleShape = new B2CircleShape(16 / Config.physScale);
    
    var fixtureDef:B2FixtureDef = new B2FixtureDef();
    fixtureDef.shape = circShape;
    // fixed for now because testing
    fixtureDef.density = 1; 
    fixtureDef.friction = 0.3;
    fixtureDef.restitution = 0.5;
    
    var scene:GameScene = cast(HXP.world, GameScene);
    var body:B2Body = scene.GetPhysWorld().CreateBody(bodyDef);
    body.createFixture(fixtureDef);
  }
  
}