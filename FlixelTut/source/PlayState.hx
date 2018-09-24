package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;


class PlayState extends FlxState
{
	var _blimp : Blimp;
	var fg : FlxSprite = new FlxSprite();
	var fg2 : FlxSprite = new FlxSprite();
	var mg : FlxSprite = new FlxSprite();
	var mg2 : FlxSprite = new FlxSprite();
	var sky : FlxSprite = new FlxSprite();
	var _scrollSpeed : Float = -75;
	
	override public function create():Void
	{
		//load in graphics and assign their x and y positions
		fg.loadGraphic("assets/images/Background1_Houses_640.png", false, 512, 157);
		fg2.loadGraphic("assets/images/Background1_Houses_640.png", false, 512, 157);
		mg.loadGraphic("assets/images/Background2_MidgroundHouses_640.png", false, 348, 91);
		mg2.loadGraphic("assets/images/Background2_MidgroundHouses_640.png", false, 348, 91);
		sky.loadGraphic("assets/images/Background3_BackgroundSky.png", false, 640, 245);
		add(sky);
		add(mg);
		add(mg2);
		add(fg);
		add(fg2);
		fg.x = 0;
		fg.y = 200;
		fg2.x = 640;
		fg2.y = 200;
		mg.x = 0;
		mg.y = 232;
		mg2.x = 640;
		mg2.y = 232;
		fg.velocity.set(_scrollSpeed, 0);
		fg2.velocity.set(_scrollSpeed, 0);
		mg.velocity.set(_scrollSpeed, 0);
		mg2.velocity.set(_scrollSpeed, 0);
		
		//create the blimp object and assign its position
		_blimp = new Blimp(20, 20);
		add(_blimp);
		_blimp.x = 40;
		_blimp.y = 60;
		
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
		//when backgroundX reaches 0, move background2 and middleground2 to the right side of the screen
		if (Std.int(fg.x) == 0)
		{
			fg2.x = 640;
			mg2.x = 640;
		}
		//when background2X reaches 0, move background and middleground to the right side of the screen
		if (Std.int(fg2.x) == 0)
		{
			fg.x = 640;
			mg.x = 640;
			
		}
	}
}
