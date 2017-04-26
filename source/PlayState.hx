package;

import flixel.FlxState;
import flixel.input.keyboard.FlxKey;

class PlayState extends FlxState
{
	static private var P1_KEYS(default, never):Array<Array<FlxKey>> = [[FlxKey.W], [FlxKey.A], [FlxKey.D], [FlxKey.CONTROL, FlxKey.SPACE]];
	
	override public function create():Void
	{
		super.create();
		add(new Player(200, 200, P1_KEYS));
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}