package;

import flixel.FlxState;
import flixel.FlxG;


class PlayState extends FlxState
{
	var _blimp : Blimp;
	
	override public function create():Void
	{
		//creates and adds a blimp to the screen
		_blimp = new Blimp(20, 20);
		add(_blimp);
		_blimp.screenCenter();
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		FlxG.sound.play("assets/sounds/effects/blimp_sound.wav");
		super.update(elapsed);
	}
}
