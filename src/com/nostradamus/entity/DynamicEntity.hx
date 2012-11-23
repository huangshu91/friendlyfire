package com.nostradamus.entity;

import nme.geom.Point;

/**
 * ...
 * @author maiev
 */

interface DynamicEntity {

  // The default Entity.centerX and centerY are for hitbox not plain loc
  private var locX:Float;
  private var locY:Float;

  function getCenter():Point;
}
