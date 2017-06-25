package  
{
	import flash.display.Sprite;
	import flash.events.Event;
		
	public class FSM extends Sprite 
	{
		private var _currentState:State;
		
		public function FSM() 
		{
			_currentState = null;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			var firstState:State = new MenuState(this); 
			setState(firstState);
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(e:Event):void
		{
			_currentState.update();
		}
		
		public function setState(s:State):void
		{
		if(_currentState != null)
			{
				_currentState.exit();
			}
			_currentState = s;
			_currentState.enter();
		}
	}
	
}
