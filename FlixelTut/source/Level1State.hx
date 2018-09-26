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
import flixel.system.FlxSound;
import flixel.text.FlxText;

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
	var blimpShotCount : Int = 0;
	var birdKillCount : Int = 0;
	var spawnBird : Bool = true;
	var _ggText : FlxSprite = new FlxSprite();
	var _restartButton : FlxButton;
	var _levelPassedText : FlxSprite = new FlxSprite();
	var _nextLevelButton : FlxButton;
	var _blimpNoise : FlxSound;
	var _insult_txt:FlxTypedGroup<FlxText>;
	var _ended : Bool = false;
	var _killedScore : FlxText;

	//testing
	public var t1:String = "You lily-liveríd birds!";
 	public var t2:String = "You pigeon-livered gall-birds!";
 	public var t3:String = "I am sick when I look on thee!";
 	public var t4:String = "Poisonous bunch-backed toads!";
 	public var t5:String = "Thy feathers are not worth plucking!";
 	public var t6:String = "Thou art as fat as butter!";
 	public var t7:String = "Youíre unfit for any place but Hell!";
 	public var t8:String = "You cream-faced loons!";
 	public var t9:String = "Thou lump of foul deformity!";
 	public var t10:String = "Thy beak out-venomís all the worms of the Nile!";
 	public var t11:String = "Your brain is as dry as a saltine cracker!";
 	public var t12:String = "Avian, I hath plucked thy mother!";
 	public var t13:String = "You loggerheaded, hedge-born harpy!";
 	public var t14:String = "Frothy, elf-skinned flap-dragon!";
 	public var t15:String = "Paunchy, fly-bitten pig-nut!";
 	public var t16:String = "*INCOHERENT SCREECHING*";
 	public var t17:String = "Damn soft-beak!";
 	public var t18:String = "Featherbrained scoundrel!";
 	public var t19:String = "You talon-less cowards!";
 	public var t20:String = "Pinioned pigeon-brain!";
 	public var t21:String = "Rank, dog-hearted coxcomb!";
 	public var t22:String = "Crook-beaks!";
 	public var t23:String = "You are unworthy to peck at even my father's eyes!";
 	public var t24:String = "Pox of humanity!";
 	public var t25:String = "Unclean bird-swine!";
 	public var txt = new Array();



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

		_insult_txt = new FlxTypedGroup<FlxText>();
		add(_insult_txt);
		
		//create the blimp object and assign its position
		_blimp = new Blimp(20, 20, _insults, 200);
		add(_blimp);
		_blimp.x = 40;
		_blimp.y = 60;

		_birdsArray= new FlxTypedGroup<Birds>();
		add(_birdsArray);

		spawn.start(FlxG.random.float(3.0, 5.0), birdSpawner, 0);
		
		timerBG.makeGraphic(75, 10, FlxColor.BLACK);
		timerBG.x = 550;
		timerBG.y = 15;
		add(timerBG);
		
		timer.makeGraphic(75, 10, FlxColor.LIME);
		timer.x = 550;
		timer.y = 15;
		add(timer);
		
		_killedScore = new FlxText(20, 20, -1, "Kills: 0/15", 12);
		add(_killedScore);
		
		//plays music
		FlxG.sound.playMusic(AssetPaths.thangs__ogg);
		_blimpNoise=FlxG.sound.load("assets/sounds/effects/blimp_sound.wav");

		txt[0]=t1;
 		txt[1]=t2;
 		txt[2]=t3;
 		txt[3]=t4;
 		txt[4]=t5;
 		txt[5]=t6;
 		txt[6]=t7;
 		txt[7]=t8;
 		txt[8]=t9;
 		txt[9]=t10;
 		txt[10]=t11;
 		txt[11]=t12;
 		txt[12]=t13;
 		txt[13]=t14;
 		txt[14]=t15;
 		txt[15]=t16;
 		txt[16]=t17;
 		txt[17]=t18;
 		txt[18]=t19;
 		txt[19]=t20;
 		txt[20]=t21;
 		txt[21]=t22;
 		txt[22]=t23;
 		txt[23]=t24;
 		txt[24]=t25;
		
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		_blimpNoise.play();
		scroll();
		FlxG.overlap(_insults, _birdsArray, null, collide);
		FlxG.overlap(_blimp, _birdsArray, null, collide);
		checkMissedBird();

		if (FlxG.keys.justPressed.SPACE)
		{
			for(t in _insult_txt){
				t.destroy();
			}

			var rint=FlxG.random.int(0,24);
			//trace("rint:",rint);
			var text = txt[rint];
        	var myText = new FlxText(240,400,200,text,12,false);
        	add(myText);
        	_insult_txt.add(myText);
		}
		if (blimpShotCount != _blimp.getShotCount()){
			decreaseTimer(.2);
			blimpShotCount = _blimp.getShotCount();
		}
		if (curScale == 0 && _blimp.getInsults().countLiving() == 0){
			if (!gameOverCheck() && !_ended){
				_blimp.kill();
				fg.velocity.set(0, 0);
				fg2.velocity.set(0, 0);
				mg.velocity.set(0, 0);
				mg2.velocity.set(0, 0);
				_ggText.loadGraphic("assets/images/Game-Over-Text.png", false, 606, 119);
				add(_ggText);
				_ggText.screenCenter();
				_restartButton  = new FlxButton(290, 20, "Restart Level!", levelRestart);
				add(_restartButton);
				_ended = true;
			}
	   	}
		
		if (birdKillCount == 15){
			spawnBird = false;
			if (curScale > 0 && !_ended){
				fg.velocity.set(0, 0);
				fg2.velocity.set(0, 0);
				mg.velocity.set(0, 0);
				mg2.velocity.set(0, 0);
				_levelPassedText.loadGraphic("assets/images/Level-Passed-Text.png", false, 620, 114);
				add(_levelPassedText);
				_levelPassedText.screenCenter();
				_nextLevelButton = new FlxButton(290, 20, "Next Level!", nextLevel);
				add(_nextLevelButton);
				_ended = true;
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
			FlxG.sound.play("assets/sounds/effects/smack.wav");
			var s1: Dynamic = cast(Sprite1, Blimp);
			var s2: Dynamic = cast(Sprite2, Birds);
			s2.endCall();
			s2.dead();
			increaseTimer();
			birdKillCount += 1;
			_killedScore.text = ("Kills: " + birdKillCount + "/15");
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
		FlxG.switchState(new Intro3State());
	}
	
	function checkMissedBird():Void
	{
		for (bird in _birdsArray){
			if (bird.getMissedBird()){
				decreaseTimer(.1);
			}
		}
	}
}
