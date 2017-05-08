package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxAngle;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.text.FlxText;

class PlayState extends FlxState
{
	static private var P1_KEYS(default, never):Array<Array<FlxKey>> = [[FlxKey.W], [FlxKey.S], [FlxKey.A], [FlxKey.D], [FlxKey.CONTROL, FlxKey.SPACE]];
	static private var P2_KEYS(default, never):Array<Array<FlxKey>> = [[FlxKey.NUMPADEIGHT], [FlxKey.NUMPADFIVE], [FlxKey.NUMPADFOUR], [FlxKey.NUMPADSIX], [FlxKey.NUMPADZERO, FlxKey.ENTER]];
	private var gameOver:Bool;
	public var players:FlxTypedGroup<Player>;
	public var bullets:FlxTypedGroup<Bullet>;
	public var asteroids:FlxTypedGroup<Asteroid>;
	
	override public function create():Void
	{
		super.create();
		FlxG.mouse.visible = false;
		gameOver = false;
		bullets = new FlxTypedGroup<Bullet>(5);
		players = new FlxTypedGroup<Player>(2);
		asteroids = new FlxTypedGroup<Asteroid>(30);
		players.add(new Player(P1_KEYS, bullets, BLUE));
		players.add(new Player(P2_KEYS, bullets, RED));
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
		if (gameOver && FlxG.keys.anyPressed([FlxKey.R])) {
			FlxG.switchState(new MenuState());
		}
		if (asteroids.countLiving() < 3) {
			asteroids.recycle(Asteroid);
		}
		FlxG.overlap(players, asteroids, function(p:Player, a:Asteroid){
			if (a.impact(p)) {
				players.kill();
				var showText = new FlxText(0, 100, FlxG.width, (retColor == FlxColor.RED ? "RED" : "BLUE") + " Player Wins!\n\nPress R to return to menu.", 40);
				showText.alignment = FlxTextAlign.CENTER;
				showText.addFormat(new FlxTextFormat(retColor, true, false, FlxColor.BLACK));
				add(showText);
				gameOver = true;
			}
		});
		FlxG.overlap(bullets, asteroids, function(b:Bullet, a:Asteroid){a.impact(b); });
	}
}