package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxTimer;
import flixel.FlxObject;
import flixel.math.FlxMath;
import flixel.ui.FlxButton;

class Level2State extends FlxState
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
	var _scrollSpeed : Float = -100;
	var spawn : FlxTimer = new FlxTimer();
	public var _birdsArray:FlxTypedGroup<Birds>;
	var blimpShotCount : Int = 0;
	var birdSpawnCount : Int = 0;
	var spawnBird : Bool = true;
	var _ggText : FlxSprite = new FlxSprite();
	var _restartButton : FlxButton;
	var _levelPassedText : FlxSprite = new FlxSprite();
	var _nextLevelButton : FlxButton;

	override public function create():Void
	{
		//load in graphics and assign their x and y positions
		fg.loadGraphic("assets/images/Background1_Houses_Destruction2.png", false, 512, 157);
		fg2.loadGraphic("assets/images/Background1_Houses_Destruction2.png", false, 512, 157);
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
		_blimp = new Blimp(20, 20, _insults, 100);
		add(_blimp);
		_blimp.x = 40;
		_blimp.y = 60;

		_birdsArray= new FlxTypedGroup<Birds>();
		add(_birdsArray);

		spawn.start(FlxG.random.float(3.0, 4.0), birdSpawner, 0);
		
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
		checkMissedBird();

		if (blimpShotCount != _blimp.getShotCount()){
			decreaseTimer(.2);
			blimpShotCount = _blimp.getShotCount();
		}
		if (curScale == 0 && _blimp.getInsults().countLiving() == 0){
			if (!gameOverCheck()){
				_blimp.kill();
				fg.velocity.set(0, 0);
				fg2.velocity.set(0, 0);
				mg.velocity.set(0, 0);
				mg2.velocity.set(0, 0);
				_ggText.loadGraphic("assets/images/Game-Over-Text.png", false, 606, 119);
				add(_ggText);
				_ggText.screenCenter();
				_restartButton  = new FlxButton(20, 20, "Restart Level!", levelRestart);
				add(_restartButton);
			}
	   	}
		
		if (birdSpawnCount == 5){
			spawnBird = false;
			if (curScale > 0 && checkAliveBirds()){
				fg.velocity.set(0, 0);
				fg2.velocity.set(0, 0);
				mg.velocity.set(0, 0);
				mg2.velocity.set(0, 0);
				_levelPassedText.loadGraphic("assets/images/Level-Passed-Text.png", false, 620, 114);
				add(_levelPassedText);
				_levelPassedText.screenCenter();
				_nextLevelButton = new FlxButton(20, 20, "Next Level!", nextLevel);
				add(_nextLevelButton);
			}
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
		if (spawnBird){
			//spawns birds
			var _bird : Birds;
			_bird = new Birds(FlxG.random.int(640, 860), 300, "flock");
			add(_bird);
			_birdsArray.add(_bird);
			_bird.velocity.set(_scrollSpeed, 0);
			birdSpawnCount += 1;
		}
		
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
			increaseTimer();
			//s2.detroy();
			return true;
		}

		return false;

	}
	
	//if insult is shot decrease width of the timer and update hitbox
	public function decreaseTimer(amount : Float):Void
	{
		//trace("curScaleB-: ", curScale);
		var temp : Float = FlxMath.roundDecimal((curScale - amount), 1);
		if(temp <= 0){
			curScale = 0;
			_blimp.setCanShoot(false);
		}
		else{
			curScale -= amount;
		}
		//trace("curScaleA-: ", curScale);
		timer.scale.set(curScale, 1);
		timer.updateHitbox();
	}
	
	//if bird is destroyed increase width of timer and update hitbox
	function increaseTimer():Void
	{
		//trace("curScaleB+: ", curScale);
		var temp : Float = FlxMath.roundDecimal((curScale + .2), 1);
		if (temp <= 1){
			curScale += .2;
			_blimp.setCanShoot(true);
		}
		//trace("curScaleA+: ", curScale);
		timer.scale.set(curScale, 1);
		timer.updateHitbox();
	}
	
	function gameOverCheck():Bool
	{
		for (bird in _birdsArray){
			if (bird.status()){
				return true;
			}
		}
		spawnBird = false;
		return false;
	}
	
	function levelRestart():Void
	{
		FlxG.resetState();
	}
	
	function nextLevel():Void
	{
		FlxG.switchState(new Level3State());
	}
	
	function checkMissedBird():Void
	{
		for (bird in _birdsArray){
			if (bird.getMissedBird()){
				decreaseTimer(.1);
			}
		}
	}
	
	function checkAliveBirds():Bool
	{
		for (bird in _birdsArray){
			if (bird.getAlive()){
				return false;
			}
		}
		return true;
	}
}
