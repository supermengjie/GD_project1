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
		loadGraphic("assets/images/Blimp_SpriteSheet9.png", true, 128, 64);
		animation.add("blimpFloat", [0, 1, 2, 3, 4], 5, true);
		animation.play("blimpFloat");
	}
	
	override public function update(elapsed:Float):Void
	 {
		 super.update(elapsed);
	 }
	 
	
}