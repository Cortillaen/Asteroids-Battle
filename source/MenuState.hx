package;

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

	override public function create():Void {
		super.create();
		FlxG.mouse.visible = true;
		add(new Asteroid(Math.floor(Math.random() * 2), Math.random() * FlxG.width, Math.random() * FlxG.height));
		add(new Asteroid(Math.floor(Math.random() * 2), Math.random() * FlxG.width, Math.random() * FlxG.height));
		add(new Asteroid(Math.floor(Math.random() * 2), Math.random() * FlxG.width, Math.random() * FlxG.height));
		add(new Asteroid(Math.floor(Math.random() * 2), Math.random() * FlxG.width, Math.random() * FlxG.height));
		add(new Asteroid(Math.floor(Math.random() * 2), Math.random() * FlxG.width, Math.random() * FlxG.height));
		add(new Asteroid(Math.floor(Math.random() * 2), Math.random() * FlxG.width, Math.random() * FlxG.height));
		var title:FlxText = new FlxText(0, 170, FlxG.width, "ASTEROID BATTLE", 55);
		title.alignment = FlxTextAlign.CENTER;
		add(title);
		var start:FlxText = new FlxText(0, 250, FlxG.width, "Start Game", 40);
		start.alignment = FlxTextAlign.CENTER;
		add(start);
		var leftShip:FlxSprite = new FlxSprite(156, 265, IMAGE);
		leftShip.color = FlxColor.BLUE;
		var rightShip:FlxSprite = new FlxSprite(460, 265, IMAGE);
		rightShip.color = FlxColor.RED;
		rightShip.angle = 180;
		add(leftShip);
		add(rightShip);
	}
	
	override public function update(elapsed:Float) {
		super.update(elapsed);
		if (FlxG.keys.anyJustReleased([FlxKey.ENTER]) || (FlxG.mouse.justReleased && FlxG.mouse.getPosition().inCoords(135, 245, 360, 60))) {
			FlxG.switchState(new PlayState());
		}
	}
}