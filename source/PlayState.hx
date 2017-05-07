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
	static private var P1_KEYS(default, never):Array<Array<FlxKey>> = [[FlxKey.W], [FlxKey.A], [FlxKey.D], [FlxKey.CONTROL, FlxKey.SPACE]];
	static private var P2_KEYS(default, never):Array<Array<FlxKey>> = [[FlxKey.NUMPADEIGHT], [FlxKey.NUMPADFOUR], [FlxKey.NUMPADSIX], [FlxKey.NUMPADZERO, FlxKey.ENTER]];
	private var gameOver:Bool;
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
		if (gameOver && FlxG.keys.anyPressed([FlxKey.R])) {
			FlxG.switchState(new MenuState());
		}
		if (asteroids.countLiving() < 3) {
			asteroids.recycle(Asteroid);
		}
		FlxG.overlap(players, asteroids, function(p:Player, a:Asteroid){
			var retColor:FlxColor = a.impact(p);
			if (retColor == FlxColor.GREEN) {
				//create spawn points for new asteroids that avoid the player
				var spawnPoints:Array<FlxPoint> = a.getExplodePositions(FlxAngle.angleBetween(a, p, true));
				var tempAst:Asteroid;
				for (point in spawnPoints) {
					tempAst = asteroids.recycle(Asteroid);
					tempAst.velocity.copyFrom(point);
					point.scale(40 / point.distanceTo(FlxPoint.weak()));
					tempAst.x = a.x + point.x;
					tempAst.y = a.y + point.y;
					tempAst.color = a.color;
					tempAst.changeSize(a.size + 1);
				}
				a.kill();
			}
			else if (retColor == FlxColor.WHITE) {
				//nothing happens
			}
			else { //game over
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