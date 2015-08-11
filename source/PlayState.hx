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

	private var _player:Player;
  private var level:FlxTilemap;

	override public function create():Void
	{
		level = new FlxTilemap();
    var mapData:String = Assets.getText("assets/data/map.csv");
    var mapTilePath:String = "assets/images/tiles.png";
    level.loadMap(mapData, mapTilePath, 16, 16);
    add(level);

		_player = new Player(20, 20);
		add(_player);

		super.create();
	}

	override public function update():Void
	{
		super.update();
		trace(FlxG.collide(_player, level));
	}

	override public function destroy():Void
	{
		super.destroy();
	}

}
