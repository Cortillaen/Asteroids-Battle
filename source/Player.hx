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
	
	static private var FORWARDKEYS(default, never):Array<FlxKey> = [FlxKey.W];
	static private var LEFTKEYS(default, never):Array<FlxKey> = [FlxKey.A];
	static private var RIGHTKEYS(default, never):Array<FlxKey> = [FlxKey.D];
	static private var SHOOTKEYS(default, never):Array<FlxKey> = [FlxKey.CONTROL, FlxKey.SPACE];
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) {
		super(X, Y, SimpleGraphic);
		if (SimpleGraphic == null) {
			makeGraphic(20, 20);
		}
	}
	
	private function processVelocity() {
		
	}
	
	override public function update(elapsed:Float) {
		if (FlxG.keys.anyPressed(FORWARDKEYS)) {
			//acceleration.y += ACCELCHANGE;
		}
		if (FlxG.keys.anyPressed(LEFTKEYS)) {
			if (!FlxG.keys.anyPressed(RIGHTKEYS)) {
				angle -= ROTATION;
			}
		}
		else if (FlxG.keys.anyPressed(RIGHTKEYS)) {
			angle += ROTATION;
		}
		super.update(elapsed);
		//if(velocity
	}
}