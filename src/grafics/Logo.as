package grafics
{
	import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import flash.text.*;
 
	/**
	 * @author Ideo
	 */
	
    public final class Logo extends Sprite 
	{
 
        // constants used by "state" variable
        private static const FADE_IN : uint = 0;
        private static const NORM : uint = 1;
        private static const FADE_OUT : uint = 2;
        private static const DONE : uint = 3;
 
        // animation times in seconds
        private static const FADE_IN_TIME : Number = 1.5;
        private static const NORM_TIME : Number = 2.0;
        private static const FADE_OUT_TIME : Number = 1.5;
 
        // determines current animation phase
        private var state : uint = FADE_OUT;
 
        // the time of the last frame
        private var lastTime : Number = 0.0;
 
        // total time this animation phase
        private var phaseTime : Number = 0.0;
 
        // a black rectangle that will cover up the logo
        private var blackFade : Sprite;
 
        // the "click to start" message
        private var txt : TextField;
 
        /*
         * Create a logo and start animating it.
         */
        public function Logo() 
		{
 
            // Add the logo to this sprite
            this.graphics.beginBitmapFill(Assets.LOGO_DATA, null, false, false);
            this.graphics.drawRect(0, 0, Assets.LOGO_DATA.rect.width,
                Assets.LOGO_DATA.rect.height);
            this.graphics.endFill();
 
            // Create a new rectangle sprite the size of the logo,
            // and fill it in all black
            blackFade = new Sprite();
            blackFade.graphics.beginFill(0);
            blackFade.graphics.drawRect(0, 0, Assets.LOGO_DATA.rect.width,
                Assets.LOGO_DATA.rect.height);
            blackFade.graphics.endFill();
 
            // Add the rectangle sprite above the logo
            addChild(blackFade);
 
            // Set the last frame time and start calling "enterFrame"
            // every frame
            lastTime = getTimer();
            addEventListener(Event.ENTER_FRAME, enterFrame);
 
            // Add a text field to this sprite instructing the player
            // to click the screen
            txt = new TextField();
 
            // Make the font Arial, Black, and size 24
            var format:TextFormat = new TextFormat();
            format.font = "Arial";
            format.color = 0xFFFFFF;
            format.size = 24;
            txt.defaultTextFormat = format;
 
            // Place the text near the center, bottom of the screen
            txt.autoSize = TextFieldAutoSize.CENTER;
            txt.x = Assets.LOGO_DATA.rect.width / 2;
            txt.y = Assets.LOGO_DATA.rect.height - 50;
            txt.selectable = false;
            txt.text = "Click to Start";
            txt.alpha = 1.0;
        }
 
        /*
         * Fade the logo in from solid black, pause briefly, and then
         * fade back to black.
         */
        private function enterFrame(event : Event) : void
		{
 
            // Calculate the amount of time that's passed since the
            // last frame
            var timeDiff : Number = getTimer() - lastTime;
            lastTime += timeDiff;
            phaseTime += timeDiff / 1000.0;
 
            // Fade in
            if (state == FADE_IN) 
			{
                if (phaseTime > FADE_IN_TIME) 
				{
                    state = DONE;
                    blackFade.alpha = 1.0;
                    removeEventListener(Event.ENTER_FRAME, enterFrame);
                }
                else
				{
                    blackFade.alpha = phaseTime / FADE_IN_TIME;
                }
            }
 
            // Fade out
            if (state == FADE_OUT)
			{
                if (phaseTime > FADE_OUT_TIME) 
				{
                    state = NORM;
                    addChild(txt);
                    phaseTime -= FADE_OUT_TIME;
                    blackFade.alpha = 0.0;
                }
                else 
				{
                    blackFade.alpha = 1.0 - phaseTime / FADE_OUT_TIME;
                }
            }
 
        }
    }

}