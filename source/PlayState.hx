package;

import flixel.*;
import flixel.tile.*;
import flixel.util.*;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import openfl.Assets;
import flash.system.System;

class PlayState extends FlxState
{
  public static inline var TILE_SIZE = 16;

  public static var level:FlxTilemap;
  public static var spikes:FlxGroup;
  public static var theLight:Light;
	private var player:Player;

	override public function create():Void
	{
    FlxG.mouse.visible = false;

		level = new FlxTilemap();
    var mapData:String = Assets.getText("assets/data/map.csv");
    var mapTilePath:String = "assets/images/tiles.png";
    level.loadMap(mapData, mapTilePath, TILE_SIZE, TILE_SIZE);
    level.setTileProperties(1, FlxObject.NONE);
    level.setTileProperties(2, FlxObject.ANY);
    level.setTileProperties(3, FlxObject.NONE, 6);

    spikes = new FlxGroup();
    for(rightSpike in level.getTileCoords(3, false)) {
      spikes.add(new FlxObject(rightSpike.x + TILE_SIZE/2, rightSpike.y, TILE_SIZE/2, TILE_SIZE));
    }
    for(floorSpike in level.getTileCoords(4, false)) {
      spikes.add(new FlxObject(floorSpike.x, floorSpike.y + TILE_SIZE/2, TILE_SIZE, TILE_SIZE/2));
    }
    for(leftSpike in level.getTileCoords(5, false)) {
      spikes.add(new FlxObject(leftSpike.x, leftSpike.y, TILE_SIZE/2, TILE_SIZE));
    }
    for(ceilSpike in level.getTileCoords(6, false)) {
      spikes.add(new FlxObject(ceilSpike.x, ceilSpike.y, TILE_SIZE, TILE_SIZE/2));
    }

    add(level);

		player = new Player(60, 200);
		add(player);

    for(checkpoint in level.getTileCoords(7, false)) {
      level.setTile(Math.round(checkpoint.x/TILE_SIZE), Math.round(checkpoint.y/TILE_SIZE), 1);
      add(new Checkpoint(checkpoint.x, checkpoint.y));
    }

    theLight = new Light();
    add(theLight);

    /*FlxG.sound.playMusic("assets/music/nature.ogg", 1, true);*/

		super.create();
	}

	override public function update():Void
	{
		super.update();
    if(FlxG.keys.justPressed.ESCAPE) {
      System.exit(0);
    }
	}

	override public function destroy():Void
	{
		super.destroy();
	}

}
