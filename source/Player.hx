package;

import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.FlxSprite;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * Player object class
 * @author TRN
 */
class Player extends FlxSprite {
	//operation variables
	static private var ACCEL(default, never):Float = 60;
	static private var ROTATION_RATE(default, never):Float = 3;
	
	private var forwardKeys:Array<FlxKey>;
	private var leftKeys:Array<FlxKey>;
	private var rightKeys:Array<FlxKey>;
	private var shootKeys:Array<FlxKey>;
	
	public function new(?X:Float=0, ?Y:Float=0, Keys:Array<Array<FlxKey>>, ?SimpleGraphic:FlxGraphicAsset) {
		super(X, Y, SimpleGraphic);
		if (SimpleGraphic == null) {
			makeGraphic(20, 20);
		}
		forwardKeys = Keys[0];
		leftKeys = Keys[1];
		rightKeys = Keys[2];
		shootKeys = Keys[3];
		antialiasing = true;
		//centerOffsets();
	}
	
	private function processVelocity() {
		
	}
	
	private function switchSides() {
		if (x < -20) {
			x = 640;
		}
		else if (x > 640) {
			x = -20;
		}
		if (y < -20) {
			y = 480;
		}
		else if (y > 480) {
			y = -20;
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
		super.update(elapsed);
		switchSides();
	}
}