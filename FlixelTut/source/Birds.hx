package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;

/**
 * ...
 * @author ...
 */
class Birds extends FlxSprite
{
	var _speed : Float = 200;
	var hit : Bool = false;
	var isalive: Bool = true;
	var _birdnoise : FlxSound;
	var gone: Bool =false;
	var missedBird : Bool = false;

	public function new(?X:Float=0, ?Y:Float=0, ?BirdType:String, ?BirdSkin:FlxGraphicAsset) 
	{
		super(X, Y, BirdSkin);
		loadGraphic("assets/images/BirdFlock_SpriteSheet.png", true, 23, 20);
		animation.add("birdMove", [0, 1, 0, 2], 8, true);
		animation.play("birdMove");
		_birdnoise = FlxG.sound.load("assets/sounds/effects/mad_bird.wav");
	}
	public function gotHit():Void
	{
		hit = true;
	}
	public function dead():Void
	{
		this.kill();
		isalive = false;
		hit = false;
	}
	public function endCall():Void
	{
		gone = true;
		_birdnoise.stop();
	}
	/*public function killing():Void
	{

	}*/

	public function status():Bool
	{
		return hit;
	}
	
	override public function update(elapsed:Float):Void
	 {
		if (hit && !(gone))
		{
			_birdnoise.play();
			//trace("playing");
		}	
		//once the bird hits the edge of the screen and is in the middle
		 //once the bird hits the edge of the screen and is in the middle
		if (this.x>620 && this.y<190 && hit)
		{
			//trace("out");
			velocity.set( -100, 0);
		}
		//removes it if it's off the screen
		if (this.x < 0 || isalive==false) 
		{
			//trace("kill");
			hit = false;
			missedBird = true;
			isalive = false;
			this.kill();
		}	
		super.update(elapsed);
	}
	
	public function getMissedBird():Bool
	{
		if (missedBird){
			missedBird = false;
			return true;
		}
		return false;
		
	}
	
	public function getAlive():Bool
	{
		return isalive;
	}
	 
	
}