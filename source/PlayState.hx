package;

import flixel.FlxState;

class PlayState extends FlxState
{
	override public function create():Void
	{
		super.create();
		add(new Player(200, 200));
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}