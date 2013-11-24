package  
{
	import org.flixel.*;
	
	public class WinState extends FlxState
	{
		[Embed(source = "../lib/wingding_0.ttf", fontFamily = "WING", embedAsCFF="falee")] public var FontWING:String;
		
		public var whoWon:Boolean;
		public var winText:FlxText;
		public var instructions:FlxText;
		
		//public var test:FlxText;
		
		private var choice:int;
		
		public function WinState(passedWhoWon:Boolean = false) 
		{
			whoWon = passedWhoWon;
		}
		
		override public function create():void
		{
			winText = new FlxText(FlxG.width / 2 - 50, 10, 100);
			winText.text = whoWon ? "Player R wins!" : "Player L wins!";
			winText.setFormat(null, 8, 0xffffff, "center");
			add(winText);
			
			instructions = new FlxText(FlxG.width / 2 - 35, 100, 70);
			instructions.text = "> REMATCH\nMAIN MENU";
			instructions.setFormat(null, 8, 0xffffff, "left");
			add(instructions);
			
			/*test = new FlxText(50, 50, 100, "\xf1");
			test.setFormat("WING", 34);
			add(test);*/
			
			choice = 0;
		}
		
		override public function update():void
		{
			super.update();
			
			if (FlxG.keys.justPressed("UP"))
			{
				choice--;
				choice %= 2;
				choice = Math.abs(choice);
			}
			else if (FlxG.keys.justPressed("DOWN"))
			{
				choice++;
				choice %= 2;
			}
			
			switch(choice)
			{
				case 0:
					instructions.text = "> REMATCH\nMAIN MENU";
				break;
				case 1:
					instructions.text = "REMATCH\n> MAIN MENU";
				break;
			}
			
			if (FlxG.keys.justPressed("ENTER"))
				switch(choice)
				{
					case 0:
						FlxG.switchState(new PlayState());
					break;
					case 1:
						FlxG.switchState(new MenuState());
					break;
				}
		}
	}
}