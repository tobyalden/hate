package lime;


import lime.utils.Assets;


class AssetData {

	private static var initialized:Bool = false;
	
	public static var library = new #if haxe3 Map <String, #else Hash <#end LibraryType> ();
	public static var path = new #if haxe3 Map <String, #else Hash <#end String> ();
	public static var type = new #if haxe3 Map <String, #else Hash <#end AssetType> ();	
	
	public static function initialize():Void {
		
		if (!initialized) {
			
			path.set ("assets/data/map.csv", "assets/data/map.csv");
			type.set ("assets/data/map.csv", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/data/project.tmx", "assets/data/project.tmx");
			type.set ("assets/data/project.tmx", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/images/checkpoint.png", "assets/images/checkpoint.png");
			type.set ("assets/images/checkpoint.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/objects.png", "assets/images/objects.png");
			type.set ("assets/images/objects.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/player.png", "assets/images/player.png");
			type.set ("assets/images/player.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/tiles.png", "assets/images/tiles.png");
			type.set ("assets/images/tiles.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/music/nature.ogg", "assets/music/nature.ogg");
			type.set ("assets/music/nature.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/beat.wav", "assets/sounds/beat.wav");
			type.set ("assets/sounds/beat.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/delicate.wav", "assets/sounds/delicate.wav");
			type.set ("assets/sounds/delicate.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/drop3.wav", "assets/sounds/drop3.wav");
			type.set ("assets/sounds/drop3.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/flash.wav", "assets/sounds/flash.wav");
			type.set ("assets/sounds/flash.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/grassdrop.wav", "assets/sounds/grassdrop.wav");
			type.set ("assets/sounds/grassdrop.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/grassjump.wav", "assets/sounds/grassjump.wav");
			type.set ("assets/sounds/grassjump.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/grassrun.wav", "assets/sounds/grassrun.wav");
			type.set ("assets/sounds/grassrun.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/jump.wav", "assets/sounds/jump.wav");
			type.set ("assets/sounds/jump.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/laser.wav", "assets/sounds/laser.wav");
			type.set ("assets/sounds/laser.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/next.wav", "assets/sounds/next.wav");
			type.set ("assets/sounds/next.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/no.wav", "assets/sounds/no.wav");
			type.set ("assets/sounds/no.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/pickup.wav", "assets/sounds/pickup.wav");
			type.set ("assets/sounds/pickup.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/run1.wav", "assets/sounds/run1.wav");
			type.set ("assets/sounds/run1.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/shift.wav", "assets/sounds/shift.wav");
			type.set ("assets/sounds/shift.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/switch_off.wav", "assets/sounds/switch_off.wav");
			type.set ("assets/sounds/switch_off.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/switch_on.wav", "assets/sounds/switch_on.wav");
			type.set ("assets/sounds/switch_on.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/whoosh.wav", "assets/sounds/whoosh.wav");
			type.set ("assets/sounds/whoosh.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/beep.ogg", "assets/sounds/beep.ogg");
			type.set ("assets/sounds/beep.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/flixel.ogg", "assets/sounds/flixel.ogg");
			type.set ("assets/sounds/flixel.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/fonts/nokiafc22.ttf", "assets/fonts/nokiafc22.ttf");
			type.set ("assets/fonts/nokiafc22.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			path.set ("assets/fonts/arial.ttf", "assets/fonts/arial.ttf");
			type.set ("assets/fonts/arial.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			
			
			initialized = true;
			
		} //!initialized
		
	} //initialize
	
	
} //AssetData
