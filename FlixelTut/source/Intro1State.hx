package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class Intro1State extends FlxState
{
	var _playButton: FlxButton;
	var mytext:FlxText;
	
	override public function create():Void
	{
		var text="Berlin, 1917

After a series of devastating losses, Kaiser Wilhelm seeks to turn the 
tide of the Great War in favor of the German Empire.

Suffering failure after failure in his endeavors with conventional 
weapons, Wilhelmís chief scientists come to him with a last-ditch 
bid to seize the upper hand against the forces of the Allies.

The Kaiser pours the last of Germanyís funds into this 
hopeful secret weaponÖ";
		mytext= new FlxText(0,480,FlxG.width,text,16);
		mytext.setFormat(null,14,FlxColor.RED,FlxTextAlign.CENTER);
		add(mytext);
		super.create();
	}

	override public function update(elapsed:Float):Void
	{


		if(mytext.y == 0)
		{
			mytext.y = 0;
			var t=new FlxTimer().start(3.0, myCallback, 1);
		}else{
			mytext.y--;
		}
		super.update(elapsed);
	}
	
	function myCallback(Timer:FlxTimer):Void
	{
		FlxG.switchState(new MenuState());
	}
}