import openfl.Assets;
import flixel.*;

class Checkpoint extends FlxSprite
{
  public function new(X:Float=0, Y:Float=0)
  {
    super(X, Y);
    loadGraphic(AssetPaths.checkpoint__png, true, 16, 16);
    animation.add("idle", [0, 1, 2, 3, 2, 1], 10, false);
    animation.add("flash", [4, 5, 6], 13, false);
  }

  override public function update():Void
  {
    super.update();

    if(FlxG.overlap(this, PlayState.player) && PlayState.player.isInteracting) {
      PlayState.lastCheckpoint = this;
      animation.play("flash", true);
      Light.flashSfx.play(true);
      PlayState.player.isInteracting = false;
      trace("Game saved.");
    }
    else if(animation.finished) {
      animation.play("idle");
    }
  }

}
