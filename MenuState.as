package  
{
	import org.flixel.*;
	
	public class MenuState extends FlxState
	{
		public var title:FlxText;
		public var version:FlxText;
		//var instructions:FlxText;
		public var playButton:FlxButton;
		
		public var animate1:FlxSprite;
		public var animate2:FlxSprite;
		
		public var followPad1:FlxSprite;
		public var followPad2:FlxSprite;
		
		override public function create():void
		{
			title = new FlxText(0, 16, FlxG.width, "PONGER");
			title.setFormat(null, 16, 0xFFFFFF, "center");
			title.color = 0xfce916;
			add(title);
			
			version = new FlxText(0, 40, FlxG.width, "v.0.2 closed beta"); //Version number here.
			version.setFormat(null, 8, 0xFFFFFF, "center");
			add(version);
			
			playButton = new FlxButton(FlxG.width / 2 - 40, FlxG.height / 3 + 50, "PLAY", onPlay);
			playButton.color = 0x55fcdb;
			add(playButton);
			
			animate1 = new FlxSprite(-20, FlxG.height / 3);
			animate1.makeGraphic(20, 20, 0xffffffff);
			animate1.angularVelocity = 100;
			animate1.velocity.x = 75;
			add(animate1);
			
			animate2 = new FlxSprite(FlxG.width, FlxG.height * (2 / 3) + 20);
			animate2.makeGraphic(20, 20, 0xffffffff);
			animate2.angularVelocity = -100;
			animate2.velocity.x = -75;
			add(animate2);
			
			followPad1 = new FlxSprite(FlxG.width / 2 - 20, 163);
			followPad1.makeGraphic(40, 8, 0xffffffff);
			add(followPad1);
			
			followPad2 = new FlxSprite(FlxG.width / 2 - 20, 110);
			followPad2.makeGraphic(40, 8, 0xffffffff);
			add(followPad2);
			
			/*var instructions:FlxText;
			instructions = new FlxText(0, FlxG.height - 32, FlxG.width,
				"PRESS SPACE IF YOU DON'T WANT TO DIE");
			instructions.setFormat(null, 8, 0xFFFFFF, "center");
			add(instructions);*/
		}
		
		override public function update():void
		{
			super.update();
			
			if ((FlxG.mouse.x >= 0 && FlxG.mouse.x <= FlxG.width) &&
				(FlxG.mouse.y >= 0 && FlxG.mouse.y <= FlxG.height)) 
			{
				FlxG.mouse.show();
			}
			else
				FlxG.mouse.hide();
				
			if (animate1.x > FlxG.width + 5)
				animate1.x = - 20;
				
			if (animate2.x < -25)
				animate2.x = FlxG.width;
				
			followPad1.x = FlxG.width - FlxG.mouse.x - 20;
				
			if (followPad1.x > FlxG.width - 40)
				followPad1.x = FlxG.width - 40;
			if (followPad1.x < 0)
				followPad1.x = 0;
				
			followPad2.x = FlxG.mouse.x - 20;
			
			if (followPad2.x > FlxG.width - 40)
				followPad2.x = FlxG.width - 40;
			if (followPad2.x < 0)
				followPad2.x = 0;
			
			/*if (FlxG.keys.justPressed("SPACE"))
			{
				FlxG.switchState(new PlayState());
			}*/
			
			/*if (FlxG.keys.justPressed("UP")) That's a lil' bit too complicated for now.
			{
				
			}
			else if (FlxG.keys.justPressed("DOWN"))
			{
				
			}
			else if (FlxG.keys.justPressed("ENTER"))
			{
				
			}*/
		}
		
		public function MenuState() 
		{
			super();
		}
		
		protected function onPlay():void
		{
			FlxG.switchState(new PlayState());
		}
	}
}