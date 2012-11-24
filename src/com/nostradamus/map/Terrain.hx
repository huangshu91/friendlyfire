package com.nostradamus.map;

import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.display.Sprite;
import nme.Assets;
import nme.geom.Point;

import com.nostradamus.math.Vector;

class Terrain {
  private var image:Bitmap;
  private var circleMask:Bitmap;
  private var kernelSize:Int = 5;
  private var borderPixels:Array<Point>;
  private var sprite:Sprite;

  public function new(path:String) {
    image = new Bitmap(Assets.getBitmapData(path));
    circleMask = new Bitmap(Assets.getBitmapData("gfx/mask.png"));
    borderPixels = new Array<Point>();
    sprite = new Sprite();
    findBorderPixels();
    debugDraw();
    HXP.engine.addChild(image);
    HXP.engine.addChild(sprite);
  }

  public function carveCircle(x:Int, y:Int) {
    carveShape(x, y, circleMask);

    /* (adn): Empty border pixels array and recalculate border pixels.
     * findBorderPixels should be optimized because this is called whenever
     * the map changes and that should happen a lot in game.
     * Also, this could happen with in a very quick interval (think Boomer 
     * shots), so it should be fast enough to not slow anything.
     * Right now there's a very noticeable delay.
     */
    resetColors(); 
    borderPixels.splice(0, borderPixels.length); 
    findBorderPixels();
    debugDraw();
  }

  private function carveShape(x:Int, y:Int, mask:Bitmap) {
    var w = mask.bitmapData.width;
    var h = mask.bitmapData.height;
    for (i in 0...w) {
      for (j in 0...h) {
        var color:Int = mask.bitmapData.getPixel(i, j);
        if (color == 16711422) {
          image.bitmapData.setPixel32(x + i - Std.int(w/2), y + j - Std.int(h/2), 0x000000ff);
        }
      }
    }
  }

  private function debugDraw() {
    // Draw border pixels
    for (i in 0...borderPixels.length) {
      image.bitmapData.setPixel(Std.int(borderPixels[i].x), 
      Std.int(borderPixels[i].y), 0xff0000);
    }
  }
  
  private function resetColors() {
    for (i in 0...borderPixels.length) {
      image.bitmapData.setPixel(Std.int(borderPixels[i].x),
      Std.int(borderPixels[i].y), 0xfefefe);
    }
  }

  public function update() {
    if (Input.mousePressed) {
      carveCircle(Input.mouseX, Input.mouseY);
    }
  }

  public function render() {
    sprite.graphics.clear();
    // Draw normals
    var n = 0;
    while (n < borderPixels.length) {
      var x = Std.int(borderPixels[n].x);
      var y = Std.int(borderPixels[n].y);
      var normal = getNormal(x, y); 
      sprite.graphics.lineStyle(1, 0x000000);
      sprite.graphics.moveTo(x, y);
      sprite.graphics.lineTo(x + 20*normal.x, y + 20*normal.y);
      n += 25;
    }
  }

  /* (adn): Optimize this somehow since it will need to be called whenever
   * something hits the ground (border pixels need to be recalculated).
   * Possibly only recalculating border pixels on the area that was hit but
   * that means having to mess with the borderPixels array (removing the old
   * ones and adding the new ones). This can get complicated really easily...
   */
  private function findBorderPixels() {
    var counter:Int = 0;
    for (i in 1...image.bitmapData.width-1) {
      for (j in 1...image.bitmapData.height-1) {
        if (isBorderPixel(i, j)) {
          borderPixels.push(new Point(i, j));
        }
      }
    } 
  }

  public function getNormal(x:Int, y:Int) {
    var average:Vector = new Vector();

    for (i in -kernelSize...kernelSize+1) {
      for (j in -kernelSize...kernelSize+1) {
        if (isPixelSolid(x + i, y + j)) {
          average.x -= i; 
          average.y -= j;
        }
      }
    }
    return average.normalized();
  }

  private function isPixelSolid(x:Int, y:Int):Bool {
    var color:Int = image.bitmapData.getPixel(x, y);

    //need to find a better way to do this;;
    if (color == 16711422) { // white is terrain
      return true;
    } else {
      return false;
    }
  }

  /* A pixel is only a border pixel if it is solid and it has at least one
   * non-solid pixel in its 3x3 neighborhood.
   */
  private function isBorderPixel(x:Int, y:Int):Bool {
    if (isPixelSolid(x, y)) {
      for (i in -1...2) {
        for (j in -1...2) {
          if (!isPixelSolid(x + i, y + j)) {
            return true;
          }
        }
      }
    }
    return false;
  }
}
