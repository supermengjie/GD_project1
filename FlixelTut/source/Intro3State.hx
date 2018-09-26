package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.group.FlxGroup.FlxTypedGroup;

class Intro3State extends FlxState
{
	var _playButton: FlxButton;
	var mytext:FlxText;
	var _blimp : Blimp;
	var _insults:FlxTypedGroup<Insult>;
	
	override public function create():Void
	{
		var text="HOLLOWAY

That was some of the finest shouting Iíve ever seen, Gentlemen, 
but we need more. I just received word that Parliament is under attack. 
The hordeís leader is laying siege to the seat of our government! 
Dejected pigeons arenít enough, lads. I need these crows IRATE! 
Get Fritz's Fliers here to chase us, just like before, and weíll make it 
to Parliament in no time!";
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


		if(_blimp.x == 480)
		{
			var t=new FlxTimer().start(8.0, myCallback, 1);

		}else{
			_blimp.x ++;
		}
		super.update(elapsed);
	}
	
	function myCallback(Timer:FlxTimer):Void
	{
		FlxG.switchState(new Level2State());
	}
}