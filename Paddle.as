package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	
	
	public class Paddle extends MovieClip
	{
		public var _velX:Number;
		public var _lengthPaddle:Number;
		
		public function Paddle(lengthPaddle:Number) 
		{
			_lengthPaddle = length;
			_velX = 0;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function tick():void
		{
			x += _velX;
			checkBoundaries();
		}
		
		public function checkBoundaries():void
		{
			if (x <= 0)
			{
				x = 0;
			}
			else if (x + width > stage.stageWidth)
			{
				x = stage.stageWidth - width;
			}
		}
		
		private final function onKeyPress(e:KeyboardEvent):void
		{
			if(e.keyCode == Keyboard.LEFT)
			{
				_velX = -7;
			}
			else if(e.keyCode == Keyboard.RIGHT)
			{
				_velX = 7;
			}
		}	
		
		public function onKeyRelease(e:KeyboardEvent):void
		{
			if(e.keyCode == Keyboard.LEFT || e.keyCode == Keyboard.RIGHT)
			{
				_velX = 0;
			}
		}

		public function onAddedToStage(e:Event):void
		{
			{
				y = 440;
				x = (stage.stageWidth/2) - (width/2);
			}
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyRelease);
		}
	}
}

