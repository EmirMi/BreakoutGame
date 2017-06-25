package  
{
	import flash.display.MovieClip;
	import flash.utils.setTimeout;
	
	public class Boom extends MovieClip
	{	
		
		
		public function Boom(x:Number, y:Number)
		{
			setTimeout(removeGFX, 300);
		}
			
			
		public function removeGFX():void
			{
				visible = false;
			}

	}
		
}
	

