package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;


class PlayState extends FlxState
{
	var _blimp : Blimp;
	var _city : City;
	
	override public function create():Void
	{
		//creates and adds a blimp to the screen
		_city = new City(0, 0);
		add(_city);
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
