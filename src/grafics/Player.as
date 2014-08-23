package grafics 
{
	import flash.display.Sprite;
	
	/**
	 * The Player class.
	 * @author Ideo
	 */
		
	 public class Player extends Sprite 
	{
		// === the game object this player belongs to ===
		private var game : Game;
		
		private var centerX : Number; 
		private var centerY : Number; 
		
		private var speedY : Number;
		private var speedX : Number;
		
		private var runAnim : Animation;
		private var jumpAnim : Animation;
		private var fallAnim : Animation;
		
		private var usingAnim : int; //0 - run, 1 - jump, 2 - fall;
		private var currentAnim :Animation; //used for on screen binding;
		
		public var running : Boolean = false;
		public var jumping : Boolean = false;
		public var falling : Boolean = false;
		
		public var addY : Boolean = false; //used to fix animation glitches
		
		public var stoped : Boolean = false; //can only be stoped by tiles
		public var inAir : Boolean = false;
		
		private var jumpCount : Number = 0;
		
		public function Player(myGame : Game) 
		{
			game = myGame;
			
			centerX = 56 + 100; //a head start of 100px.
			centerY = 480 - 150;
			
			speedX = 180;
			speedY = -1;
			
			runAnim = new Animation(Assets.PC_1_DATA, 8, 10);
			jumpAnim = new Animation(Assets.PC_2_DATA, 1 , 1);
			fallAnim = new Animation(Assets.PC_3_DATA, 1 , 1);
			
			
			runAnim.x = centerX - 41; //the upper left courner is needed
			runAnim.y = centerY - 37; //the upper left courner is needed
			
			jumpAnim.x = centerX - 41; //the upper left courner is needed
			jumpAnim.y = centerY - 37; //the upper left courner is needed
			
			currentAnim = runAnim;
			
			addChild(currentAnim);
			
			inAir = true;
		}
		
		public function receiveInput(keyCode : int) : void
		{
			if ((keyCode == 87 || keyCode == 38) && jumpCount < 2)
			{
				speedY = 20;
				stoped = false;
				inAir = true;
				jumpCount++;
			}
			else
				switchAnim(0);
		}
		
		public function update(deltaTime : Number) : void
		{
			// === Movement and speed calcultaions ===
			
			speedX = 180;
			
			if (inAir)
				stoped = false;
			
			if (stoped)
				centerX -= speedX*deltaTime;
			else if (centerX < 100)
				centerX += speedX*deltaTime+5;
			
			if(stoped)
				speedX -= 4 * deltaTime;
			
			if(inAir)
			{
				jumping = true;
				running = false;
				
				if(speedY < 0)
				{
					jumping = false;
					falling = true;
				}
				
				speedY -= 40 * deltaTime;
				centerY -= speedY;
			}
			
			// === Colision calculations ===
			
			var type : int;
			
			for (var i :int; i < game.getWorld().tiles.length; i++)
			{
				if (isColidingBot(game.getWorld().tiles[i]))//bottom collisions
				{
					type = game.getWorld().tiles[i].getType();
					
					if (type == 0 || type == 2)
						inAir = true;
					else if (type == 1)
					{
						centerY = game.getWorld().tiles[i].y - 50;
						speedY = 0;
						inAir = false;
						running = true;
						jumpCount = 0;
					}
					
					break;
				}
				
				if (isColidingSide(game.getWorld().tiles[i]))
				{
					type = game.getWorld().tiles[i].getType();
					
					if (type == 1)
					{
						stoped = true;
					}
				}
			}
				
			// === Animation position reseting and updating ===
			
			currentAnim.x = centerX - 56;
			currentAnim.y = centerY - 50;
			
			if(running)
				switchAnim(0);
			
			if(jumping)
				switchAnim(1);
			
			if(falling)
				switchAnim(2);
				
			currentAnim.step(deltaTime);
			
			//	===	Death Events	===
			if(1440 - centerY*2 < 480 || centerX < -100)
				game.registerGameOver();
			
		}
		
		private function switchAnim(anim : int) : void
		{
			switch(anim)
			{
				case 0:
				{
					usingAnim = 0;
					
					removeChild(currentAnim);
					currentAnim = runAnim;
					
					addChild(currentAnim);
					break;
				}
				
				case 1:
				{
					usingAnim = 1;
					
					removeChild(currentAnim);
					currentAnim = jumpAnim;
					
					addChild(currentAnim);
					break;
				}
				
				case 3:
				{
					usingAnim = 2;
					
					removeChild(currentAnim);
					currentAnim = fallAnim;
					
					addChild(currentAnim);
					break;
				}
			}
		}
		
		private function isColidingSide(obj : Sprite) : Boolean
		{
			if (obj is Tile)
				//it doesint matter if we are in are or not
				//always uses the right botom corner pixel for checks
				return centerY >= (obj as Tile).y &&
					   centerX + 35 >= obj.x && 
					   centerX + 35 <= obj.x + 100;
			else
				return false;
		}
		
		private function isColidingBot(obj : Sprite) : Boolean
		{
			if (obj is Tile)
			{
				// If the player is already on the ground, use the
				// x value nearer to the back for collision testing
				if (!inAir)
				{
					if ((obj as Tile).getType() == 0 || (obj as Tile).getType() == 2)
						return centerY - 150 <= (obj as Tile).y &&
							centerX+10 >= obj.x &&
							centerX+10 <= obj.x + 100;
					else
						return centerY + 30 >= (obj as Tile).y &&
							(centerX - 35) >= obj.x &&
							(centerX - 35) <= obj.x + 100;
				}
				else
				{
					// If the player is in the air, use the x value
					// nearer to the front for collision testing
					return centerY >= (obj as Tile).y &&
						(centerX + 35) >= obj.x &&
						(centerX + 35) <= obj.x + 100;
				}
			}
			
			return false;
		}
	}

}