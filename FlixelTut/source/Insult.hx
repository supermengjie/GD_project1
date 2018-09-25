package;

 import flixel.FlxSprite;
 import flixel.system.FlxAssets.FlxGraphicAsset;
 import flixel.FlxG;
 import flixel.math.FlxPoint;
 import flixel.FlxObject;

 class Insult extends FlxSprite
 {
	
	 var _speed: Float;
	private var direction:Int;

	 
     public function new(?X:Float=0, ?Y:Float=0,?SimpleGraphic:FlxGraphicAsset,Speed:Float, Direction:Int)
     {
         super(X, Y, SimpleGraphic);
		 _speed = Speed;
		 direction=Direction;
		 loadGraphic("assets/images/Projectile_Sprite.png", true, 16, 16,true);
		 
     }
	 
	 override public function update(elapsed:Float):Void
	 {
		 super.update(elapsed);
		if(direction == FlxObject.LEFT){
			velocity.x= -_speed;
		}
		if(direction == FlxObject.RIGHT){
			velocity.x= _speed;
			velocity.y= _speed;
		}
		if(direction == FlxObject.FLOOR){
			velocity.y= _speed;
		}
		if(direction == FlxObject.CEILING){
			velocity.y= -_speed;
		}
		
		if (this.y > 360){
			this.destroy();
		}
	 }
}