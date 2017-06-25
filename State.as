package  
{
	
	public class State 
	{
		protected var _fsm:FSM;
		
		public function State(fsm:FSM) 
		{
			_fsm = fsm;
		}
		
		public function enter():void
		{
			trace("WARNING: State::enter() is being called");
		}
		
		public function update():void
		{
			trace("WARNING: State::update() is being called");
		}
		
		public function exit():void
		{
			trace("WARNING: State::exit() is being called");
		}

	}
	
}
