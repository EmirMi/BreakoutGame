package  
{
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	
	
	public class Ball extends MovieClip
	{
		public var _velX:Number;
		public var _velY:Number;
		public var _gameOn:Boolean = false;
		private var _whistle:SimpleSound = new SimpleSound("whistle.mp3");
		private var _wallhit:SimpleSound = new SimpleSound("wallhit.mp3");
		
		public function Ball()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function onAddedToStage(e:Event):void
		{
			reset();
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function reset():void
		{
			x = (stage.stageWidth / 2) - (width / 2);
			y = 428;
			_velX = 0;
			_velY = 0;
			_gameOn = false
			stage.addEventListener(KeyboardEvent.KEY_DOWN, serve);
		}
		
		public function serve(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.SPACE && _gameOn == false)
			{
				var angle = Utils.getRandom(Math.PI*0.25, Math.PI*0.75);
				_velX = Math.cos(angle) * 8;
				_velY = Math.sin(angle) * 8;
				_gameOn = true;
				_whistle.playMusic();
			}
		}
		
		public function tick():void
		{
			x += _velX;
			y += _velY;
			checkBoundaries();
		}

		public function checkBoundaries():void
		{
			if (x <= 0)
			{
				x = x + 3;
				_velX = _velX * -1;
				_wallhit.playMusic();
			}
			else if (x + width > stage.stageWidth)
			{
				x = x - 3;
				_velX = _velX * -1;
				_wallhit.playMusic();
			}
			if (y <= 0)
			{
				_velY = _velY * -1;
				_wallhit.playMusic();
			}
			else if (y + height > stage.stageHeight + height)
			{	
				y = stage.stageHeight - height;
				_velY = _velY * -1;
			}
		}
	}
	
}
