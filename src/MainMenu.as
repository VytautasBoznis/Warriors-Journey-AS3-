package  
{
	import flash.utils.*;
	import flash.events.*;
	import flash.text.*;
	import flash.display.Sprite;
	import grafics.*;
	import networking.*;
	
	/**
	 * @version 1.0
	 * @author Ideo
	 */
	
	public class MainMenu extends Sprite
	{
		// === GAME OBJECT ===
		private var game : Game;
		
		// === DRAW STATE INTEGER ===
		private var drawState : int; // 0 - Main Menu, 1 - Scores, 2 - Credits. Shows what is drown on the screen.
		
		// === USED OBJECT CLASSES ===
		private static var instance : MainMenu = null;
		
		private var filler : Sprite;
		private var BG1 : BackGround;
		private var BG2 : BackGround;
		
		// === GUI SPRITES ===
		// Main Menu
		private var menuShader : Sprite;
		private var startButton : Sprite;
		private var scoresButton : Sprite;
		private var creditsButton : Sprite;
		// Credits
		private var creditsShader : Sprite;
		// Scores
		private var showingPrivate : Boolean = true;
		private var textFormat : TextFormat;
		private var textFieldTop : TextField;
		private var textFieldScores : TextField;
		private var refreshButton : Sprite;
		private var backButton : Sprite;
		private var personalButton : Sprite;
		private var globalButton : Sprite;
		
		// === VARS USED IN STEP FUNCTION ===
		private var lastTime : Number;
		private var bgSpeed : Number = 117;
		// === SOCKETS FOR SERVER CONNECTION ===
		public var telnetClient : Telnet;
		
		/**
		 * creates a basic MainMenu object 
		 * from this object all other screens are created.
		 */
		
		public function MainMenu() 
		{
			if(instance != null)
				throw new Error("Only one Singleton instance should be initiated");
			
			telnetClient = new Telnet();

			initializeMainMenu();
			showMainMenu();
		}
		
		/**
		 * Called only in Main.mxml used as a basic object from witch
		 * all other game calls are done.
		 * 
		 * @return MainMenu object.
		 */
		
		public static function getInstance() : MainMenu 
		{
			if (instance == null)
				instance = new MainMenu();

			return instance;
		}
		
		/**
		 * Called when the main screen should be show ex. :on start,
		 * getting back from scores, etc.
		 */
		
		public function initializeMainMenu() : void 
		{

			// === Object creation ===
			
			filler = new Sprite();
			
			BG1 = new BackGround(0, 0,bgSpeed, 0);
			BG2 = new BackGround(878, 0,bgSpeed, 0);
			
			menuShader = new Sprite();
			startButton = new Sprite();
			scoresButton = new Sprite();
			creditsButton = new Sprite();
			
			creditsShader = new Sprite();
						
			// === Sprite graphics fill / button configuration ===
			
			menuShader.graphics.beginBitmapFill(Assets.MENU_SHADER_DATA, null, false, true);
			menuShader.graphics.drawRect(0, 0, Assets.MENU_SHADER_DATA.width, Assets.MENU_SHADER_DATA.height);
			menuShader.graphics.endFill();
			
			startButton.graphics.beginBitmapFill(Assets.START_BUTTON_DATA, null, false, true);
			startButton.graphics.drawRect(0, 0, Assets.START_BUTTON_DATA.width, Assets.START_BUTTON_DATA.height);
			startButton.graphics.endFill();
			
			startButton.buttonMode = true;
			startButton.useHandCursor = true;
			startButton.addEventListener(MouseEvent.CLICK, clickButton);
			
			scoresButton.graphics.beginBitmapFill(Assets.SCORES_BUTTON_DATA, null, false, true);
			scoresButton.graphics.drawRect(0, 0, Assets.SCORES_BUTTON_DATA.width, Assets.SCORES_BUTTON_DATA.height);
			scoresButton.graphics.endFill();
			
			scoresButton.buttonMode = true;
			scoresButton.useHandCursor = true;			
			scoresButton.addEventListener(MouseEvent.CLICK, clickButton);
			
			creditsButton.graphics.beginBitmapFill(Assets.CREDITS_BUTTON_DATA, null, false, true);
			creditsButton.graphics.drawRect(0, 0, Assets.CREDITS_BUTTON_DATA.width, Assets.CREDITS_BUTTON_DATA.height);
			creditsButton.graphics.endFill();
			
			creditsButton.buttonMode = true;
			creditsButton.useHandCursor = true;			
			creditsButton.addEventListener(MouseEvent.CLICK, clickButton);
			
			filler.graphics.beginFill(0x2b425d, 1);
			filler.graphics.drawRect(0, 0, 1000, 1000);
			filler.graphics.endFill();
			
			// Credits asset Initialization
			
			creditsShader.graphics.beginBitmapFill(Assets.CREDITS_SHADER_DATA, null, false, true);
			creditsShader.graphics.drawRect(0, 0, Assets.CREDITS_SHADER_DATA.width, Assets.CREDITS_SHADER_DATA.height);
			creditsShader.graphics.endFill();
			creditsShader.addEventListener(MouseEvent.CLICK, clickButton);
			
			drawState = 0;
						
			addEventListener(Event.ENTER_FRAME, step);
		}
		
		/**
		 * Used when switching screens ex.: Main Menu -> Game
		 * Saves used memory by removing, for now non-usable objects.
		 */
		
		public function nullifyMainMenu() : void
		{
			removeEventListener(Event.ENTER_FRAME, step);
			
			removeChild(creditsButton);
			removeChild(scoresButton);
			removeChild(startButton);
			removeChild(menuShader);
			
			removeChild(BG1);
			removeChild(BG2);
			
			BG1 = null;
			BG2 = null;
			
			menuShader = null;
			startButton = null;
			scoresButton = null;
			creditsButton = null;
		}
		
		/**
		 * Formats and displays the Main Menu screen
		 */
		
		public function showMainMenu() : void
		{
			// === Sprite positioning on screen / display configuration ===
			
			drawState = 0;
			
			menuShader.x = 640 / 2 - (menuShader.width / 2);
			menuShader.y = 480 / 2 - (menuShader.height / 2);
			
			startButton.x = 205;
			startButton.y = 140;
			
			scoresButton.x = 205;
			scoresButton.y = 215;
			
			creditsButton.x = 205;
			creditsButton.y = 290;
			
			addChild(filler);
			addChild(BG1);
			addChild(BG2);
			addChild(menuShader);
			
			addChild(startButton);
			addChild(scoresButton);
			addChild(creditsButton);
			
			// === Step function start ===
			
			lastTime = 0;
			
		}
		
		/**
		 * Removes all the child objects from showMainMenu().
		 * After this method another screen should be initialized (scores or credits).
		 */
		
		public function removeMainMenu() : void
		{
			removeChild(BG1);
			removeChild(BG2);
			removeChild(menuShader);
			
			removeChild(startButton);
			removeChild(scoresButton);
			removeChild(creditsButton);
		}
		
		/**
		 * Starts the game Screen.
		 */
		
		public function startGame() : void
		{
			nullifyMainMenu();
			game = new Game(this);
			
			addChild(game);
		}
		
		public function returnToMainMenu() : void
		{
			removeChild(game);
			initializeMainMenu();
			showMainMenu();
			game = null;
		}
		
		/**
		 * Formats and displays score data.
		 * The data it self is stored online.
		 * Data is accesible via ScoreData object.
		 */
		 
		public function showScores() : void
		{
			drawState = 1;
			
			addChild(BG1);
			addChild(BG2);
			addChild(menuShader);
			
			textFormat = new TextFormat();
			textFieldTop = new TextField();
			textFieldScores = new TextField();
			refreshButton = new Sprite();
			backButton = new Sprite();
			personalButton = new Sprite();
			globalButton = new Sprite();
			
			var scores : Vector.<int>;
			var scoreString : String;
			
			addChild(textFieldTop);
			addChild(textFieldScores);
			
			textFormat.color = 0xff331f1f;
			textFormat.size = 18;
			
			textFieldScores.defaultTextFormat = textFormat;
			textFieldTop.defaultTextFormat = textFormat;
			
			if (showingPrivate)
			{
				textFieldTop.text = "Showing TOP personal scores";
				textFieldTop.width = textFieldTop.textWidth+5;
				scores = telnetClient.getBestScores(10,false);
				scoreString = "";
			}
			else
			{
				textFieldTop.text = "Showing TOP global scores";
				textFieldTop.width = textFieldTop.textWidth + 5;
				scores = telnetClient.getBestScores(10,true);
				scoreString = "";
			}
			
			if (scores.length > 0)
			{
				for (var i : int = 0; i < scores.length; i++)
					scoreString += i + 1 + " ... " + scores[i] + " m.\n";
				
				textFieldScores.text = scoreString;
				textFieldScores.width = textFieldScores.textWidth + 5;
				textFieldScores.height = textFieldScores.textHeight +5;
				
				textFieldScores.x = 640 / 2 - (textFieldScores.width / 2);
				textFieldScores.y = 480 / 2 - (textFieldScores.textHeight / 2);
			}
			else
			{
				scoreString += " === None === ";
				textFieldScores.text = scoreString;
				textFieldScores.width = textFieldScores.textWidth + 5;
				textFieldScores.x = 640 / 2 - (textFieldScores.width / 2);
				textFieldScores.y = 480 / 2 - (textFieldScores.textHeight / 2);
			}
			
			textFieldTop.x = 640 / 2 - (textFieldTop.width / 2);
			textFieldTop.y = 480 / 3 - (textFieldTop.height / 3) - 10;
			
			refreshButton.graphics.beginBitmapFill(Assets.REFRESH_BUTTON_DATA, null, false, false);
			refreshButton.graphics.drawRect(0, 0, Assets.REFRESH_BUTTON_DATA.width, Assets.REFRESH_BUTTON_DATA.height);
			refreshButton.graphics.endFill();
			
			personalButton.graphics.beginBitmapFill(Assets.PERSONAL_BUTTON_DATA, null, false, false);
			personalButton.graphics.drawRect(0, 0, Assets.PERSONAL_BUTTON_DATA.width, Assets.PERSONAL_BUTTON_DATA.height);
			personalButton.graphics.endFill();
			
			globalButton.graphics.beginBitmapFill(Assets.GLOBAL_BUTTON_DATA, null, false, false);
			globalButton.graphics.drawRect(0, 0, Assets.GLOBAL_BUTTON_DATA.width, Assets.GLOBAL_BUTTON_DATA.height);
			globalButton.graphics.endFill();
			
			backButton.graphics.beginBitmapFill(Assets.MINI_BACK_BUTTON_DATA, null, false, false);
			backButton.graphics.drawRect(0, 0, Assets.MINI_BACK_BUTTON_DATA.width, Assets.MINI_BACK_BUTTON_DATA.height);
			backButton.graphics.endFill();
			
			refreshButton.buttonMode = true;
			refreshButton.useHandCursor = true;
			refreshButton.addEventListener(MouseEvent.CLICK, clickButton);
			
			personalButton.buttonMode = true;
			personalButton.useHandCursor = true;
			personalButton.addEventListener(MouseEvent.CLICK, clickButton);
			
			globalButton.buttonMode = true;
			globalButton.useHandCursor = true;
			globalButton.addEventListener(MouseEvent.CLICK, clickButton);
			
			backButton.buttonMode = true;
			backButton.useHandCursor = true;
			backButton.addEventListener(MouseEvent.CLICK, clickButton);
			
			refreshButton.x = 640 / 2 - 170;
			refreshButton.y = 385 - 40;
			
			backButton.x = 640 / 2 + 70;
			backButton.y = 385 - 40;
			
			globalButton.x = 640 / 2 + 100;
			globalButton.y = 95 + 70;
			
			personalButton.x = 640 / 2 + 100;
			personalButton.y = 95 + 100;
			
			addChild(refreshButton);
			addChild(backButton);
			addChild(globalButton);
			addChild(personalButton);
		}
		
		/**
		 * Removes all display childs from showScores()
		 * after this method showMainMenu() should be called.
		 */
		
		public function removeScores() : void
		{
			removeChild(BG1);
			removeChild(BG2);
			removeChild(menuShader);
			removeChild(textFieldTop);
			removeChild(textFieldScores);
			removeChild(refreshButton);
			removeChild(personalButton);
			removeChild(globalButton);
			removeChild(backButton);
		}
		
		public function nullifyScores() : void
		{
			textFieldTop = null;
			textFieldScores = null;
			refreshButton = null;
			personalButton = null;
			globalButton = null;
			backButton = null;
		}
		
		/**
		 * Formats and displays the Credits screen.
		 */
		
		public function showCredits() : void
		{
			drawState = 2;
			
			creditsShader.x = 640 / 2 - (creditsShader.width / 2);
			creditsShader.y = 480 / 2 - (creditsShader.height / 2);
			
			addChild(filler);
			addChild(BG1);
			addChild(BG2);
			addChild(creditsShader);
		}
		
		/**
		 * Removes all display childs from showCredits()
		 * after this method showMainMenu() should be called.
		 */
		
		public function removeCredits() : void
		{
			removeChild(BG1);
			removeChild(BG2);
			
			removeChild(creditsShader);
		}
		
		/**
		 * Used in all screens as a basic click event handler.
		 * 
		 * @param	event - the mouse click event
		 */
		
		public function clickButton(event : MouseEvent) : void
		{
			switch(drawState)
			{
				case 0: //If Main Menu is drown on screen.
				{
					switch (event.target)
					{
						case startButton:
							{
								//telnetClient.sendMessage("start");
								startGame();
								break;
							}
						case scoresButton:
							{
								removeMainMenu();
								showScores();
								break;
							}
						case creditsButton:
							{
								removeMainMenu();
								showCredits();
								break;
							}
					}
					break;
				}
				case 1: //if scores are drawn on screen
				{
					switch(event.target)
					{
						case backButton:
						{
							removeScores();
							nullifyScores();
							showMainMenu();
							break;
						}
						case refreshButton:
						{
							if(showingPrivate)
								telnetClient.getBestScores(10, false);
							else
								telnetClient.getBestScores(10, true);
							
							removeScores();
							showScores();
							break;
						}
						case personalButton:
						{
							if (!showingPrivate)
							{
								telnetClient.getBestScores(10, false);
								showingPrivate = true;
								removeScores();
								showScores();
							}							
							break;
						}
						case globalButton:
						{
							if (showingPrivate)
							{
								telnetClient.getBestScores(10, true);
								showingPrivate = false;
								removeScores();
								showScores();
							}
							break;
						}
					}
					break;
				}
				case 2: //if credits are drawn on screen
				{
					removeCredits();
					showMainMenu();
				}
			}
		}
		
		/**
		 * Invoked in Main.mxml passes the pressed keys code.
		 * 
		 * From here it's forwarded to the active screen,
		 * if it is needed by the screen it self
		 * 
		 * NOTE! can't nullify MainMenu fully becose of this even if it stays
		 * non active.
		 * 
		 * @param	keyCode - code of the key pressed
		 */
		
		public function input(keyCode : int) :void
		{
			if (game != null)
				game.input(keyCode);
		}
		
		/**
		 * Starting point of all updates.
		 * Invoked from constructor.
		 * Invoked every X FPS.
		 * X - the number of FPS set in Main.mxml 
		 * 
		 * @param	deltaTime - time past the last update.
		 */
		
		public function step(deltaTime : Number) : void 
		{			
			deltaTime = getTimer() - lastTime;
			lastTime += deltaTime;
			
			BG1.update(deltaTime/1000);
			BG2.update(deltaTime/1000);
		}		
	}

}