package grafics 
{
	import flash.display.Sprite;

	/**
	 * The Basic Tile class.
	 * @author Ideo
	 */
	
	public class Tile extends Sprite 
	{
		private var speedX : int = 0;
		private var speedY : int = 0;
		
		private var type : int = 0;
		
		public function Tile(myX : int, myY : int,myType :int) 
		{			
			this.x = myX*100;
			this.y = 480 -(myY+1)*50;
			
			speedX = 180;
			speedY = 0;
			
			type = myType;
			
			switch (type)
			{
				case 1:
				{
					this.graphics.beginBitmapFill(Assets.GROUND_TILE_DATA, null, false, true);
					this.graphics.drawRect(0, 0, Assets.GROUND_TILE_DATA.width, Assets.GROUND_TILE_DATA.height);
					this.graphics.endFill();
					break;
				}
				case 2:
				{
					this.graphics.beginBitmapFill(Assets.SPIKE_TILE_DATA, null, false, true);
					this.graphics.drawRect(0, 0, Assets.SPIKE_TILE_DATA.width, Assets.SPIKE_TILE_DATA.height);
					this.graphics.endFill();
					break;
				}
			}
		}
		
		public function update(deltaTime : Number) :void
		{
			this.x -= speedX*deltaTime;
			this.y -= speedY*deltaTime;
		}
		
		public function getType() : int
		{
			return type;
		}
	}

}