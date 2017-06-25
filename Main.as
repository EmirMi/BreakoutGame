package  
{	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.utils.setTimeout;
	import flash.net.URLLoader;
	import flash.net.XMLSocket;
	import flash.net.URLRequest;
	
	public class Main extends MovieClip
	{
		public var _ball:Ball;
		public var _paddle:Paddle;
		public var _brick:Brick;
		public var _boom:Boom;
		public var _lifeUp:Life;
		private var _bg:MovieClip;
		private var _onPause:Boolean = false;
		public static const GAME_OVER: String = "gameOver";
		public var _scoreField:TextField;
		public var _levelField:TextField;
		public var _livesField:TextField;
		private var _brickWidth:int = 39;
		private var _brickHeight:int = 19;
		private var OFFSET:int = 6;
		private var W_LENGTH:int = 8;
		private var _velX:int;
		private var _velY:int;
		public static var _points:int;
		public static var currentLevel:int;
		private var _bricks:Array = [];
		private var _levels:Array = [];
		public var _lives:int;
		public var _levelComplete:Boolean = false;
		private var _ballhit:SimpleSound = new SimpleSound("ballhit.mp3");
		private var _brickhit:SimpleSound = new SimpleSound("brick.mp3");
		private var _levelup:SimpleSound = new SimpleSound("level up.mp3");
		
		private const LEVEL_1:Array =  [[0,0,0,0,0,0,0,0], 
										[0,0,0,0,0,0,0,0], 
										[0,0,0,0,0,0,0,0], 
										[0,0,0,4,1,0,0,0], 
										[0,0,1,2,3,1,0,0], 
										[0,0,0,1,1,0,0,0], 
										[0,0,0,1,1,0,0,0],  
										[0,0,0,1,1,0,0,0],];
		 
		private const LEVEL_2:Array = [ [0,0,0,0,0,0,0,0], 
										[0,0,0,0,0,0,0,0], 
										[0,0,0,0,0,0,0,0], 
										[0,0,0,0,0,0,0,0], 
										[0,0,0,0,1,0,0,0], 
										[0,0,0,1,4,1,0,0], 
										[0,0,1,1,2,3,2,0], 
										[0,1,1,1,1,1,1,1],]; 
		
		private const LEVEL_3:Array =  [[0,0,0,0,0,0,0,0], 
										[0,0,0,0,0,0,0,0], 
										[0,0,0,0,0,0,0,0], 
										[0,0,0,0,0,0,0,0], 
										[1,2,0,3,1,4,1,2], 
										[0,1,1,1,1,1,1,0], 
										[0,0,1,2,2,1,0,0], 
										[0,0,0,1,1,0,0,0],];
		public function Main():void
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			_ball = new Ball();
			addChild(_ball);
			_paddle = new Paddle(1);
			_paddle.gotoAndStop(1);
			addChild(_paddle);
			_bg = new GameBackground();
			addChild(_bg);
			addEventListener(Event.ADDED_TO_STAGE, init);
			var loader:URLLoader = new URLLoader(new URLRequest("settings.xml"));
			loader.addEventListener(Event.COMPLETE, onXMLLoaded, false, 0, true);
		}
		
		public function init(e:Event):void
		{
			_levels.push(LEVEL_1, LEVEL_2, LEVEL_3);
			buildLevel(LEVEL_1);
			stage.addEventListener(Event.ENTER_FRAME, update);
			_levelField = _bg.levelField;
			_levelField.text = "Level " + ((currentLevel)+1);
			_scoreField = _bg.scoreField;
			_scoreField.text = "Score: 0";
			_livesField = _bg.livesField;
			_livesField.text = "Lives: 5";
		}
		
		public function onXMLLoaded(e:Event):void
		{
			var settings:XML;
			settings = XML(e.target.data);
			currentLevel = int(settings.startlevel[0]);
			_lives = int(settings.lives[0]);
			_points = int(settings.points[0]);
			_velX = int(settings.velx[0]);
			_velY = int(settings.vely[0]);
		}
		
		public function update(e:Event):void
		{
			_ball.tick();
			_paddle.tick();
			score();
		
			if(_paddle.hitTestObject(_ball) && (_ball.x + _ball.width / 2) < _paddle.x)
			{
				_ball._velY = -5;
				_ball._velX = -5;
				_ballhit.playMusic();
			}
			else if(_paddle.hitTestObject(_ball) && (_ball.x + _ball.width / 2) >= _paddle.x)
			{
				_ball._velY = -5;
				_ball._velX = 5;
				_ballhit.playMusic();
			}
			
			for(var i:int = 0; i < _bricks.length; i++)
			{
				if(_ball.hitTestObject(_bricks[i]))
				{
					
					_ball._velY = _ball._velY * -1;
					_boom = new Boom(_ball.x, _ball.y);
					addChild(_boom);
					_brickhit.playMusic();
					
					if(_bricks[i]._color == 1)
					{
						_points++;
						_scoreField.text = "Score: " + _points;						
					}
					else if(_bricks[i]._color == 2)
					{
						_points = _points+5;
						_scoreField.text = "Score: " + _points;	
					}
					else if(_bricks[i]._color == 3)
					{
						_points++;
						_lives++;
						_lifeUp = new Life(_ball.x,_ball.y);
						addChild(_lifeUp);
						_lifeUp.x = _ball.y;
						_lifeUp.y = _ball.y;
						_scoreField.text = "Score: " + _points;	
						_livesField.text = "Lives: " + _lives;
					}
					else if(_bricks[i]._color == 4)
					{
						_points++;
						removeChild(_paddle);
						_paddle = new Paddle(2);
						_paddle.gotoAndStop(2);
						addChild(_paddle);
						_scoreField.text = "Score: " + _points;	
					}
                    if((_ball.x + _ball.width / 2) < (_bricks[i].x + _bricks[i].width / 2)) 
                    { 
                        _ball._velX = -5;
                    } 
                    else if((_ball.x + _ball.width / 2) >= (_bricks[i].x + _bricks[i].width / 2)) 
                    { 
                        _ball._velX = 5;
                    }
										
					removeChild(_bricks[i]);
					_boom.x = _ball.x;
					_boom.y = _ball.y;
					_bricks.splice(i, 1);  
									
				}
				if(_bricks.length < 1)
				{
					_levelComplete = true;
					score();
					
				}

			}
			
		
		}
		
		private final function buildLevel(level:Array):void
		{
			var len:int = level.length;
			for(var i:int = 0; i < len; i++)
			{
				for(var j:int = 0; j < W_LENGTH; j++)
				{
					if(level[i][j] == 1)
					{
						_brick = new Brick(1);
						_brick.x = OFFSET + (_brickWidth * j);
						_brick.y = _brickHeight * i;
						_brick.gotoAndStop(1);
						addChild(_brick);
						_bricks.push(_brick);
					}
						else if(level[i][j] == 2)
					{
						_brick = new Brick(2);
						_brick.x = OFFSET + (_brickWidth * j);
						_brick.y = _brickHeight * i;
						_brick.gotoAndStop(2);
						var _brickNr = 2;
						addChild(_brick);
						_bricks.push(_brick);
					}
						else if(level[i][j] == 3)
					{
						_brick = new Brick(3);
						_brick.x = OFFSET + (_brickWidth * j);
						_brick.y = _brickHeight * i;
						addChild(_brick);
						_brick.gotoAndStop(3);
						_bricks.push(_brick);
					}
						else if(level[i][j] == 4)
					{
						_brick = new Brick(4);
						_brick.x = OFFSET + (_brickWidth * j);
						_brick.y = _brickHeight * i;
						addChild(_brick);
						_brick.gotoAndStop(4);
						_bricks.push(_brick);
					}
				}
			}
		}
		
		public function score():void
		{
			
			if(_ball.y + _ball.height == stage.stageHeight && _lives > 0)
			{
				_lives--;
				_livesField.text = "Lives: " + _lives;
				_paddle.y = 440;
				_paddle.x = (stage.stageWidth/2) - (_paddle.width/2);
				if(_lives == 0)
				{
					gameOver();
					_levelComplete = false;
					_ball._gameOn = false;
					currentLevel = 0;
				}
				else
				{
				_ball.reset();
				}
				_ball._gameOn = false;
			}
			else if(_ball.y + _ball.height == stage.stageHeight && _lives == 0)
			{
				currentLevel = 0;
				changeLevel(_levels[currentLevel]);
				_levelField.text = "Level " + ((currentLevel)+1);
				_paddle.y = 440;
				_paddle.x = (stage.stageWidth/2) - (_paddle.width/2);
				_ball._gameOn = false;
			}

			if(_levelComplete == true && _levels.length > currentLevel+1)
			{
				currentLevel++;
				changeLevel(_levels[currentLevel]);
				_levelup.playMusic();
				removeChild(_paddle);
				_paddle = new Paddle(1);
				_paddle.gotoAndStop(1);
				addChild(_paddle);
				_paddle.y = 440;
				_paddle.x = (stage.stageWidth/2) - (_paddle.width/2);
				_levelField.text = "Level " + ((currentLevel)+1);
				_levelComplete = false;
				_ball._gameOn = false;
			}
			else if(_levelComplete == true && _levels.length <= currentLevel+1)
			{
					gameOver();
					_levelComplete = false;
					_ball._gameOn = false;
					currentLevel = 0;
					
			}
			
		}
		
		private function changeLevel(level:Array):void
		{
			
			clearLevel();
			buildLevel(level);
		}
		
		public function clearLevel():void
		{
			var bricksLen:int = _bricks.length;
			
			for(var i:int = 0; i < bricksLen; i++)
			{
				removeChild(_bricks[i]);
			}
			
			_bricks.length = 0;
			if(currentLevel == 0)
			{
			_lives = 5
			_points = 0;
			_scoreField.text = "Points: " + _points;
			_livesField.text = "Lives: " + _lives;
			}
			_ball._gameOn = false;
			_levelComplete = false;
			_ball.reset();
		}
		
		public function gamePause():void
		{
			if(_onPause == false)
			{
				_onPause = true;
				stage.removeEventListener(Event.ENTER_FRAME, update);
			}
			else
			{
				stage.addEventListener(Event.ENTER_FRAME, update);
				_onPause = false;
			}
		}	
		
		public function cleanUp():void
		{
			stage.removeEventListener(Event.ENTER_FRAME, update);
		}
		
		public function gameOver():void
		{
			dispatchEvent(new Event(Main.GAME_OVER));	
		}

	}
	
}
