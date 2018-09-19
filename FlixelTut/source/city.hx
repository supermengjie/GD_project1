 package;

 import flixel.FlxSprite;
 import flixel.system.FlxAssets.FlxGraphicAsset;
 import flixel.FlxG;
 import flixel.math.FlxPoint;

 class City extends FlxSprite
 {
	
	 
     public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
     {
         super(X, Y, SimpleGraphic);
		 loadGraphic("assets/images/bg-test.png", true, 1280, 480);
     }
	 
	 override public function update(elapsed:Float):Void
	 {
		 super.update(elapsed);
	 }
 }