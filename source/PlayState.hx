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
	
	private function setup():Void {
		forEachOfType(Player, function(p:Player){p.place(); });
		//forEachAlive(function(a:
	}
	
	override public function create():Void
	{
		super.create();
		bullets = new FlxTypedGroup<Bullet>(5);
		add(bullets);
		add(new Player(P1_KEYS, bullets, FlxColor.BLUE));
		add(new Player(P2_KEYS, bullets, FlxColor.RED));
		add(new Asteroid(0, 200, 200));
		//add(new Asteroid());
		//add(new Asteroid());
		setup();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}