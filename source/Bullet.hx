package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import TeamType;

/**
 * ...
 * @author TRN
 */
class Bullet extends FlxSprite 
{
	static private var LENGTH(default, never):Int = 6;
	static private var WIDTH(default, never):Int = 3;
	static private var SPEED(default, never):Float = 200;
	public var bulletColor:FlxColor;

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(LENGTH, WIDTH);
		color = FlxColor.WHITE;
	}
	
	override public function update(elapsed:Float) {
		super.update(elapsed);
		AstUtil.switchSides(this);
	}
	
	public function shoot(startPoint:FlxPoint, playerVelocity:FlxPoint, direction:Float, newColor:FlxColor) {
		super.reset(startPoint.x, startPoint.y);
		angle = direction;
		
		_point.set(0, SPEED);
		_point.rotate(FlxPoint.weak(0, 0), angle-90);
		velocity.x = _point.x;
		velocity.y = _point.y;
		velocity = velocity.addPoint(playerVelocity);
		
		bulletColor = newColor;
		color = newColor;
	}
}