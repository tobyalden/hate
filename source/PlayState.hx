package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import flixel.tile.FlxTile;
import openfl.Assets;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxColor;
import flixel.util.FlxPoint;
import flixel.addons.editors.ogmo.FlxOgmoLoader;

class PlayState extends FlxState
{
  public static var level:FlxTilemap;
  public static var theLight:Light;

	private var player:Player;
  private var spikes:FlxGroup;

	override public function create():Void
	{
    FlxG.mouse.visible = false;

		level = new FlxTilemap();
    var mapData:String = Assets.getText("assets/data/map.csv");
    var mapTilePath:String = "assets/images/tiles.png";
    level.loadMap(mapData, mapTilePath, 16, 16);
    level.setTileProperties(1, FlxObject.NONE);
    level.setTileProperties(2, FlxObject.ANY);
    level.setTileProperties(3, FlxObject.NONE, 6);

    spikes = new FlxGroup();
    for(rightSpike in level.getTileCoords(3, false)) {
      spikes.add(new FlxObject(rightSpike.x + 8, rightSpike.y, 8, 16));
    }
    for(floorSpike in level.getTileCoords(4, false)) {
      spikes.add(new FlxObject(floorSpike.x, floorSpike.y + 8, 16, 8));
    }
    for(leftSpike in level.getTileCoords(5, false)) {
      spikes.add(new FlxObject(leftSpike.x, leftSpike.y, 8, 16));
    }
    for(ceilSpike in level.getTileCoords(6, false)) {
      spikes.add(new FlxObject(ceilSpike.x, ceilSpike.y, 16, 8));
    }

    add(level);

		player = new Player(60, 200);
		add(player);

    theLight = new Light();
    add(theLight);

    /*FlxG.sound.playMusic("assets/music/nature.ogg", 1, true);*/

		super.create();
	}

	override public function update():Void
	{
		super.update();
		collidePlayer();
    if(FlxG.overlap(player, spikes)) {
      player.die();
    }
	}

	private function collidePlayer():Void
	{
		if(FlxG.collide(player, level) && player.inAir)
		{
			var saveY = player.y;
			if(player.isFlipped) {
				player.y = player.y - 1;
				if(FlxG.collide(player, level)) {
					player.inAir = false;
          player.landSfx.play();
				}
			}
			else {
				player.y = player.y + 1;
				if(FlxG.collide(player, level)) {
					player.inAir = false;
          player.landSfx.play();
				}
			}
			player.y = saveY;
		}
	}

	override public function destroy():Void
	{
		super.destroy();
	}

}
