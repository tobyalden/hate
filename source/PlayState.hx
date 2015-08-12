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

	private var player:Player;
  private var level:FlxTilemap;

	override public function create():Void
	{
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
		FlxG.collide(player, level);
	}

	override public function destroy():Void
	{
		super.destroy();
	}

}
