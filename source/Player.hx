package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Player extends FlxSprite
{
  public var gravity:Float = 0.00067 * 1000000;
  public var terminal_velocity:Float = 0.28 * 1000;
  public var run_velocity:Float = 0.17 * 1000;
  public var jump_velocity:Float = 0.29 * 1000;
  public var jump_cancel_velocity:Float = 0.08 * 1000;

  public function new(X:Float=0, Y:Float=0)
  {
    super(X, Y);
    loadGraphic(AssetPaths.player__png, true, 16, 24);
    setFacingFlip(FlxObject.LEFT, true, false);
    setFacingFlip(FlxObject.RIGHT, false, false);
    animation.add("run", [1, 2, 3], 10, false);
    animation.add("idle", [0], 10, false);
    animation.add("jump", [4], 10, false);
    drag.x = drag.y = 1600;
    setSize(10, 24);
    offset.set(3, 0);
    /*maxVelocity.y = terminal_velocity;*/
  }

  override public function update():Void
  {
      movement();
      super.update();
  }

  private function movement():Void
  {
    var _left:Bool = false;
    var _right:Bool = false;
    var _jump:Bool = false;
    _left = FlxG.keys.anyPressed(["LEFT"]);
    _right = FlxG.keys.anyPressed(["RIGHT"]);
    _jump = FlxG.keys.justPressed.SPACE;

    var in_air:Bool = true;
    if(velocity.y == 0) {
      in_air = false;
    }

    if(_jump && !in_air) {
    	velocity.y = -jump_velocity;
    }

    if (_left && _right) {
      _left = _right = false;
    }
    else if(_left) {
      facing = FlxObject.LEFT;
      velocity.x = -run_velocity;
    }
    else if(_right) {
      facing = FlxObject.RIGHT;
      velocity.x = run_velocity;
    }
    else {
      velocity.x = 0;
    }

    acceleration.y = gravity;

    if(in_air) {
      animation.play("jump");
    }
    else if(velocity.x != 0) {
      animation.play("run");
    }
    else {
      animation.play("idle");
    }
  }

}
