package;

import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	static private var P1_KEYS(default, never):Array<Array<FlxKey>> = [[FlxKey.W], [FlxKey.A], [FlxKey.D], [FlxKey.CONTROL, FlxKey.SPACE]];
	static private var P2_KEYS(default, never):Array<Array<FlxKey>> = [[FlxKey.NUMPADEIGHT], [FlxKey.NUMPADFOUR], [FlxKey.NUMPADSIX], [FlxKey.NUMPADZERO, FlxKey.ENTER]];
	public var players:FlxTypedGroup<Player>;
	public var bullets:FlxTypedGroup<Bullet>;
	public var asteroids:FlxTypedGroup<Asteroid>;
	
	override public function create():Void
	{
		super.create();
		gameOver = false;
		bullets = new FlxTypedGroup<Bullet>(5);
		players = new FlxTypedGroup<Player>(2);
		asteroids = new FlxTypedGroup<Asteroid>(30);
		players.add(new Player(P1_KEYS, bullets, FlxColor.BLUE));
		players.add(new Player(P2_KEYS, bullets, FlxColor.RED));
		asteroids.add(new Asteroid());
		asteroids.add(new Asteroid());
		asteroids.add(new Asteroid());
		add(bullets);
		add(players);
		add(asteroids);
		players.forEachOfType(Player, function(p:Player){p.place(); });
		asteroids.forEachOfType(Asteroid, function(a:Asteroid){a.place(players.members[0], players.members[1]); });
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}