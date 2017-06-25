package
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	
	public class InfoState extends State
	{
		private var _info:MovieClip = null;
		
		public function InfoState(fsm:FSM)
		{
			super(fsm);
		}

		override public function enter():void
		{
			_info = new InfoBackground();
			_fsm.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			_fsm.addChild(_info);
			_fsm.stage.focus = _fsm.stage;
		}
		
		private function onKeyPress(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.ESCAPE)
			{
				_fsm.setState (new MenuState(_fsm));
			}
		}
		
		override public function update():void
		{
			
		}
		
		override public function exit ():void
		{
			_fsm.removeChild(_info);
			_info = null;
			_fsm.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
		}
	}	
}


