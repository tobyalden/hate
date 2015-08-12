package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.tile.FlxTilemap;
import openfl.Assets;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.addons.editors.ogmo.FlxOgmoLoader;

class PlayState extends FlxState
{

  public static var level:FlxTilemap;

	private var player:Player;

	override public function create():Void
	{
    FlxG.mouse.visible = false;

		level = new FlxTilemap();
    var mapData:String = Assets.getText("assets/data/map.csv");
    var mapTilePath:String = "assets/images/tiles.png";
    level.loadMap(mapData, mapTilePath, 16, 16);
    add(level);

		player = new Player(60, 200);
		add(player);

		super.create();
	}

	override public function update():Void
	{
		super.update();
		collidePlayer();
	}

	private function collidePlayer():Void
	{
		if(FlxG.collide(player, level) && player.in_air)
		{
			var save_y = player.y;
			if(player.is_flipped) {
				player.y = player.y - 1;
				if(FlxG.collide(player, level)) {
					player.in_air = false;
          player.land_sfx.play();
				}
			}
			else {
				player.y = player.y + 1;
				if(FlxG.collide(player, level)) {
					player.in_air = false;
          player.land_sfx.play();
				}
			}
			player.y = save_y;
		}
	}

	override public function destroy():Void
	{
		super.destroy();
	}

}
