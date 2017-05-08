package;

import flixel.group.FlxGroup;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.input.keyboard.FlxKey;

/**
 * ...
 * @author TR Nale
 */
class MenuState extends FlxState 
{
	static public var IMAGE(default, never):FlxGraphicAsset = AssetPaths.Ship__png;
	
	private var mainGroup:FlxGroup;
	private var instructionsGroup:FlxGroup;
	private var instructionsOpen:Bool;

	override public function create():Void {
		super.create();
		FlxG.mouse.visible = true;
		mainGroup = new FlxGroup();
		instructionsGroup = new FlxGroup();
		mainGroup.add(new Asteroid(Math.floor(Math.random() * 2), Math.random() * FlxG.width, Math.random() * FlxG.height));
		mainGroup.add(new Asteroid(Math.floor(Math.random() * 2), Math.random() * FlxG.width, Math.random() * FlxG.height));
		mainGroup.add(new Asteroid(Math.floor(Math.random() * 2), Math.random() * FlxG.width, Math.random() * FlxG.height));
		mainGroup.add(new Asteroid(Math.floor(Math.random() * 2), Math.random() * FlxG.width, Math.random() * FlxG.height));
		mainGroup.add(new Asteroid(Math.floor(Math.random() * 2), Math.random() * FlxG.width, Math.random() * FlxG.height));
		mainGroup.add(new Asteroid(Math.floor(Math.random() * 2), Math.random() * FlxG.width, Math.random() * FlxG.height));
		var title:FlxText = new FlxText(0, 170, FlxG.width, "ASTEROID BATTLE", 55);
		title.alignment = FlxTextAlign.CENTER;
		mainGroup.add(title);
		var start:FlxText = new FlxText(0, 250, FlxG.width, "Start Game", 40);
		start.alignment = FlxTextAlign.CENTER;
		mainGroup.add(start);
		var leftShip:FlxSprite = new FlxSprite(156, 265, IMAGE);
		leftShip.color = FlxColor.BLUE;
		var rightShip:FlxSprite = new FlxSprite(460, 265, IMAGE);
		rightShip.color = FlxColor.RED;
		rightShip.angle = 180;
		mainGroup.add(leftShip);
		mainGroup.add(rightShip);
		var instructions:FlxText = new FlxText(0, 310, FlxG.width, "Instructions", 40);
		instructions.alignment = FlxTextAlign.CENTER;
		mainGroup.add(instructions);
		add(mainGroup);
		
		var instructionText:FlxText = new FlxText(25, 25, FlxG.width - 25, "Player Blue is controlled with WASD and Ctrl or Space to shoot.\n\n" + 
			"Player Red is controlled with Numpad 8456 and 0 or Enter to shoot.\n\nYour shots do nothing to the enemy but can change asteroids " + 
			"to your color.  Colliding with an asteroid of your own color splits it into 3 smaller asteroids, but colliding with one " +
			"that is white or the enemy's color will destroy you.\n\nFight tactically and create a field of hazards for your opponent!", 22);
		instructionsGroup.add(instructionText);
		var exit:FlxText = new FlxText(0, 420, FlxG.width, "Return", 50);
		exit.alignment = FlxTextAlign.CENTER;
		instructionsGroup.add(exit);
		instructionsGroup.visible = false;
		add(instructionsGroup);
		instructionsOpen = false;
	}
	
	override public function update(elapsed:Float) {
		super.update(elapsed);
		if ((!instructionsOpen) && (FlxG.keys.anyJustReleased([FlxKey.ENTER]) || (FlxG.mouse.justReleased && FlxG.mouse.getPosition().inCoords(135, 245, 360, 60)))) {
			FlxG.switchState(new PlayState());
		}
		else if (FlxG.mouse.justReleased && FlxG.mouse.getPosition().inCoords(200, 310, 240, 50)) {
			/*forEachOfType(FlxText, function(t:FlxText){
				if ((t.y == 25) || (t.y == 420))
					t.visible = true;
				else
					t.visible = false;
			});*/
			mainGroup.visible = false;
			instructionsGroup.visible = true;
			instructionsOpen = true;
		}
		else if (FlxG.mouse.justReleased && FlxG.mouse.getPosition().inCoords(200, 430, 240, 50)) {
			/*forEachOfType(FlxText, function(t:FlxText){
				if ((t.y == 25) || (t.y == 420))
					t.visible = false;
				else
					t.visible = true;
			});*/
			mainGroup.visible = true;
			instructionsGroup.visible = false;
			instructionsOpen = false;
		}
	}
}