package grafics 
{
	import flash.display.Sprite;
	
	/**
	* @author Ideo
	*/
	
	 public class BackGround extends Sprite
	{		
		private var speedX : int = 0;
		private var speedY : int = 0;
		
		private var secondBg :Boolean = false;
		private var extraSpeed : int; //used to speed up connections of front to back
		
		public function BackGround(myX : int, myY:int, mySpeedX:int, mySpeedY:int)
		{
			if (myX > 0)
			{
				secondBg = true;
				extraSpeed = 2;
			}
			
			speedX = mySpeedX;
			speedY = mySpeedY;
			
			this.x = myX;
			this.y = myY;			
			
			this.graphics.beginBitmapFill(Assets.BG_DATA, null, false, true);
			this.graphics.drawRect(0, 0, Assets.BG_DATA.width, Assets.BG_DATA.height);
			this.graphics.endFill();
		}
		
		public function update(deltaTime : Number) :void
		{	
			if (extraSpeed > 0)
			{
				this.x = this.x - speedX * deltaTime -1;
				extraSpeed--;
			}
			else
				this.x = this.x - speedX * deltaTime;
				
				
			this.y -= speedY*deltaTime;
			
			
			if (this.x < -878)
			{
				this.x += 1746;
				
				if (secondBg)
					extraSpeed = 0;
				else
					extraSpeed = 2;
			}
			
			if (this.y < -480)
				this.y += 960;
		}
		
		public function setSpeedX(newSpeedX : int) :void
		{
			speedX = newSpeedX;
		}
		
		public function setSpeedY(newSpeedY : int) : void
		{
			speedY = newSpeedY;
		}
	}

}