 package;

 import flixel.FlxSprite;
 import flixel.system.FlxAssets.FlxGraphicAsset;
 import flixel.FlxG;
 import flixel.math.FlxPoint;

 class Blimp extends FlxSprite
 {
	
	 var _speed: Float = 200;
	 
     public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
     {
         super(X, Y, SimpleGraphic);
		 //drag slowly deaccelerates movement when it stops so it doesnt randomly stop
		 drag.x = drag.y = 1600;
		 loadGraphic("assets/images/blimp.jpg", true, 64, 64);
     }
	 
	 override public function update(elapsed:Float):Void
	 {
		 movement();
		 super.update(elapsed);
	 }
	 
	 function movement():Void
	{
		//bools to determine which direction player is moving. Used to check screen boundaries and angles
		var _up:Bool = false;
		var _down:Bool = false;
		var _left:Bool = false;
		var _right:Bool = false;
		
		//use of arrow keys or WASD
		_up = FlxG.keys.anyPressed([UP, W]);
		_down = FlxG.keys.anyPressed([DOWN, S]);
		_left = FlxG.keys.anyPressed([LEFT, A]);
		_right = FlxG.keys.anyPressed([RIGHT, D]);
		
		//cancels out opposite directions
		if (_up && _down){
			_up = _down = false;
		}
		if (_left && _right){
			_left = _right = false;
		}
		
		//determines the angle to rotate the speed on based on direction player is moving
		if (_up || _down || _left || _right){
			var angle:Float = 0;
			if (_up){
				angle = -90;
				if (_left){
					angle -= 45;
				}
				else if (_right){
					angle += 45;
				}
			}
			else if (_down){
				angle = 90;
				if (_left){
					angle += 45;
				}
				else if (_right){
					angle -= 45;
				}
			}
			else if (_left){
				angle = 180;
			}
			else if (_right){
				angle = 0;
			}
			
			//For diagonal movements to keep blimp on the screen
			if ( ((_up && _right) && (this.y > 12 && this.x < 566)) || ((_up && _left) && (this.y > 12 && this.x > 12)) ||
				 ((_down && _right) && (this.y < 406 && this.x < 566)) || ((_down && _left) && (this.y < 406 && this.x > 12)) ){
					velocity.set(_speed, 0);
					velocity.rotate(FlxPoint.weak(0, 0), angle);
					trace("X:", this.x, " Y:", this.y);
		    }
			//for straight up/down/left/right movements to keep blimp on the screen
			else if ( (_up && this.y > 16 && !_left && !_right) || (_down && this.y < 406 && !_left && !_right) || 
			          (_left && this.x > 16 && !_up && !_down) || (_right && this.x < 566 && !_up && !_down) ){
				velocity.set(_speed, 0);
				velocity.rotate(FlxPoint.weak(0, 0), angle);
				trace("X:", this.x, " Y:", this.y);		
			}
			
		}
	}
 }