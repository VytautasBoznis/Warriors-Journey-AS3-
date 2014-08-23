package grafics
{
	/**
	 * @author Ideo
	 */
	
	import flash.display.*;
	 
	public final class Assets 
	{
		//===== EMBEDED BMP CLASESS =====
		
		// = GUI ASSETS =
		[Embed (source = "assets/logo.png")] public static const LOGO_BMP : Class;
		// Main Menu
		[Embed (source = "assets/gui/MenuShader.png")] public static const MENU_SHADER_BMP : Class;
		[Embed (source = "assets/gui/startButton.png")] public static const START_BUTTON_BMP : Class;
		[Embed (source = "assets/gui/scoresButton.png")] public static const SCORES_BUTTON_BMP : Class;
		[Embed (source = "assets/gui/creditsButton.png")] public static const CREDITS_BUTTON_BMP : Class;
		// Credits
		[Embed (source = "assets/gui/creditsShader.png")] public static const CREDITS_SHADER_BMP : Class;
		// Game Over
		[Embed (source = "assets/gui/gameOverShader.png")] public static const GAME_OVER_SHADER_BMP : Class;
		[Embed (source = "assets/gui/mainMenuButton.png")] public static const MAIN_MENU_BUTTON_BMP : Class;
		[Embed (source = "assets/gui/retryButton.png")] public static const RETRY_BUTTON_BMP : Class;
		// Tutorial
		[Embed (source = "assets/gui/tutShader.png")] public static const TUT_SHADER_BMP : Class;
		// Scores
		[Embed (source = "assets/gui/refreshButton.png")] public static const REFRESH_BUTTON_BMP : Class;
		[Embed (source = "assets/gui/personalButton.png")] public static const PERSONAL_BUTTON_BMP : Class;
		[Embed (source = "assets/gui/globalButton.png")] public static const GLOBAL_BUTTON_BMP : Class;
		[Embed (source = "assets/gui/miniBackButton.png")] public static const MINI_BACK_BUTTON_BMP : Class;

		// = GAME ASSETS =
		[Embed (source = "assets/gui/menuBg.png")] public static const BG_BMP : Class;
		// Tiles
		[Embed (source = "assets/tiles/groundTile.png")] public static const GROUND_TILE_BMP : Class;
		[Embed (source = "assets/tiles/spikeTile.png")] public static const SPIKE_TILE_BMP : Class;
		
		
		// = ANIMATION ASSETS = 
		[Embed (source = "assets/entitys/pc/PC_1.png")] public static const PC_1_BMP : Class;
		[Embed (source = "assets/entitys/pc/PC_2.png")] public static const PC_2_BMP : Class;
		[Embed (source = "assets/entitys/pc/PC_3.png")] public static const PC_3_BMP : Class;
		
		//===== BITMAP DATA =====
		
		// = GUI ASSETS = 
        public static const LOGO_DATA : BitmapData = (new LOGO_BMP() as Bitmap).bitmapData;
		// Main Menu
		public static const MENU_SHADER_DATA : BitmapData = (new MENU_SHADER_BMP() as Bitmap).bitmapData;
		public static const START_BUTTON_DATA : BitmapData = (new START_BUTTON_BMP() as Bitmap).bitmapData;
		public static const SCORES_BUTTON_DATA : BitmapData = (new SCORES_BUTTON_BMP() as Bitmap).bitmapData;
		public static const CREDITS_BUTTON_DATA : BitmapData = (new CREDITS_BUTTON_BMP() as Bitmap).bitmapData;
		// Credits
		public static const CREDITS_SHADER_DATA : BitmapData = (new CREDITS_SHADER_BMP() as Bitmap).bitmapData;
		// Game Over
		public static const GAME_OVER_SHADER_DATA : BitmapData = (new GAME_OVER_SHADER_BMP() as Bitmap).bitmapData;
		public static const MAIN_MENU_BUTTON_DATA : BitmapData = (new MAIN_MENU_BUTTON_BMP() as Bitmap).bitmapData;
		public static const RETRY_BUTTON_DATA : BitmapData = (new RETRY_BUTTON_BMP() as Bitmap).bitmapData;
		// Tutorial
		public static const TUT_SHADER_DATA : BitmapData = (new TUT_SHADER_BMP() as Bitmap).bitmapData;
		// Scores
		public static const REFRESH_BUTTON_DATA : BitmapData = (new REFRESH_BUTTON_BMP() as Bitmap).bitmapData;
		public static const PERSONAL_BUTTON_DATA : BitmapData = (new PERSONAL_BUTTON_BMP() as Bitmap).bitmapData;
		public static const GLOBAL_BUTTON_DATA : BitmapData = (new GLOBAL_BUTTON_BMP() as Bitmap).bitmapData;
		public static const MINI_BACK_BUTTON_DATA : BitmapData = (new MINI_BACK_BUTTON_BMP() as Bitmap).bitmapData;
		
		// = GAME ASSETS = 
		public static const BG_DATA : BitmapData = (new BG_BMP() as Bitmap).bitmapData;

		//Tiles
		public static const GROUND_TILE_DATA : BitmapData = (new GROUND_TILE_BMP() as Bitmap).bitmapData;
		public static const SPIKE_TILE_DATA : BitmapData = (new SPIKE_TILE_BMP() as Bitmap).bitmapData;
		
		// = ANIMATION ASSETS = 
		public static const PC_1_DATA : BitmapData = (new PC_1_BMP as Bitmap).bitmapData;
		public static const PC_2_DATA : BitmapData = (new PC_2_BMP as Bitmap).bitmapData;
		public static const PC_3_DATA : BitmapData = (new PC_3_BMP as Bitmap).bitmapData;

	}

}