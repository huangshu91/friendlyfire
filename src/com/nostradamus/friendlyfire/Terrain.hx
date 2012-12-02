package com.nostradamus.friendlyfire;

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
  private var borderPixels:Array<Array<Int>>;
  private var sprite:Sprite;
  private var xOffset:Int = -10;

  public function new(path:String) {
    image = new Bitmap(Assets.getBitmapData(path));
    image.x = xOffset;
    circleMask = new Bitmap(Assets.getBitmapData("gfx/mask.png"));
    borderPixels = new Array<Array<Int>>();
    sprite = new Sprite();
    InitializeBorderPixels(Std.int(image.bitmapData.width/2),
                           Std.int(image.bitmapData.width/2-2));
    FindBorderPixels(Std.int(image.bitmapData.width/2), 
                     Std.int(image.bitmapData.height/2), 
                     Std.int(image.bitmapData.width/2)-2, 
                     Std.int(image.bitmapData.height/2)-2);
    debugDraw();
    HXP.engine.addChild(image);
    HXP.engine.addChild(sprite);
  }

  public function carveCircle(x:Int, y:Int) {
    CarveShape(x-xOffset, y, circleMask);
    debugResetColors(); 
    /* (adn): Empty border pixels array and recalculate border pixels.
     * FindBorderPixels should be optimized because this is called whenever
     * the map changes and that should happen a lot in game.
     * Also, this could happen with in a very quick interval (think Boomer 
     * shots), so it should be fast enough to not slow anything.
     * Right now there's a very noticeable delay.
     */
    // borderPixels.splice(0, borderPixels.length); 
    FindBorderPixels(x-xOffset, y, Std.int(circleMask.width), Std.int(circleMask.height));
    debugDraw();
  }

  private function CarveShape(x:Int, y:Int, mask:Bitmap) {
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
  
  public function update() {
    if (Input.mousePressed) {
      carveCircle(Input.mouseX, Input.mouseY);
    }
  }

  public function render() {
    sprite.graphics.clear();

    /*
    // Draw normals
    var n = 0;
    while (n < borderPixels.length) {
      var x = Std.int(borderPixels[n].x);
      var y = Std.int(borderPixels[n].y);
      var normal = GetNormal(x, y); 
      sprite.graphics.lineStyle(1, 0x000000);
      sprite.graphics.moveTo(x, y);
      sprite.graphics.lineTo(x + 20*normal.x, y + 20*normal.y);
      n += 25;
    }
    */
  }

  private function debugDraw() {
    for (i in 0...borderPixels.length) {
      if (borderPixels[i] != null) {
        for (j in 0...borderPixels[i].length) {
          image.bitmapData.setPixel(i, borderPixels[i][j], 0xff0000);
        }
      }
    }
  }
  
  private function debugResetColors() {
    for (i in 0...borderPixels.length) {
      if (borderPixels[i] != null) {
        for (j in 0...borderPixels[i].length) {
          image.bitmapData.setPixel(i, borderPixels[i][j], 0xfefefe);
        }
      }
    }
  }

  private function FindBorderPixels(x:Int, y:Int, width:Int, height:Int) {
    ClearBorderPixels(x, y, width, height);
    for (i in x-width...x+width) {
      for (j in y-height...y+height) {
        if (IsBorderPixel(i, j)) {
          if (borderPixels[i] != null) {
            borderPixels[i].push(j);
          }
        }
      }
    } 
  }

  private function InitializeBorderPixels(x:Int, width:Int) {
    for (i in x-width...x+width) {
      borderPixels[i] = new Array<Int>();
    }
  }

  private function ClearBorderPixels(x:Int, y:Int, width:Int, height:Int) {
    for (i in x-width...x+width) {
      for (j in y-height...y+height) {
        if (borderPixels[i] != null) {
          borderPixels[i].remove(j);
        }
      }
    }
  }

  public function GetNormal(x:Int, y:Int) {
    var average:Vector = new Vector();

    for (i in -kernelSize...kernelSize+1) {
      for (j in -kernelSize...kernelSize+1) {
        if (IsPixelSolid(x + i, y + j)) {
          average.x -= i; 
          average.y -= j;
        }
      }
    }
    return average.normalized();
  }

  private function IsPixelSolid(x:Int, y:Int):Bool {
    var color:Int;
    if (x > 0 && x < image.bitmapData.width-0 &&
        y > 0 && y < image.bitmapData.height-0) {
      color = image.bitmapData.getPixel(x, y);
    } else {
      color = 0;
    }

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
  private function IsBorderPixel(x:Int, y:Int):Bool {
    if (IsPixelSolid(x, y)) {
      for (i in -1...2) {
        for (j in -1...2) {
          if (!IsPixelSolid(x + i, y + j)) {
            return true;
          }
        }
      }
    }
    return false;
  }
}
