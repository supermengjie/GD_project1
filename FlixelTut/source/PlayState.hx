package;

import flixel.FlxState;
import flixel.FlxG;


class PlayState extends FlxState
{
	var _blimp : Blimp;
	
	override public function create():Void
	{
		_blimp = new Blimp(20, 20);
		add(_blimp);
		_blimp.screenCenter();
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
