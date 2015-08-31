package;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.system.FlxSound;

class Light extends FlxSprite
{
  public static inline var FLASH_TIME:Float = 0.8;
  public static var flashSfx:FlxSound;
  private var flashTimer:Float;

  public function new():Void
  {
    super();
    makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE, true);
    alpha = 0;
    flashSfx = FlxG.sound.load("assets/sounds/flash.wav");
  }

  override public function update():Void
  {
    if(flashTimer <= FlxG.elapsed)
    {
      flashTimer = 0;
      alpha = 0;
    }
    else if(flashTimer > 0)
    {
      alpha = flashTimer / FLASH_TIME;
      flashTimer = flashTimer - FlxG.elapsed;
    }
  }

  public function flash():Void
  {
    flashTimer = FLASH_TIME;
    flashSfx.play(true);
  }
}
