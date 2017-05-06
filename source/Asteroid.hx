package;

import flash.text.TextFieldAutoSize;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

/**
 * ...
 * @author TR Nale
 */
class Asteroid extends FlxSprite 
{
	static private var ROTATION_SPEED(default, never):Float = 20;
	static private var HITBOX_SCALE(default, never):Float = .7;
	static public var IMAGE(default, never):FlxGraphicAsset = AssetPaths.Asteroid__png;
	
	public var size:Int;
	public var astColor:FlxColor;

	public function new(?Size:Int = 0,  ?X:Float = 0, ?Y:Float = 0, ?SimpleGraphic:FlxGraphicAsset) {
		super(X, Y, SimpleGraphic);
		astColor = FlxColor.
		if (SimpleGraphic == null)
			loadGraphic(IMAGE, 100, 100);
		size = Size;
		scale.x /= (Math.pow(2, size));
		scale.y /= (Math.pow(2, size));
		height *= 1 / (Math.pow(2, size)) * HITBOX_SCALE;
		width *= 1 / (Math.pow(2, size)) * HITBOX_SCALE;
		centerOrigin();
		centerOffsets();
		angularVelocity = ROTATION_SPEED;
	}
	
}