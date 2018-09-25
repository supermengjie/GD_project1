 package;

 import flixel.FlxSprite;
 import flixel.FlxState;
 import flixel.system.FlxAssets.FlxGraphicAsset;
 import flixel.FlxG;
 import flixel.math.FlxPoint;
 import flixel.group.FlxGroup.FlxTypedGroup;
 import flixel.FlxObject;
import flixel.text.FlxText;


 class Blimp extends FlxSprite
 {
	
	 var _speed: Float;
	 var insultArray:FlxTypedGroup<Insult>;
	 var shotCount : Int = 0; 
	 var canShoot : Bool = true;
	 
	 
     public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset, blimpInsultArray: FlxTypedGroup<Insult>, speed : Float)
     {
         super(X, Y, SimpleGraphic);
		 //drag slowly deaccelerates movement when it stops so it doesnt randomly stop
		 drag.x = drag.y = 1000;
		 loadGraphic("assets/images/Blimp_SpriteSheet9.png", true, 128, 64);
		 facing = FlxObject.RIGHT;
		 animation.add("blimpFloat", [0, 1, 2, 3, 4], 5, true);
		 animation.play("blimpFloat");
		 insultArray = blimpInsultArray;
		 _speed = speed;
     }
	 
	 override public function update(elapsed:Float):Void
	 {
		 movement();

		 if (FlxG.keys.justPressed.SPACE && canShoot)
		 {
		 	insult();
			shotCount += 1;
		 }
		 super.update(elapsed);
	 }
	 
	 function movement():Void
	{
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
			if ( ((_up && _right) && (this.y > 5 && this.x < 502)) || ((_up && _left) && (this.y > 5 && this.x > 7)) ||
			((_down && _right) && (this.y < 135 && this.x < 502)) || ((_down && _left) && (this.y < 135 && this.x > 7)) ){
				velocity.set(_speed, 0);
				velocity.rotate(FlxPoint.weak(0, 0), angle);
		    }
			
			//for straight up/down/left/right movements to keep blimp on the screen
			else if ( (_up && this.y > 5 && !_left && !_right) || (_down && this.y < 135 && !_left && !_right) || 
			(_left && this.x > 7 && !_up && !_down) || (_right && this.x < 502 && !_up && !_down) ){
				velocity.set(_speed, 0);
				velocity.rotate(FlxPoint.weak(0, 0), angle);	
			}
			
		}
	}

	private function insult():Void{
		var newInsult = new Insult(x+32, y+15, 200, FlxObject.RIGHT);
		insultArray.add(newInsult);
		/*var text = "The quick brown fox jumps over the lazy dog. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
        var myText = new FlxText(100,400,150,text,12,false);
        add(myText);*/

	}
	
	public function getShotCount():Int
	{
		return shotCount;	
	}
	
	public function getInsults():FlxTypedGroup<Insult>
	{
		return insultArray;		
	}
	
	public function setCanShoot(input : Bool):Void
	{
		canShoot = input;
	}
	
 }