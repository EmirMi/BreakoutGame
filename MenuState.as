package 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.display.SimpleButton;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	public class MenuState extends State
	{
		private var _menu:MovieClip = null;
		private var _playButton:SimpleButton = null;
		private var _infoButton:SimpleButton = null;
		private var _backgroundMusic:SimpleSound = new SimpleSound("intro.mp3");
		
		public function MenuState(fsm:FSM)
		{
			_menu =null;
			super(fsm);
		}
		
		override public function enter():void
		{
			_backgroundMusic.playMusic();
			_menu = new SplashScreen();
			_playButton = _menu.playButton;
			_playButton.addEventListener(MouseEvent.CLICK, playButtonClick);		
			_infoButton = _menu.infoButton;
			_infoButton.addEventListener(MouseEvent.CLICK, infoButtonClick);	
			_menu.addEventListener(MouseEvent.CLICK, infoButtonClick);
			_fsm.addChild(_menu);
			_fsm.stage.focus = _fsm.stage;
		}
		
		public function playButtonClick(e:MouseEvent):void
		{
			var playState:State = new PlayState(_fsm);
			_fsm.setState(playState);
		}
		
		public function infoButtonClick(e:MouseEvent):void
		{
			var infoState:State = new InfoState(_fsm);
			_fsm.setState(infoState);
		}
		
		override public function update():void
		{

		}
		
		override public function exit():void
		{
			_fsm.removeChild(_menu);
			_backgroundMusic.stop();
			_playButton.removeEventListener(MouseEvent.CLICK, playButtonClick);
			_infoButton.removeEventListener(MouseEvent.CLICK, infoButtonClick);
			_menu.removeEventListener(MouseEvent.CLICK, infoButtonClick);
			_menu = null;
		}
	}
}
