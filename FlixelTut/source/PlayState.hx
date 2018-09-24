package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxTimer;
import flixel.FlxObject;

class PlayState extends FlxState
{
	var _blimp : Blimp;
	var _insults:FlxTypedGroup<Insult>;
	var bg : FlxSprite = new FlxSprite();
	var bg2 : FlxSprite = new FlxSprite();
	var _scrollSpeed : Float = -300;
	var looped : Bool = false;
	var looped2 : Bool = false;
	var spawn : FlxTimer = new FlxTimer();
	public var _birdsArray:FlxTypedGroup<Birds>;

	override public function create():Void
	{
		bg.loadGraphic("assets/images/bg-test.png", false, 1280, 480);
		bg2.loadGraphic("assets/images/bg-test.png", false, 1280, 480);
		add(bg);
		add(bg2);
		bg2.x = 640;
		bg.velocity.set(_scrollSpeed, 0);


		_insults = new FlxTypedGroup<Insult>();
		add(_insults);
		//creates and adds a blimp to the screen
		_blimp = new Blimp(20, 20,_insults);
		add(_blimp);
		_blimp.screenCenter();

		_birdsArray= new FlxTypedGroup<Birds>();
		add(_birdsArray);

		spawn.start(FlxG.random.float(1.0, 2.0), birdSpawner, 0);
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		FlxG.sound.play("assets/sounds/effects/blimp_sound.wav");
		scroll();
		FlxG.overlap(_insults, _birdsArray, null, collide);
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

	function birdSpawner(Timer:FlxTimer):Void
	{
		//spawns birds
		var _bird : Birds;
		_bird = new Birds(FlxG.random.int(400, 620), 360, "flock");
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
				return true;
			}

		}

		return false;

	}
}
