package;

import flixel.*;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import openfl.Assets;

class Player extends FlxSprite
{
  public static inline var RESPAWN_TIME:Float = 320 / 1000;

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
  public var isInteracting:Bool;

  public var isRespawning:Bool;
  public var respawnTimer:Float;

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
    isInteracting = false;
    isRespawning = false;
    respawnTimer = 0;
  }

  override public function update():Void
  {
    super.update();
    collide();
    if(isRespawning) {
      respawnTimer -= FlxG.elapsed;
      if(respawnTimer <= 0) {
        isRespawning = false;
      }
    }
    else {
      movement();
    }
  }

  private function movement():Void
  {
    var delta = FlxG.elapsed * 1000;
    var leftKey:Bool = FlxG.keys.anyPressed(["LEFT"]);
    var rightKey:Bool = FlxG.keys.anyPressed(["RIGHT"]);
    // maybe if downKey && downKeyJust set isInteracting = true?
    var downKey:Bool = FlxG.keys.anyPressed(["DOWN"]);
    var downKeyJust:Bool = FlxG.keys.justPressed.DOWN;
    var jumpKey:Bool = FlxG.keys.anyPressed(["SPACE", "Z"]);
    var jumpKeyJust:Bool = FlxG.keys.justPressed.SPACE || FlxG.keys.justPressed.Z;
    var flipKeyJust:Bool = FlxG.keys.justPressed.X;

    if(velocity.y != 0) {
      inAir = true;
    }

    if(!inAir) {
      canFlip = true;
    }

    if(downKey && downKeyJust) {
      isInteracting = true;
    }

    if(!downKey) {
      isInteracting = false;
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

  private function collide():Void
  {
    FlxG.collide(this, PlayState.level);
    var feetCollider:FlxObject;
    if(isFlipped) {
      feetCollider = new FlxObject(x, y - 1, width, 1);
    }
    else {
      feetCollider = new FlxObject(x, y + height, width, 1);
    }
    if(PlayState.level.overlaps(feetCollider)) {
      if(inAir == true) {
        landSfx.play();
      }
      inAir = false;
    }
    if(FlxG.overlap(this, PlayState.spikes)) {
      die();
    }
  }

  public function die():Void
  {
    isRespawning = true;
    respawnTimer = RESPAWN_TIME;
    x = PlayState.lastCheckpoint.x + offset.x;
    isFlipped = PlayState.lastCheckpoint.isFlipped;
    if(isFlipped) {
      y = PlayState.lastCheckpoint.y;
      trace(PlayState.lastCheckpoint.y);
    }
    else {
      y = PlayState.lastCheckpoint.y - (height - PlayState.lastCheckpoint.height);
    }
    PlayState.theLight.flash();
    animation.play("idle");
    inAir = false;
    runSfx.stop();
    velocity.x = 0;
    velocity.y = 0;
    acceleration.x = 0;
    acceleration.y = 0;
  }

}
