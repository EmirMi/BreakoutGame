package  
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	public class SimpleSound
	{
		private var _soundChannel:SoundChannel;
		private var _soundTransform:SoundTransform;
		public var _isPlaying:Boolean = false;
		public var _sound:Sound = new Sound();
		public var _position:Number = 0;
		var _channel:SoundChannel = null;

		public function SimpleSound(url:String) 
		{
			_sound.load(new URLRequest(url));
		}
		
		public function playMusic():void
		{
			_soundChannel = _sound.play();
			_isPlaying = true;
		}
		
		public function stop():void
		{
			_soundChannel.stop();
			_isPlaying = false;
		}
		
		public function pause():void
		{
			_position = _channel.position;
			_channel.stop();
			_isPlaying = false;
		}
	}	
}

