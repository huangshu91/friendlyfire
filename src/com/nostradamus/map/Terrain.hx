package com.nostradamus.map;

import com.haxepunk.HXP;
import com.haxepunk.utils.Draw;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.Assets;
import nme.geom.Point;

import com.nostradamus.math.Vector;

class Terrain {
  private var image:Bitmap;
  private var data:BitmapData;
  private var kernelSize:Int = 3;
  private var borderPixels:Array<Point>;

  public function new(path:String) {
    image = new Bitmap(Assets.getBitmapData(path));
    borderPixels = new Array<Point>();
    findBorderPixels();
    debugDrawBorderPixels();
    HXP.engine.addChild(image);
  }

  public function calculateNormals() {

  }

  private function debugDrawBorderPixels() {
    for (i in 0...borderPixels.length) {
      image.bitmapData.setPixel(Std.int(borderPixels[i].x), 
      Std.int(borderPixels[i].y), 0xff0000);
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
    for (i in 0...image.bitmapData.width) {
      for (j in 0...image.bitmapData.height) {
        if (isBorderPixel(i, j)) {
          borderPixels.push(new Point(i, j));
        }
      }
    } 
  }

  public function getNormal(x:Int, y:Int):Vector{
    var average:Vector = new Vector();
    for (i in -kernelSize...kernelSize) {
      for (j in -kernelSize...kernelSize) {
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
      for (i in -1...1) {
        for (j in -1...1) {
          if (!isPixelSolid(x + i, y + j)) {
            return true;
          }
        }
      }
    }
    return false;
  }
}
