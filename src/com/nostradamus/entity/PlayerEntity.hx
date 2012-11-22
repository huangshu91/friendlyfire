package com.nostradamus.entity;

import com.haxepunk.graphics.Image;
import com.haxepunk.Entity;

/**
 * ...
 * @author maiev
 */

class PlayerEntity extends Entity, implements DynamicEntity
{

  public function new(x:Float, y:Float) 
  {
    super(x, y);
    graphic = Image.createRect(32, 32, 0xDDEEFF);
  }
  
}