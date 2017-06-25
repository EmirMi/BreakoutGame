package  
{
	public class Utils 
	{
		public static const TO_RAD:Number = Math.PI/180;
		public static const TO_DEG:Number = 180/Math.PI;

		public static function getRandom(min:Number, max:Number):Number
		{
			return Math.random() * (max - min) + min;
		}
		
		public function Utils() 
		{
			throw new Error("Not meant to be instatiated!");
		}
	}
}
