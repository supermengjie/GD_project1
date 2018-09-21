package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;


class PlayState extends FlxState
{
	var _blimp : Blimp;
	var bg : FlxSprite = new FlxSprite();
	var bg2 : FlxSprite = new FlxSprite();
	var _scrollSpeed : Float = -300;
	var looped : Bool = false;
	var looped2 : Bool = false;
	
	override public function create():Void
	{
		bg.loadGraphic("assets/images/bg-test.png", false, 1280, 480);
		bg2.loadGraphic("assets/images/bg-test.png", false, 1280, 480);
		add(bg);
		add(bg2);
		bg2.x = 640;
		bg.velocity.set(_scrollSpeed, 0);
		_blimp = new Blimp(20, 20);
		add(_blimp);
		_blimp.screenCenter();
		
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		FlxG.sound.play("assets/sounds/effects/blimp_sound.wav");
		scroll();
		super.update(elapsed);
	}
	
	function scroll():Void
	{
		//if the background X is at -640 add background2 to the right edge of the screen and add velocity
		if (Std.int(bg.x) == -640 && !looped)
		{
			bg2.x = 640;
			bg2.velocity.set(_scrollSpeed, 0);
			trace("duplicating");
			trace("bgX: ", bg.x);
			looped = true;
			looped2 = false;
		}
		//if the background2 X is at -640 add background to the right edge of the screen and add velocity
		if (Std.int(bg2.x) == -640 && !looped2)
		{
			bg.x = 640;
			bg.velocity.set(_scrollSpeed, 0);
			trace("duplicating2");
			trace("bg2X: ", bg2.x);
			looped2 = true;
			looped = false;
			
		}
		//stop the background from moving once it is off the screen
		if (Std.int(bg.x) == -1281){
			bg.velocity.set(0, 0);
		}
		//stop background2 from moving once it is off the screen
		if (Std.int(bg2.x) == -1281){
			bg2.velocity.set(0, 0);
		}
	}
}
