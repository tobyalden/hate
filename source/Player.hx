package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Player extends FlxSprite
{
  public var speed:Float = 200;

  public function new(X:Float=0, Y:Float=0)
  {
    super(X, Y);
    loadGraphic(AssetPaths.player__png, true, 16, 24);
    setFacingFlip(FlxObject.LEFT, true, false);
    setFacingFlip(FlxObject.RIGHT, false, false);
    animation.add("run", [1, 2, 3], 6, false);
    animation.add("idle", [0], 6, false);
    drag.x = drag.y = 1600;
    setSize(16, 24);
  }

  override public function update():Void
  {
      super.update();
      movement();
  }

  private function movement():Void
  {
    var _left:Bool = false;
    var _right:Bool = false;
    _left = FlxG.keys.anyPressed(["LEFT", "A"]);
    _right = FlxG.keys.anyPressed(["RIGHT", "D"]);
    if (_left && _right) {
      _left = _right = false;
    }
    else if(_left) {
      animation.play("run");
      facing = FlxObject.LEFT;
      velocity.x = speed;
    }
    else if(_right) {
      animation.play("run");
      facing = FlxObject.RIGHT;
      velocity.x = speed;
    }
    else {
      animation.play("idle");
    }
  }

}
