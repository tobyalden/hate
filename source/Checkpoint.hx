import openfl.Assets;
import flixel.*;

class Checkpoint extends FlxSprite
{
  public function new(X:Float=0, Y:Float=0)
  {
    super(X, Y);
    loadGraphic(AssetPaths.checkpoint__png, true, 16, 16);
    animation.add("idle", [0, 1, 2, 3, 2, 1], 10, false);
    animation.add("flash", [4, 5, 6], 10, false);
  }

  override public function update():Void
  {
    super.update();
    animation.play("idle");
  }

}
