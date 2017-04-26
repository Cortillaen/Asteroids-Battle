package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxVector;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * Player object class
 * @author TRN
 */
class Player extends FlxSprite {
	//operation variables
	static private var MAXVELOCITY(default, never):Float = 50;
	static private var ACCELCHANGE(default, never):Float = 5;
	static private var ROTATION(default, never):Float = 5;
	//private var vector:
	
	private var forwardKeys:Array<FlxKey>;
	private var leftKeys:Array<FlxKey>;
	private var rightKeys:Array<FlxKey>;
	private var shootKeys:Array<FlxKey>;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) {
	public function new(?X:Float=0, ?Y:Float=0, Keys:Array<Array<FlxKey>>, ?SimpleGraphic:FlxGraphicAsset) {
		super(X, Y, SimpleGraphic);
		if (SimpleGraphic == null) {
			makeGraphic(20, 20);
		}
		forwardKeys = Keys[0];
		leftKeys = Keys[1];
		rightKeys = Keys[2];
		shootKeys = Keys[3];
	}
	
	private function processVelocity() {
		
	}
	
	override public function update(elapsed:Float) {
		if (FlxG.keys.anyPressed(FORWARDKEYS)) {
			//acceleration.y += ACCELCHANGE;
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
		if (FlxG.keys.anyPressed(LEFTKEYS)) {
			if (!FlxG.keys.anyPressed(RIGHTKEYS)) {
				angle -= ROTATION;
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