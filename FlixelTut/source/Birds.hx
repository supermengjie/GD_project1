package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.math.FlxPoint;

/**
 * ...
 * @author ...
 */
class Birds extends FlxSprite
{
	var _speed : Float = 200;
	var hit : Bool = false;

	public function new(?X:Float=0, ?Y:Float=0, ?BirdType:String, ?BirdSkin:FlxGraphicAsset) 
	{
		super(X, Y, BirdSkin);
		loadGraphic("assets/images/Blimp_SpriteSheet9.png", true, 128, 64);
		animation.add("blimpFloat", [0, 1, 2, 3, 4], 5, true);
		animation.play("blimpFloat");
	}
	public function move():Void
	{
		var act:Bool = false;
		act = FlxG.keys.anyPressed([T]);
		if (act && !hit) 
		{
			velocity.set(200, -100);
			hit = true;
		}
		
	}
	override public function update(elapsed:Float):Void
	 {
		move();
		 //once the bird hits the edge of the screen and is in the middle
		if (this.x>620 && this.y<190 && hit)
		{
			trace("out");
			velocity.set( -100, 0);
		}
		//removes it if it's off the screen
		if (this.x < 0) 
		{
			trace("kill");
			this.kill();
		}	
		super.update(elapsed);
	 }
	 
	
}