package  
{
	import flash.display.MovieClip;
	import flash.utils.setTimeout;
	
	public class Life extends MovieClip
	{	

		public function Life(x:Number, y:Number)
		{
			setTimeout(removeGFX, 300);
		}
			
			
		public function removeGFX():void
			{
				visible = false;
			}

	}
		
}