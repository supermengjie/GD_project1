package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.FlxSprite;

class MenuState extends FlxState
{
	var _playButton: FlxButton;
	var _titleScreen : FlxSprite = new FlxSprite();
	
	override public function create():Void
	{
		_titleScreen.loadGraphic("assets/images/Title_Screen.png", false, 640, 480);
		add(_titleScreen);
		_playButton = new FlxButton(0, 0, "Play!", clickPlay);
		_playButton.x = 530;
		_playButton.y = 440;
		add(_playButton);
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	
	function clickPlay():Void
	{
		FlxG.switchState(new Level1State());
	}
}