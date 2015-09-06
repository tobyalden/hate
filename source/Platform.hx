import openfl.Assets;
import flixel.*;
import flixel.tile.*;
import flixel.util.*;

class Platform extends FlxTileblock
{

  private var points:Array<FlxPoint>;

  public function new(X:Int, Y:Int, Width:Int, Height:Int)
  {
    super(X, Y, Width, Height);
    loadTiles(AssetPaths.platform__png, 8, 8);
    /*loadGraphic(AssetPaths.platform__png, false, 8, 8);*/
  }

  public function setPoints(points:Array<FlxPoint>) {
    this.points = points;
  }

  public function getPoints():Array<FlxPoint> {
    return points;
  }
}
