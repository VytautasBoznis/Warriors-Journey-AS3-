package  
{
	import flash.display.Sprite;
	import functions.*;
	import grafics.Player;
	import grafics.Tile;
	
	/**
	 * Handles all tile updates and tile drawing.
	 * @author Ideo
	 */
	
	 public class World extends Sprite
	{
		public var tiles : Vector.<Tile> = new Vector.<Tile>();
		
		private var started : Boolean = false;
		private var newMap : Boolean = false;
		private var generator : WorldGen;
		
		
		public function World() 
		{
			generator = new WorldGen();
			generator.getMap(tiles);
		}
		
		public function updateWorld(deltaTime : Number) : void
		{
			if (tiles[tiles.length - 15].x <= 0)
				newMap = true;
			
			for (var i : int = 0; i < tiles.length; i++)
				tiles[i].update(deltaTime);
				
			addWorld();
		}
		
		public function addWorld() : void
		{
			var i : int;
			if (!started)
			{
				for (i = 0; i < tiles.length; i++)
					addChild(tiles[i]);
				
				started = true;
			}
			else if (newMap)
			{
				trace("changing map");
				for (i = 0; i < tiles.length; i++)
					removeChild(tiles[i]);
				
				tiles = generator.getMap(tiles);
				
				for (i = 0; i < tiles.length; i++)
					addChild(tiles[i]);
				
				newMap = false;
			}
			
		}
		
	}

}