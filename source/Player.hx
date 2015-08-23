package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import openfl.Assets;

class Player extends FlxSprite
{
  public var landSfx:FlxSound;
  private var runSfx:FlxSound;
  private var jumpSfx:FlxSound;
  private var flipSfx:FlxSound;
  private var cantFlipSfx:FlxSound;

  private var gravity:Float = 0.00067 * 1000 * 1000;
  private var terminalVelocity:Float = 0.28 * 1000;
  private var runVelocity:Float = 0.17 * 1000;
  private var jumpVelocity:Float = 0.29 * 1000;
  private var jumpCancelVelocity:Float = 0.08 * 1000;

  public var inAir:Bool;
  public var isFlipped:Bool;

  private var jumpKeyPrev:Bool;
  private var canFlip:Bool;

  public function new(X:Float=0, Y:Float=0)
  {
    super(X, Y);
    loadGraphic(AssetPaths.player__png, true, 16, 24);
    setFacingFlip(FlxObject.LEFT, true, false);
    setFacingFlip(FlxObject.RIGHT, false, false);
    animation.add("run", [1, 2, 3, 2], 10, false);
    animation.add("idle", [0], 10, false);
    animation.add("jump", [4], 10, false);

    runSfx = FlxG.sound.load("assets/sounds/run1.wav");
    jumpSfx = FlxG.sound.load("assets/sounds/jump.wav");
    landSfx = FlxG.sound.load("assets/sounds/drop3.wav");
    flipSfx = FlxG.sound.load("assets/sounds/whoosh.wav");
    cantFlipSfx = FlxG.sound.load("assets/sounds/no.wav");

    setSize(10, 24);
    offset.set(3, 0);
    jumpKeyPrev = false;
    canFlip = true;
    inAir = true;
  }

  override public function update():Void
  {
    movement();
    super.update();
  }

  private function movement():Void
  {
    var delta = FlxG.elapsed * 1000;
    var leftKey:Bool = FlxG.keys.anyPressed(["LEFT"]);
    var rightKey:Bool = FlxG.keys.anyPressed(["RIGHT"]);
    var jumpKey:Bool = FlxG.keys.anyPressed(["SPACE", "Z"]);
    var jumpKeyJust:Bool = FlxG.keys.justPressed.SPACE || FlxG.keys.justPressed.Z;
    var flipKeyJust:Bool = FlxG.keys.justPressed.X;

    if(velocity.y != 0) {
      inAir = true;
    }

    if(!inAir) {
      canFlip = true;
    }

    if(jumpKeyJust && !inAir) {
      if(isFlipped) {
        velocity.y = jumpVelocity;
      }
      else {
      	velocity.y = -jumpVelocity;
      }
      jumpSfx.play();
    }
    else if(jumpKeyPrev && !jumpKey) {
      if(isFlipped && velocity.y > jumpCancelVelocity) {
        velocity.y = jumpCancelVelocity;
      }
      else if (!isFlipped && velocity.y < -jumpCancelVelocity)
			{
				velocity.y = -jumpCancelVelocity;
			}
    }

    if(flipKeyJust) {
      if(canFlip) {
        isFlipped = !isFlipped;
        canFlip = false;
        flipSfx.play();
      }
      else {
        cantFlipSfx.play();
      }
    }

    if(!isFlipped && velocity.y > terminalVelocity) {
      velocity.y = terminalVelocity;
    }
    else if(isFlipped && velocity.y < -terminalVelocity) {
      velocity.y = -terminalVelocity;
    }

    if (leftKey && rightKey) {
      leftKey = rightKey = false;
    }
    else if(leftKey) {
      facing = FlxObject.LEFT;
      velocity.x = -runVelocity;
    }
    else if(rightKey) {
      facing = FlxObject.RIGHT;
      velocity.x = runVelocity;
    }
    else {
      velocity.x = 0;
    }

    if(isFlipped) {
      acceleration.y = -gravity;
    }
    else {
      acceleration.y = gravity;
    }

    if(inAir) {
      animation.play("jump");
      runSfx.stop();
    }
    else if(velocity.x != 0) {
      animation.play("run");
      runSfx.play();
    }
    else {
      animation.play("idle");
      runSfx.stop();
    }

    if(isFlipped) {
      flipY = true;
    }
    else {
      flipY = false;
    }

    jumpKeyPrev = jumpKey;
  }

  public function die():Void
  {
    x = 60;
    y = 200;
    PlayState.theLight.flash();
  }

}
