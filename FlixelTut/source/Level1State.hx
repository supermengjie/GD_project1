package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxTimer;
import flixel.FlxObject;

class Level1State extends FlxState
{
	var _blimp : Blimp;
	var _insults:FlxTypedGroup<Insult>;
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
	var spawn : FlxTimer = new FlxTimer();
	public var _birdsArray:FlxTypedGroup<Birds>;

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


		_insults = new FlxTypedGroup<Insult>();
		add(_insults);
		
		//create the blimp object and assign its position
		_blimp = new Blimp(20, 20, _insults);
		add(_blimp);
		_blimp.x = 40;
		_blimp.y = 60;

		_birdsArray= new FlxTypedGroup<Birds>();
		add(_birdsArray);

		spawn.start(FlxG.random.float(1.0, 2.0), birdSpawner, 0);
		
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
		FlxG.overlap(_insults, _birdsArray, null, collide);
		FlxG.overlap(_blimp, _birdsArray, null, collide);

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

	function birdSpawner(Timer:FlxTimer):Void
	{
		//spawns birds
		var _bird : Birds;
		_bird = new Birds(FlxG.random.int(640, 860), 300, "flock");
		add(_bird);
		_birdsArray.add(_bird);
		_bird.velocity.set(_scrollSpeed, 0);
	}


	private function collide(Sprite1:FlxObject, Sprite2:FlxObject):Bool
	{
		var sprite1Class:String = Type.getClassName(Type.getClass(Sprite1));
		var sprite2Class:String = Type.getClassName(Type.getClass(Sprite2));
		if (sprite1Class == "Insult" && sprite2Class == "Birds")
		{
				var s1: Dynamic = cast(Sprite1, Insult);
				var s2: Dynamic = cast(Sprite2, Birds);
				if (s2.status()==false){
				_insults.remove(s1);
				s2.velocity.set(200, -100);
				s2.gotHit();
				/*if (s2.x>620 && s2.y<190)
				{
					trace("out");
					s2.velocity.set( -100, 0);
				}
				//removes it if it's off the screen
				if (s2.x < 0) 
				{
					trace("kill");
					s2.kill();
				}	*/

				s1.destroy();
				
			}
			return true;

		}

		if (sprite1Class == "Blimp" && sprite2Class == "Birds")
		{
			var s1: Dynamic = cast(Sprite1, Blimp);
			var s2: Dynamic = cast(Sprite2, Birds);
			s2.dead();
			//s2.detroy();
			return true;
		}

		return false;

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
