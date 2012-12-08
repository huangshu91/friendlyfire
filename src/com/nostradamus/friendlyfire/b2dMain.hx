package com.nostradamus.friendlyfire;

import com.haxepunk.HXP;
import box2D.collision.shapes.B2PolygonShape;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2DebugDraw;
import box2D.dynamics.B2FixtureDef;
import box2D.dynamics.B2World;
import box2D.common.math.B2Vec2;
import nme.display.Sprite;

import com.nostradamus.util.Config;

/* (adn): Too sleepy, will comment more on this later.
 * Sources:
 * www.box2dflash.org/docs/2.0.2/manual 
 * http://www.emanueleferonato.com/2012/07/30/box2d-vs-nape-hello-both-worlds/
 * http://www.joshuagranick.com/blog/2011/10/28/simple-box2d-example-as3-and-haxe-side-by-side/
 * C:\Motion-Twin\haxe\lib\box2d\1,12\box2D\*
 */
class B2dMain {
  private var world:B2World;
  private var worldScale:Int;

  public function new() {
    world = new B2World(new B2Vec2(0, 5), true);
    worldScale = Config.physScale;

    var debugDraw = new B2DebugDraw();
    var physicsDebug:Sprite = new Sprite();
    HXP.engine.addChild(physicsDebug);
    debugDraw.setSprite(physicsDebug);
    debugDraw.setDrawScale(worldScale);
    debugDraw.setFlags(B2DebugDraw.e_shapeBit);
    world.setDebugDraw(debugDraw);

    CreateBox(320, 140, 160, 20, false);
    //CreateBox(310, 0, 25, 25, true);
    //CreateBox(300, 40, 25, 25, true);
    //CreateBox(290, 80, 25, 25, true);
    //CreateBox(320, 120, 25, 25, true);
  }

  public function CreateBox(x:Float=0, y:Float=0, width:Float, height:Float, dynamicBody:Bool) {
    var bodyDef:B2BodyDef = new B2BodyDef();
    bodyDef.position.set(x/worldScale, y/worldScale);

    if (dynamicBody) {
      bodyDef.type = B2Body.b2_dynamicBody;
    }
    
    var shapeDef:B2PolygonShape = new B2PolygonShape();
    shapeDef.setAsBox(width/worldScale, height/worldScale);

    var fixtureDef:B2FixtureDef = new B2FixtureDef();
    fixtureDef.shape = shapeDef;
    // fixed for now because testing
    fixtureDef.density = 1; 
    fixtureDef.friction = 0.5;
    fixtureDef.restitution = 0.5;

    var body:B2Body = world.createBody(bodyDef);
    body.createFixture(fixtureDef);
    body.resetMassData();
  }
  
  public function CreateBody(bodyDef:B2BodyDef):B2Body {
    return world.createBody(bodyDef);
  }

  public function update() {
    world.step(1/Config.frameRate, 10, 10);
    world.clearForces();
  }

  public function render() {
    world.drawDebugData();
  }
}
