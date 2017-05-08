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
	static public var BLUE_SCORE:Int;
	static public var RED_SCORE:Int;
	
	override public function create():Void
	{
		super.create();
		FlxG.mouse.visible = false;
		if (BLUE_SCORE == null)
			BLUE_SCORE = 0;
		if (RED_SCORE == null)
			RED_SCORE = 0;
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
		if (gameOver) {
			if (FlxG.keys.anyPressed([FlxKey.R]))
				FlxG.switchState(new PlayState());
			else if (FlxG.keys.anyPressed([FlxKey.ENTER]))
				FlxG.switchState(new MenuState());
		}
		FlxG.overlap(players, asteroids, function(p:Player, a:Asteroid){
			if (a.impact(p)) {
				players.kill();
				if (p.team == BLUE)
					++RED_SCORE;
				else
					++BLUE_SCORE;
				var showText = new FlxText(0, 30, FlxG.width, (p.team == BLUE ? "RED" : "BLUE") + " Player Wins!\n\nPress R to restart.\nPress Enter to return to menu.", 40);
				showText.alignment = FlxTextAlign.CENTER;
				showText.addFormat(new FlxTextFormat((p.team == BLUE ? FlxColor.RED : FlxColor.BLUE), true, false, FlxColor.BLACK));
				var blueScoreText = new FlxText(100, 300, 170, "BLUE:\n" + BLUE_SCORE, 50);
				blueScoreText.alignment = FlxTextAlign.CENTER;
				blueScoreText.color = FlxColor.BLUE;
				blueScoreText.bold = true;
				var redScoreText = new FlxText(370, 300, 170, "RED:\n" + RED_SCORE, 50);
				redScoreText.alignment = FlxTextAlign.CENTER;
				redScoreText.color = FlxColor.RED;
				redScoreText.bold = true;
				gameOver = true;
				add(showText);
				add(blueScoreText);
				add(redScoreText);
			}
		});
		FlxG.overlap(bullets, asteroids, function(b:Bullet, a:Asteroid){a.impact(b); });
	}
}