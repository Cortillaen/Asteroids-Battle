package;

import flixel.FlxSprite;
import flixel.FlxG;

/**
 * @author TRN
 */
enum TeamType {
	RED;
	BLUE;
	NONE;
}

class AstUtil {
	static public function switchSides(obj:FlxSprite) {
		if (obj.x < (0 - 100 * obj.scale.x *1.1)) {
			obj.x = FlxG.width + 100 * obj.scale.x *0.1;
		}
		else if (obj.x > (FlxG.width + 100 * obj.scale.x *0.1)) {
			obj.x = (0 - 100 * obj.scale.x *1.1);
		}
		if (obj.y < (0 - 100 * obj.scale.y *1.1)) {
			obj.y = FlxG.height + 100 * obj.scale.y *0.1;
		}
		else if (obj.y > (FlxG.height + 100 * obj.scale.y *0.1)) {
			obj.y = (0 - 100 * obj.scale.y *1.1);
		}
	}
}