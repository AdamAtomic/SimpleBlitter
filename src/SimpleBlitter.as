package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	[SWF(width="800", height="600", backgroundColor="#ffffff")]

	public class SimpleBlitter extends Sprite 
	{
		//game engine variables
		public var canvas:Bitmap;
		public var left:Boolean;
		public var right:Boolean;
		
		//variables for our main character "Redbox"
		public var redBox:BitmapData;
		public var redBoxX:int;
		public var redBoxY:int;
		
		public function SimpleBlitter():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);

			//some basic event listeners
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);

			//create our main canvas or buffer
			canvas = new Bitmap(new BitmapData(stage.stageWidth,stage.stageHeight));
			addChild(canvas);
			
			//clear the controls
			left = right = false;
			
			//create our main character "redbox" in the middle of the screen
			redBox = new BitmapData(20, 40, true, 0xFFFF0000);
			redBoxX = 390;
			redBoxY = 280;
		}
		
		//called every time flash updates its visuals
		private function onEnterFrame(e:Event = null):void
		{
			//clear our canvas our buffer so we can redraw redbox in her new position
			//otherwise she will leave a trail - comment this out to see that in action
			canvas.bitmapData.fillRect(new Rectangle(0, 0, canvas.width, canvas.height), 0xFFFFFFFF);
			
			//redbox's movement and drawing logic
			if (left)
				redBoxX = redBoxX - 5;
			if (right)
				redBoxX = redBoxX + 5;
			canvas.bitmapData.copyPixels(redBox, new Rectangle(0, 0, redBox.width, redBox.height), new Point(redBoxX,redBoxY));
		}
		
		//keyboard event listener - checks arrow keys and marks flags accordingly
		private function onKeyDown(e:KeyboardEvent = null):void
		{
			if (e.keyCode == 37)
				left = true;
			else if (e.keyCode == 39)
				right = true;
		}
		
		//keyboard event listener - checks arrow keys and marks flags accordingly
		private function onKeyUp(e:KeyboardEvent = null):void
		{
			if (e.keyCode == 37)
				left = false;
			else if (e.keyCode == 39)
				right = false;
		}
	}
	
}