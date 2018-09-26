package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.system.FlxSound;

class Intro1State extends FlxState
{
	var _continueButton: FlxButton;
	var mytext:FlxText;
	var _added : Bool = false;
	
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
		if(mytext.y == 0 && !_added)
		{
			mytext.y = 0;
			_continueButton = new FlxButton(530, 440, "Continue", myCallback);
			add(_continueButton);
			_added = true;
		}else if(!_added){
			mytext.y--;
		}
		super.update(elapsed);
	}
	
	function myCallback():Void
	{
		FlxG.switchState(new MenuState());
	}
}