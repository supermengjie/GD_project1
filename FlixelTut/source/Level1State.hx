package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;


class Level1State extends FlxState
{
	var _blimp : Blimp;
	var fg : FlxSprite = new FlxSprite();
	var fg2 : FlxSprite = new FlxSprite();
	var mg : FlxSprite = new FlxSprite();
	var mg2 : FlxSprite = new FlxSprite();
	var sky : FlxSprite = new FlxSprite();
	var timer : FlxSprite = new FlxSprite();
	var timerBG : FlxSprite = new FlxSprite();
	var brightGreen : FlxColor = new FlxColor(0x00ff00);
	var curScale : Float = 1;
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
		
		timerBG.makeGraphic(75, 10, FlxColor.BLACK);
		timerBG.x = 550;
		timerBG.y = 15;
		add(timerBG);
		
		timer.makeGraphic(75, 10, FlxColor.LIME);
		timer.x = 550;
		timer.y = 15;
		add(timer);
		
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		FlxG.sound.play("assets/sounds/effects/blimp_sound.wav");
		scroll();
		if (FlxG.keys.justPressed.B){
			decreaseTimer();
		}
		if (FlxG.keys.justPressed.N){
			increaseTimer();
		}
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
	
	//if insult is shot decrease width of the timer and update hitbox
	function decreaseTimer():Void
	{
		if(curScale - .2 <= 0){
			curScale = 0;
		}
		else{
			curScale -= .2;
		}
		
		timer.scale.set(curScale, 1);
		timer.updateHitbox();
	}
	
	//if bird is destroyed increase width of timer and update hitbox
	function increaseTimer():Void
	{
		curScale += .1;
		timer.scale.set(curScale, 1);
		timer.updateHitbox();
	}
}
