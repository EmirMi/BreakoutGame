package 
{
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.display.SimpleButton;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	public class PlayState extends State
	{
		private var _game:Main= null;
		private var _onPause:Boolean = false;
		private var _pause = new PauseBackground();
		
		public function PlayState(fsm:FSM)
		{
			super(fsm);
		}
		
		override public function enter():void
		{
			_game = new Main();
			//_bg = new GameBackground();
			_fsm.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			_game.addEventListener(Main.GAME_OVER, gameOver);
			_fsm.stage.focus = _fsm.stage;
			_fsm.addChild(_game);
		}
		
		private function onKeyPress(e:KeyboardEvent):void
		{
			if(_onPause == true)
			{
				if(e.keyCode == Keyboard.ESCAPE)
				{
					_fsm.setState(new MenuState(_fsm));
					_fsm.removeChild(_pause);
					_onPause = false;
				}
			}

			if(e.keyCode == Keyboard.P)
			{
				if(_onPause == false)
				{
					_fsm.addChild(_pause);
					_pause.x = _fsm.stage.stageWidth*0.5;
					_pause.y = _fsm.stage.stageHeight*0.5;
					_game.gamePause();
					_onPause = true;
				}
				else
				{
					_fsm.removeChild(_pause);
					_game.gamePause();
					_onPause = false;
				}
			}
		}
		
		
		override public function update():void
		{
			
		}
		
		private function gameOver(e:Event):void
		{
			_game.cleanUp();			
			_fsm.setState(new GameOverState(_fsm, Main._points));
		}
		
		override public function exit():void
		{
			_fsm.removeChild(_game);
			_fsm.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			_game.removeEventListener(Main.GAME_OVER, gameOver);
		}
	}
}
