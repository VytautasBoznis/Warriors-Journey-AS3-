package grafics 
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.sampler.NewObjectSample;
	
	/**
	* @author Ideo
	*/

	public class Animation extends Sprite
	{
		private var timePerFrame : Number;
		private var timeRunning : Number;
		private var currentFrame : Number;
		private var numFrames : Number;
		private var frameWidth : Number;
		private var transformMatrix : Matrix;
		private var bmp : BitmapData;		
		
		public function Animation(bmp : BitmapData,numFrames:Number,fps:Number)
		{
			super();
			timePerFrame = 1.0 / fps;
			timeRunning = 0.0;
			currentFrame = 0;
			frameWidth = bmp.rect.width / numFrames;
			this.numFrames = numFrames;
			this.bmp = bmp;
			transformMatrix = new Matrix();
 
			this.graphics.beginBitmapFill(bmp, transformMatrix, false, false);
			this.graphics.drawRect(0, 0, frameWidth, bmp.rect.height);
			this.graphics.endFill();
		}
		
		public function step(deltaTime : Number) : void
		{
			timeRunning += deltaTime;
			
			while (timeRunning >= timePerFrame)
			{
				timeRunning -= timePerFrame;
				currentFrame++;
				
				if (currentFrame >= numFrames)
					currentFrame = 0;
				
					
				transformMatrix.tx = -frameWidth * currentFrame;
					
				this.graphics.clear();
				this.graphics.beginBitmapFill(bmp, transformMatrix, false, false);
				this.graphics.drawRect(0, 0, frameWidth, bmp.height);
				this.graphics.endFill();
			}
		}	
	}

}