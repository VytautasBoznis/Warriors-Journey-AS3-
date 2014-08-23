package  
{
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.*;
	import mx.collections.errors.ItemPendingError;
	import mx.controls.Text;

	import grafics.*;

	/**
	* @author Ideo
	*/

	public class Game extends Sprite
	{
		// === OBJECTS USED IN GAME ===
		private static var instance : Game = null;
		private static var mainMenu : MainMenu = null;//the main menu object in witch the game is running used for returning back
		
		private var topFiller : Sprite; //used to set the back color to bg frendly
		private var botFiller : Sprite; //used to set the back color to bg frendly

		private var tutFiller : Sprite; //used before game as tutorial
		
		private var bgFiller : Sprite; //used in Game Over calls
		private var gameOverFiller : Sprite; // used in Game Over calls
		
		private var retryButton : Sprite; // used in Game Over
		private var menuButton : Sprite; // used in Game Over
		
		private var distanceText : TextField;
		
		private var world : World; //map inside
		private var player : Player;
		
		private var BG1: BackGround;
		private var BG2: BackGround;
		
		private var gameState : int = 1; //1 - game start,2 - game running,3 - game over 
		
		// === VARS USED IN STEP FUNCTION ===
		private var lastTime : Number;
		
		private var distance : Number = 0;
		
		public function Game(menu : MainMenu) 
		{
			mainMenu = menu;
			
			if(instance != null)
				throw new Error("Only one Singleton instance should be initiated");
			
			topFiller = new Sprite();
			topFiller.graphics.beginFill(0x2b425d, 1);
			topFiller.graphics.drawRect(0, 0, 1000, 450);
			topFiller.graphics.endFill();
			
			botFiller = new Sprite();
			botFiller.graphics.beginFill(0x2f9d8c, 1);
			botFiller.graphics.drawRect(0, 400, 1000, 1000);
			botFiller.graphics.endFill();
			
			bgFiller = new Sprite();
			bgFiller.graphics.beginFill(0x000000, 0.7);
			bgFiller.graphics.drawRect(0, 0, 1000, 1000);
			bgFiller.graphics.endFill();
			
			gameOverFiller = new Sprite();
			gameOverFiller.graphics.beginBitmapFill(Assets.GAME_OVER_SHADER_DATA, null, false, true);
			gameOverFiller.graphics.drawRect(0, 0, Assets.GAME_OVER_SHADER_DATA.width, Assets.GAME_OVER_SHADER_DATA.height);
			gameOverFiller.graphics.endFill();
			
			gameOverFiller.x = 640 / 2 - (gameOverFiller.width / 2);
			gameOverFiller.y = 480 / 2 - (gameOverFiller.height / 2);
			
			retryButton = new Sprite();
			retryButton.graphics.beginBitmapFill(Assets.RETRY_BUTTON_DATA, null, false, true);
			retryButton.graphics.drawRect(0, 0, Assets.RETRY_BUTTON_DATA.width, Assets.RETRY_BUTTON_DATA.height);
			retryButton.graphics.endFill();
			
			retryButton.y = 310;
			retryButton.x = 640 / 2 - 2 - retryButton.width;
			
			menuButton = new Sprite();
			menuButton.graphics.beginBitmapFill(Assets.MAIN_MENU_BUTTON_DATA, null, false, true);
			menuButton.graphics.drawRect(0, 0, Assets.MAIN_MENU_BUTTON_DATA.width, Assets.MAIN_MENU_BUTTON_DATA.height);
			menuButton.graphics.endFill();
			
			menuButton.y = 310;
			menuButton.x = 640 / 2 +2;
			
			tutFiller = new Sprite();
			tutFiller.graphics.beginBitmapFill(Assets.TUT_SHADER_DATA, null, false, true);
			tutFiller.graphics.drawRect(0, 0, Assets.TUT_SHADER_DATA.width, Assets.TUT_SHADER_DATA.height);
			tutFiller.graphics.endFill();
			
			tutFiller.x = 640 / 2 - (tutFiller.width / 2);
			tutFiller.y = 480 / 2 - (tutFiller.height / 2);
			
			distanceText = new TextField();
			distanceText.textColor = 0xFFFFFF;
			distanceText.text = distance + " m.";
			
			distanceText.x = 640 / 2 - 15;
			distanceText.y = 10;
			
			initializeGame();
			registerStart();
		}
		
		public function initializeGame() : void
		{
			world = new World();
			player = new Player(this); 
			
			BG1 = new BackGround(0, 0, 117, 0);
			BG2 = new BackGround(878, 0, 117, 0);
		}
		
		public function registerStart() : void
		{
			gameState = 1;
			
			addChild(topFiller);
			addChild(botFiller);
			
			addChild(BG1);
			addChild(BG2);
			
			addChild(world);
			world.addWorld();
			
			addChild(player);
			
			addChild(bgFiller);
			addChild(tutFiller);
		}
		
		public function registerRunning() : void
		{
			removeChild(bgFiller);
			removeChild(tutFiller);
			
			addChild(distanceText);
			
			lastTime = getTimer();
			gameState = 2;
			
			addEventListener(Event.ENTER_FRAME, stepRunning);
		}
		
		public function registerGameOver() : void
		{
			gameState = 3;
			
			if (hasEventListener(Event.ENTER_FRAME)) 
				removeEventListener(Event.ENTER_FRAME, stepRunning);
				
			addChild(bgFiller);
			addChild(gameOverFiller);
			addChild(retryButton);
			addChild(menuButton);
			
			distanceText = new TextField();
			addChild(distanceText);

			var format : TextFormat = new TextFormat();
			format.size = 24;
			format.color = 0xFFFFFF;

			distanceText.defaultTextFormat = format;
			distanceText.x = 640 / 2 - (distanceText.width / 2);
			distanceText.y = 480 / 2 - (distanceText.height / 2) + 50;
			
			distanceText.text = distance.toFixed(1) + " m.";

			
			retryButton.buttonMode = true;
			retryButton.useHandCursor = true;
			retryButton.addEventListener(MouseEvent.CLICK, clickButton);
			
			menuButton.buttonMode = true;
			menuButton.useHandCursor = true;
			menuButton.addEventListener(MouseEvent.CLICK, clickButton);
			
			mainMenu.telnetClient.sendScore(distance);
		}
 
		// Handle game logic and update display
		public function stepRunning(deltaTime : Number) : void 
		{
			deltaTime = getTimer() - lastTime;
			lastTime += deltaTime;
			
			player.update(deltaTime / 1000);
			
			world.updateWorld(deltaTime/1000);
			BG1.update(deltaTime / 1000);
			BG2.update(deltaTime / 1000);
			
			distance += 50 * (deltaTime / 1000);
			
			distanceText.text = distance.toFixed(1) + " m.";
		}
		
		public function clickButton(event : MouseEvent) : void
		{
			switch (event.target)
			{
				case retryButton:
				{
					initializeGame();
					registerStart();
					break;
				}
				case menuButton:
				{
					mainMenu.returnToMainMenu();
					break;
				}
			}
		}
		
		// Handle keyboard input
		public function input(keyCode : int) : void 
		{			
			if (gameState == 1 && (keyCode == 87 || keyCode == 38))
				registerRunning();
			
			if (gameState == 2)
				player.receiveInput(keyCode);
		}
		
		public function getWorld() : World
		{
			return world;
		}
	}

}