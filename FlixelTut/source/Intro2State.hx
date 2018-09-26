package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.group.FlxGroup.FlxTypedGroup;

class Intro2State extends FlxState
{
	var _continueButton: FlxButton;
	var mytext:FlxText;
	var _blimp : Blimp;
	var _insults:FlxTypedGroup<Insult>;
	var _added : Bool = false;
	
	override public function create():Void
	{
		var text="HOLLOWAY

The Hordeís made it to London, boys. Looks like the enemyís at the gates. 
Theyíre too agile to use normal guns, so weíve gotta think outside the box 
with this one. See that gramophone on the front of the ship? We can use that 
to hurl some not-so-niceties at our feathered friends on the ground. 
HQ says their egos can fly as high as they do, so something fancyíll do nicely. 
Once you get their attention, just ram ëem out of the sky, got it?";
		mytext= new FlxText(0,60,FlxG.width,text,16);
		mytext.setFormat(null,14,FlxColor.RED,FlxTextAlign.CENTER);
		add(mytext);
		_insults = new FlxTypedGroup<Insult>();
		add(_insults);

		_blimp = new Blimp(20, 20, _insults, 200);
		add(_blimp);
		_blimp.x = 0;
		_blimp.y = 0;
		super.create();
	}

	override public function update(elapsed:Float):Void
	{


		if(_blimp.x == 480 && !_added)
		{
			_continueButton = new FlxButton(530, 440, "Continue", myCallback);
			add(_continueButton);
			_added = true;

		}else if(!_added){
			_blimp.x ++;
		}
		super.update(elapsed);
	}
	
	function myCallback():Void
	{
		FlxG.switchState(new Level1State());
	}
}