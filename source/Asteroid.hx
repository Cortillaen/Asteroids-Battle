package;

import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import TeamType;

/**
 * ...
 * @author TR Nale
 */
class Asteroid extends FlxSprite {
	static private var ROTATION_SPEED(default, never):Float = 10;
	static private var HITBOX_SCALE(default, never):Float = .7;
	static private var MAX_SPEED(default, never):Float = 100;
	static public var IMAGE(default, never):FlxGraphicAsset = AssetPaths.Asteroid__png;
	
	public var size:Int;

	public function new(?newSize:Int = 0,  ?X:Float = 0, ?Y:Float = 0, ?SimpleGraphic:FlxGraphicAsset) {
		super(X, Y, SimpleGraphic);
		color = FlxColor.WHITE;
		if (SimpleGraphic == null)
			loadGraphic(IMAGE, 100, 100);
		changeSize(newSize);
		antialiasing = true;
		angularVelocity = ROTATION_SPEED * Math.pow(3, size);
		velocity.set(Math.random() * MAX_SPEED, 0);
		velocity.rotate(FlxPoint.weak(0, 0), Math.random() * 360);
	}
	
	public function place(p1:Player, p2:Player) {
		var xCandidate:Float = Math.random() * FlxG.width;
		var yCandidate:Float = Math.random() * FlxG.height;
		while ((Math.abs(xCandidate - p1.x) < 50) || (Math.abs(xCandidate - FlxG.width - p1.x) < 50) || (Math.abs(xCandidate + FlxG.width - p1.x) < 50) ||
			(Math.abs(xCandidate - p2.x) < 50) || (Math.abs(xCandidate - FlxG.width - p2.x) < 50) || (Math.abs(xCandidate + FlxG.width - p2.x) < 50)) {
			xCandidate = Math.random() * FlxG.width;
		}
		while ((Math.abs(yCandidate - p1.y) < 50) || (Math.abs(yCandidate - FlxG.height - p1.y) < 50) || (Math.abs(yCandidate + FlxG.height - p1.y) < 50) ||
			(Math.abs(yCandidate - p2.y) < 50) || (Math.abs(yCandidate - FlxG.height - p2.y) < 50) || (Math.abs(yCandidate + FlxG.height - p2.y) < 50)) {
			yCandidate = Math.random() * FlxG.height;
		}
		x = xCandidate;
		y = yCandidate;
	}
	
	public function changeSize(newSize:Int) {
		size = newSize;
		scale.x /= (Math.pow(2, size));
		scale.y /= (Math.pow(2, size));
		height *= 1 / (Math.pow(2, size)) * (size == 0 ? HITBOX_SCALE : (1 - Math.pow((1 - HITBOX_SCALE), size)));
		width *= 1 / (Math.pow(2, size)) * (size == 0 ? HITBOX_SCALE : (1 - Math.pow((1 - HITBOX_SCALE), size)));
		centerOrigin();
		centerOffsets();
	}
	
	/**
	 * Treats passed point as the center of one quadrant and creates one point in each other quadrant
	 * @param	avoid	Float angle of player from asteroid
	 * @return	Array of three points
	 */
	public function getExplodePositions(avoid:Float):Array<FlxPoint> {
		var positions = new Array<FlxPoint>();
		positions.push(new FlxPoint(Math.random() * MAX_SPEED * (2 + size), 0));
		positions[0].rotate(FlxPoint.weak(0, 0), avoid + 45 + Math.random()*90);
		positions.push(new FlxPoint(Math.random() * MAX_SPEED * (2 + size), 0));
		positions[1].rotate(FlxPoint.weak(0, 0), avoid + 45 + 90*1 + Math.random()*90);
		positions.push(new FlxPoint(Math.random() * MAX_SPEED * (2 + size), 0));
		positions[2].rotate(FlxPoint.weak(0, 0), avoid + 45 + 90 * 2 + Math.random() * 90);
		return positions;
	}
	
	/**
	 * Checks what is impacting the asteroid and compares their colors.
	 * If it was a player of same color, return GREEN to indicate asteroid breaking.
	 * If it was a player of different color, return other player's color to indicate win.
	 * If it was a bullet of different color, change asteroid to that color.
	 * @param	obj
	 * @return
	 */
	public function impact(obj:FlxSprite):FlxColor {
		if (Std.is(obj, Player)) {
			if ((cast (obj, Player)).playerColor == color) {
				return FlxColor.GREEN;
			}
			else {
				obj.kill();
				if ((cast (obj, Player)).playerColor == FlxColor.RED)
					return FlxColor.BLUE;
				else
					return FlxColor.RED;
			}
		}
		else if (Std.is(obj, Bullet)) {
			if ((cast (obj, Bullet)).bulletColor != color) {
				color = (cast (obj, Bullet)).bulletColor;
				obj.kill();
			}
		}
		return FlxColor.WHITE;
	}
	
	override public function update(elapsed:Float) {
		super.update(elapsed);
		AstUtil.switchSides(this);
	}
}