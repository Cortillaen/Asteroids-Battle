package;

import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	static private var P1_KEYS(default, never):Array<Array<FlxKey>> = [[FlxKey.W], [FlxKey.A], [FlxKey.D], [FlxKey.CONTROL, FlxKey.SPACE]];
	static private var P2_KEYS(default, never):Array<Array<FlxKey>> = [[FlxKey.NUMPADEIGHT], [FlxKey.NUMPADFOUR], [FlxKey.NUMPADSIX], [FlxKey.NUMPADZERO, FlxKey.ENTER]];
	public var bullets:FlxTypedGroup<Bullet>;
	
	override public function create():Void
	{
		super.create();
		bullets = new FlxTypedGroup<Bullet>(5);
		add(bullets);
		add(new Player(200, 200, P1_KEYS, bullets, FlxColor.BLUE));
		add(new Player(400, 200, P2_KEYS, bullets, FlxColor.RED));
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}