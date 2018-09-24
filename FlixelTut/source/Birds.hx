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

	public function new(?X:Float=0, ?Y:Float=0, ?BirdType:String, ?BirdSkin:FlxGraphicAsset) 
	{
		super(X, Y, BirdSkin);
		loadGraphic("assets/images/BirdFlock_SpriteSheet.png", true, 23, 20);
		animation.add("birdMove", [0, 1, 0, 2], 8, true);
		animation.play("birdMove");
	}
	
	override public function update(elapsed:Float):Void
	 {
		 moving();
		 if (this.x>620 && this.y<190)
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
	 
	 function moving():Void
	 {
		 //t activates the movement for now
		//act= FlxG.keys.anyPressed([T]);
	 }
	 
	
}