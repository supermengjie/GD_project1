package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;

class MenuState extends FlxState
{
	var _playButton: FlxButton;
	
	override public function create():Void
	{
		FlxG.resizeGame(1280, 720);
		FlxG.resizeWindow(1280, 720);
		_playButton = new FlxButton(0, 0, "Play!", clickPlay);
		_playButton.screenCenter();
		add(_playButton);
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	
	function clickPlay():Void
	{
		FlxG.switchState(new PlayState());
	}
}