package;

import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.FlxSprite;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

/**
 * Player object class
 * @author TRN
 */
class Player extends FlxSprite {
	//operation variables
	static private var ACCEL(default, never):Float = 60;
	static private var ROTATION_RATE(default, never):Float = 3;
	static private var BULLET_OFFSET(default, never):Float = 10;
	static public var IMAGE(default, never):FlxGraphicAsset = AssetPaths.Ship__png;
	
	public var playerColor:FlxColor;
	private var forwardKeys:Array<FlxKey>;
	private var leftKeys:Array<FlxKey>;
	private var rightKeys:Array<FlxKey>;
	private var shootKeys:Array<FlxKey>;
	private var bullets:FlxTypedGroup<Bullet>;
	
	public function new(?X:Float=0, ?Y:Float=0, Keys:Array<Array<FlxKey>>, Bullets:FlxTypedGroup<Bullet>, Color:FlxColor, ?SimpleGraphic:FlxGraphicAsset) {
		super(X, Y, SimpleGraphic);
		playerColor = Color;
		if (SimpleGraphic == null) {
			loadGraphic(IMAGE, 20, 20);
		}
		color = playerColor;
		forwardKeys = Keys[0];
		leftKeys = Keys[1];
		rightKeys = Keys[2];
		shootKeys = Keys[3];
		bullets = Bullets;
		width *= 0.7;
		height *= 0.7;
		centerOffsets();
		antialiasing = true;
	}
	public function place() {
		if (playerColor == FlxColor.BLUE) {
			x = FlxG.width * .05 - 10;
			y = FlxG.height * .95 - 10;
			angle = -(Math.atan(FlxG.height / FlxG.width) / (2 * Math.PI) * 360);
		}
		else if (playerColor == FlxColor.RED) {
			x = (FlxG.width * .95) - 10;
			y = FlxG.height * .05 - 10;
			angle = 180 - (Math.atan(FlxG.height / FlxG.width) / (2 * Math.PI) * 360);
		}
	}

	private function switchSides() {
		if (x < (0 - graphic.width*1.1)) {
			x = FlxG.width + graphic.width*0.1;
		}
		else if (x > (FlxG.width + graphic.width*0.1)) {
			x = (0 - graphic.width*1.1);
		}
		if (y < (0 - graphic.height*1.1)) {
			y = FlxG.height + graphic.height*0.1;
		}
		else if (y > (FlxG.height + graphic.height*0.1)) {
			y = (0 - graphic.height*1.1);
		}
	}
	
	override public function update(elapsed:Float) {
		acceleration.set(); //defaults to 0,0
		if (FlxG.keys.anyPressed(leftKeys)) {
			if (!FlxG.keys.anyPressed(rightKeys)) {
				angle -= ROTATION_RATE;
			}
		}
		else if (FlxG.keys.anyPressed(rightKeys)) {
			angle += ROTATION_RATE;
		}
		if (FlxG.keys.anyPressed(forwardKeys)) {
			acceleration.set(ACCEL, 0);
			acceleration.rotate(FlxPoint.weak(0, 0), angle);
		}
		if (FlxG.keys.anyJustPressed(shootKeys)) {
			var blt:Bullet = bullets.recycle(Bullet);
			blt.shoot(getMidpoint(), velocity, angle, playerColor);
		}
		super.update(elapsed);
		switchSides();
	}
}