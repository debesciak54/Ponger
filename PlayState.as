package  
{
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		[Embed(source = "../lib/SMALL BALL.png")]
		private var BALL:Class;
		
		public var racketLeft:FlxSprite;
		public var racketRight:FlxSprite;
		
		public var ball:FlxSprite;
		
		public var score:FlxText;
		public var scoreLeft:uint;
		public var scoreRight:uint;
		
		public var clock:FlxText;
		
		public var launchText:FlxText;
		
		private var _timer:Number;
		private var _countdownTimer:Number;
		protected var isLaunched:Boolean;
		protected var isControllable:Boolean;
		
		override public function create():void
		{
			_timer = 0;
			_countdownTimer = 0;
			isLaunched = false;
			isControllable = false;
			
			//Create the left racket
			racketLeft = new FlxSprite(16, FlxG.height / 2 - 16);
			racketLeft.makeGraphic(8, 40, 0xffffffff);
			racketLeft.immovable = true;
			add(racketLeft);
			
			//Create the right racket
			racketRight = new FlxSprite(FlxG.width - 24, FlxG.height / 2 - 16);
			racketRight.makeGraphic(8, 40, 0xffffffff);
			racketRight.immovable = true;
			add(racketRight);
			
			//Create the ball
			ball = new FlxSprite(FlxG.width / 2 - 4, FlxG.height / 2 + 4, BALL);
			ball.elasticity = 1;
			add(ball);
			/*
			//Generate random starting angle
			var startAngle:Number = int(Math.random() * 45);
			var additionRand:Number = int(Math.random() * 4);
			
			switch (additionRand) 
			{
				case 0:
					startAngle += 22;
				break;
				case 1:
					startAngle += 114;
				break;
				case 2:
					startAngle += 201;
				break;
				case 3:
					startAngle += 294;
				break;
			}
			
			trace(startAngle);
			
			startAngle *= Math.PI / 180;
			ball.velocity.x = 125 * Math.cos(startAngle);
			ball.velocity.y = 125 * Math.sin(startAngle);
			add(ball);*/
			
			//Create the score text
			score = new FlxText(FlxG.width / 2 - 30, 10, 60);
			score.text = scoreLeft + " : " + scoreRight;
			score.setFormat(null, 16, 0xfffffff, "center");
			score.color = 0x04ff00;
			add(score);
			
			//Silly time counter
			clock = new FlxText(FlxG.width / 2 - 25, 200, 50);
			clock.text = "00:00";
			clock.setFormat(null, 8, 0xffffff, "center");
			clock.color = 0xff0000;
			add(clock);
			
			//Create the text showed while waiting for the ball to be launched
			launchText = new FlxText(FlxG.width / 2 - 70, FlxG.height / 2 + 50, 140);
			launchText.text = "PRESS SPACE TO LAUNCH";
			launchText.setFormat(null, 8, 0xffffff, "center");
			add(launchText);
		}
		
		override public function update():void
		{
			FlxG.mouse.hide();
			//trace(Math.sqrt(ball.velocity.x*ball.velocity.x+ball.velocity.y*ball.velocity.y));
			
			//Controls
			racketLeft.velocity.y *= 0.5;
			
			if (FlxG.keys.W && isControllable)
				racketLeft.velocity.y -= 100;
			if (FlxG.keys.S && isControllable)
				racketLeft.velocity.y += 100;
			
			racketRight.velocity.y *= 0.5;
			
			if (FlxG.keys.UP && isControllable)
				racketRight.velocity.y -= 100;
			if (FlxG.keys.DOWN && isControllable)
				racketRight.velocity.y += 100;
			
			super.update();
			
			if (racketLeft.y < 0)
				racketLeft.y = 0;
			if (racketLeft.y > FlxG.height - 40)
				racketLeft.y = FlxG.height - 40;
			
			if (racketRight.y < 0)
				racketRight.y = 0;
			if (racketRight.y > FlxG.height - 40)
				racketRight.y = FlxG.height - 40;
				
			if (ball.y < 0 || ball.y > FlxG.height - 8)
				ball.velocity.y *= -1;
				
			FlxG.collide(racketLeft, ball);
			FlxG.collide(racketRight, ball);
			//FlxG.collide();
			
			if (ball.x < 0)
			{
				scoreRight++;
				ball.reset(FlxG.width / 2 - 4, FlxG.height / 2 + 4);
				racketLeft.reset(16, FlxG.height / 2 - 16);
				racketRight.reset(FlxG.width - 24, FlxG.height / 2 - 16);
				isLaunched = false;
				isControllable = false;
				launchText.visible = true;
			}
			if (ball.x > FlxG.width)
			{
				scoreLeft++;
				ball.reset(FlxG.width / 2 - 4, FlxG.height / 2 + 4);
				racketLeft.reset(16, FlxG.height / 2 - 16);
				racketRight.reset(FlxG.width - 24, FlxG.height / 2 - 16);
				isLaunched = false;
				isControllable = false;
				launchText.visible = true;
			}
			
			score.text = scoreLeft + " : " + scoreRight;
			
			if (scoreLeft == 5)
			{
				FlxG.switchState(new WinState(false));
			}
			else if (scoreRight == 5)
			{
				FlxG.switchState(new WinState(true));
			}
			
			// Give the players some time to cool down, but not too much!
			if (!isLaunched)
			{
				_countdownTimer += FlxG.elapsed;
				
				 if (FlxG.keys.SPACE || _countdownTimer > 1.2)
				{
					launchText.visible = false;
					_countdownTimer = 0;
					isControllable = true;
					isLaunched = launchBall();
				}
			}
			
			if (isLaunched)
				_timer += FlxG.elapsed;
			var mins:String = (int(_timer / 60)).toString();
			var secs:String = (int(_timer % 60)).toString();
			
			if (mins.length == 1) 
				mins = '0' + mins;
			if (secs.length == 1)
				secs = '0' + secs;
				
			clock.text = mins + ":" + secs;
		}
		
		protected function launchBall():Boolean
		{
			//Generate random starting angle
			var startAngle:Number = int(Math.random() * 45);
			var additionRand:Number = int(Math.random() * 4);
			
			switch (additionRand) 
			{
				case 0:
					startAngle += 22;
				break;
				case 1:
					startAngle += 114;
				break;
				case 2:
					startAngle += 201;
				break;
				case 3:
					startAngle += 294;
				break;
			}
			
			startAngle *= Math.PI / 180;
			ball.velocity.x = 125 * Math.cos(startAngle);
			ball.velocity.y = 125 * Math.sin(startAngle);
			
			return true;
		}
	}
}