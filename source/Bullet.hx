package;

import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

/**
 * ...
 * @author TRN
 */
class Bullet extends FlxSprite 
{
	static private var BULLET_SPEED:Float = 200;
	public var bulletColor:FlxColor;

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(5, 2);
		color = FlxColor.WHITE;
	}
	
	public function shoot(startPoint:FlxPoint, direction:Float, newColor:FlxColor) {
		super.reset(startPoint.x, startPoint.y);
		angle = direction;
		
		_point.set(0, BULLET_SPEED);
		_point.rotate(FlxPoint.weak(0, 0), angle-90);
		velocity.x = _point.x;
		velocity.y = _point.y;
		
		bulletColor = newColor;
		color = newColor;
	}
}