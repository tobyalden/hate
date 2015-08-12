package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import openfl.Assets;

class Player extends FlxSprite
{

  public var land_sfx:FlxSound;
  private var run_sfx:FlxSound;
  private var jump_sfx:FlxSound;
  private var flip_sfx:FlxSound;
  private var cant_flip_sfx:FlxSound;

  private var gravity:Float = 0.00067 * 1000 * 1000;
  private var terminal_velocity:Float = 0.28 * 1000;
  private var run_velocity:Float = 0.17 * 1000;
  private var jump_velocity:Float = 0.29 * 1000;
  private var jump_cancel_velocity:Float = 0.08 * 1000;

  public var in_air:Bool;
  public var is_flipped:Bool;

  private var jump_key_prev:Bool;
  private var can_flip:Bool;

  public function new(X:Float=0, Y:Float=0)
  {
    super(X, Y);
    loadGraphic(AssetPaths.player__png, true, 16, 24);
    setFacingFlip(FlxObject.LEFT, true, false);
    setFacingFlip(FlxObject.RIGHT, false, false);
    animation.add("run", [1, 2, 3, 2], 10, false);
    animation.add("idle", [0], 10, false);
    animation.add("jump", [4], 10, false);

    run_sfx = FlxG.sound.load("assets/sounds/run1.wav");
    jump_sfx = FlxG.sound.load("assets/sounds/jump.wav");
    land_sfx = FlxG.sound.load("assets/sounds/drop3.wav");
    flip_sfx = FlxG.sound.load("assets/sounds/whoosh.wav");
    cant_flip_sfx = FlxG.sound.load("assets/sounds/no.wav");

    setSize(10, 24);
    offset.set(3, 0);
    jump_key_prev = false;
    can_flip = true;
    in_air = true;
  }

  override public function update():Void
  {
    movement();
    super.update();
  }

  private function movement():Void
  {
    var delta = FlxG.elapsed * 1000;
    var left_key:Bool = FlxG.keys.anyPressed(["LEFT"]);
    var right_key:Bool = FlxG.keys.anyPressed(["RIGHT"]);
    var jump_key:Bool = FlxG.keys.anyPressed(["SPACE", "Z"]);
    var jump_key_just:Bool = FlxG.keys.justPressed.SPACE || FlxG.keys.justPressed.Z;
    var flip_key_just:Bool = FlxG.keys.justPressed.X;

    if(velocity.y != 0) {
      in_air = true;
    }

    if(!in_air) {
      can_flip = true;
    }

    if(jump_key_just && !in_air) {
      if(is_flipped) {
        velocity.y = jump_velocity;
      }
      else {
      	velocity.y = -jump_velocity;
      }
      jump_sfx.play();
    }
    else if(jump_key_prev && !jump_key) {
      if(is_flipped && velocity.y > jump_cancel_velocity) {
        velocity.y = jump_cancel_velocity;
      }
      else if (!is_flipped && velocity.y < -jump_cancel_velocity)
			{
				velocity.y = -jump_cancel_velocity;
			}
    }

    if(flip_key_just) {
      if(can_flip) {
        is_flipped = !is_flipped;
        can_flip = false;
        flip_sfx.play();
      }
      else {
        cant_flip_sfx.play();
      }
    }

    if(!is_flipped && velocity.y > terminal_velocity) {
      velocity.y = terminal_velocity;
    }
    else if(is_flipped && velocity.y < -terminal_velocity) {
      velocity.y = -terminal_velocity;
    }

    if (left_key && right_key) {
      left_key = right_key = false;
    }
    else if(left_key) {
      facing = FlxObject.LEFT;
      velocity.x = -run_velocity;
    }
    else if(right_key) {
      facing = FlxObject.RIGHT;
      velocity.x = run_velocity;
    }
    else {
      velocity.x = 0;
    }

    if(is_flipped) {
      acceleration.y = -gravity;
    }
    else {
      acceleration.y = gravity;
    }

    if(in_air) {
      animation.play("jump");
      run_sfx.stop();
    }
    else if(velocity.x != 0) {
      animation.play("run");
      run_sfx.play();
    }
    else {
      animation.play("idle");
      run_sfx.stop();
    }

    if(is_flipped) {
      flipY = true;
    }
    else {
      flipY = false;
    }

    jump_key_prev = jump_key;
  }

}
