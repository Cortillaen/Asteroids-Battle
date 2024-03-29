package;

import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.FlxSprite;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import TeamType;

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
	
	public var team:TeamType;
	private var forwardKeys:Array<FlxKey>;
	private var reverseKeys:Array<FlxKey>;
	private var leftKeys:Array<FlxKey>;
	private var rightKeys:Array<FlxKey>;
	private var shootKeys:Array<FlxKey>;
	private var bullets:FlxTypedGroup<Bullet>;
	
	public function new(?X:Float=0, ?Y:Float=0, Keys:Array<Array<FlxKey>>, Bullets:FlxTypedGroup<Bullet>, Team:TeamType, ?SimpleGraphic:FlxGraphicAsset) {
		super(X, Y, SimpleGraphic);
		team = Team;
		if (SimpleGraphic == null) {
			loadGraphic(IMAGE, 20, 20);
		}
		if (team == BLUE)
			color = 0xff0066ff;
		else
			color = 0xffff1030;
		forwardKeys = Keys[0];
		reverseKeys = Keys[1];
		leftKeys = Keys[2];
		rightKeys = Keys[3];
		shootKeys = Keys[4];
		bullets = Bullets;
		width *= 0.7;
		height *= 0.7;
		centerOffsets();
		antialiasing = true;
	}
	
	public function place() {
		if (team == BLUE) {
			x = FlxG.width * .05 - 10;
			y = FlxG.height * .95 - 10;
			angle = -(Math.atan(FlxG.height / FlxG.width) / (2 * Math.PI) * 360);
		}
		else if (team == RED) {
			x = (FlxG.width * .95) - 10;
			y = FlxG.height * .05 - 10;
			angle = 180 - (Math.atan(FlxG.height / FlxG.width) / (2 * Math.PI) * 360);
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
		if (FlxG.keys.anyPressed(reverseKeys)) {
			if (velocity.distanceTo(FlxPoint.weak()) < 10) {
				velocity.set(0, 0);
			}
			else {
				acceleration.set(-ACCEL*3, 0);
				acceleration.rotate(FlxPoint.weak(0, 0), velocity.angleBetween(FlxPoint.weak())+90);
			}
		}
		if (FlxG.keys.anyJustPressed(shootKeys)) {
			var blt:Bullet = bullets.recycle(Bullet);
			blt.shoot(getMidpoint(), velocity, angle, team);
		}
		super.update(elapsed);
		AstUtil.switchSides(this);
	}
}