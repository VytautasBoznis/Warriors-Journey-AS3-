package functions
{
	import grafics.*;
	
	/**
	 * World generator for level creation.
	 * @author Ideo
	 */
	
	public class WorldGen 
	{
		private var isStart : Boolean = false;
		private var savedPart : Vector.<Tile>;
		
		public function WorldGen() 
		{
		}
		
		public function getMap(tiles : Vector.<Tile>) : Vector.<Tile>
		{
			var i : int;
			
			if (!isStart)
			{
				for (i = 0; i <= 8;i++)
					tiles.push(new Tile(tiles.length, 0, 1));
				
				isStart = true;	
			}
			else
			{
				savedPart = new Vector.<Tile>();
				
				for (i = 0; i < 15; i++)
					savedPart.push(tiles[tiles.length - 15 + i]);
				
				tiles = new Vector.<Tile>();
				
				for (i = 0; i < 15; i++)
					tiles.push(savedPart[i]);
			}
			
			for (i = 0; i <= 10; i++)
					addTileSet(randomInRange(9, 0), tiles);
			
			return tiles;
		}
		
		private function addTileSet(num : Number,map : Vector.<Tile>) :void
		{
			var i : int = int (num);
			if(i == 0)
			{
				map.push(new Tile(map.length,0,1));
				map.push(new Tile(map.length,1,0));
				map.push(new Tile(map.length,1,1));
				map.push(new Tile(map.length,1,0));
				map.push(new Tile(map.length,1,1));
				map.push(new Tile(map.length,1,0));
				map.push(new Tile(map.length,0,1));
			}
			if(i == 1)
			{
				map.push(new Tile(map.length,0,1));
				map.push(new Tile(map.length,1,2));
				map.push(new Tile(map.length,0,1));
				map.push(new Tile(map.length,1,2));
				map.push(new Tile(map.length,0,1));
			}
			if(i == 2)
			{
				map.push(new Tile(map.length,0,1));
				map.push(new Tile(map.length,1,0));
				map.push(new Tile(map.length,1,0));
				map.push(new Tile(map.length,1,1));
				map.push(new Tile(map.length,1,0));
				map.push(new Tile(map.length,1,0));
				map.push(new Tile(map.length,0,1));
			}
			if(i == 3)
			{
				map.push(new Tile(map.length,0,1));
				map.push(new Tile(map.length,0,0));
				map.push(new Tile(map.length,1,2));
				map.push(new Tile(map.length,0,0));
				map.push(new Tile(map.length,0,1));
			}
			if(i == 4)
			{
				map.push(new Tile(map.length,0,1));
				map.push(new Tile(map.length,1,1));
				map.push(new Tile(map.length,2,1));
				map.push(new Tile(map.length,2,0));
				map.push(new Tile(map.length,0,1));
			}
			if(i == 5)
			{
				map.push(new Tile(map.length,0,1));
				map.push(new Tile(map.length,1,0));
				map.push(new Tile(map.length,1,1));
				map.push(new Tile(map.length,1,2));
				map.push(new Tile(map.length,1,1));
				map.push(new Tile(map.length,1,0));
				map.push(new Tile(map.length,0,1));
			}
			if(i == 6)
			{
				map.push(new Tile(map.length,0,1));
				map.push(new Tile(map.length,1,0));
				map.push(new Tile(map.length,1,1));
				map.push(new Tile(map.length,2,2));
				map.push(new Tile(map.length,1,2));
				map.push(new Tile(map.length,1,0));
				map.push(new Tile(map.length,0,1));
			}
			if(i == 7)
			{
				map.push(new Tile(map.length,0,1));
				map.push(new Tile(map.length,1,0));
				map.push(new Tile(map.length,1,1));
				map.push(new Tile(map.length,2,2));
				map.push(new Tile(map.length,1,1));
				map.push(new Tile(map.length,1,0));
				map.push(new Tile(map.length,0,1));
			}
			if(i == 8)
			{
				map.push(new Tile(map.length,0,1));
				map.push(new Tile(map.length,0,2));
				map.push(new Tile(map.length,0,2));
				map.push(new Tile(map.length,0,1));
				map.push(new Tile(map.length,0,2));
				map.push(new Tile(map.length,0,2));
				map.push(new Tile(map.length,0,1));
			}
			if(i == 9)
			{
				map.push(new Tile(map.length,0,1));
				map.push(new Tile(map.length,1,2));
				map.push(new Tile(map.length,0,1));
				map.push(new Tile(map.length,1,1));
				map.push(new Tile(map.length,1,0));
				map.push(new Tile(map.length,1,1));
				map.push(new Tile(map.length,1,2));
				map.push(new Tile(map.length,0,1));
			}
		}
		
		private function randomInRange(max:Number, min:Number = 0):Number
		{
			return Math.random() * (max - min) + min;
		}
		
	}

}