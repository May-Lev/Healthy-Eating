package  
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.events.Event;
		
	public class Scroll extends SimpleButton
	{
		private var bFromScroll:Boolean;
		
		public static const PLAY_MOVIE:String = "playMovie";

		public function Scroll() 
		{
			this.bFromScroll = false;
			this.addEventListener(MouseEvent.CLICK, moveMover);
		}
		
		private function moveMover(e:MouseEvent):void
		{
		    if (TheStage.bIsLittleMapOpen)
			{
				TheStage.bIsLittleMapOpen = false;	
				MovieClip(TheStage.lKotLoader.getChildAt(0)).map_mc.play();//**changes names
			}
			else
			{
			this.bFromScroll = true;
			
			if(e.localX >= parent["mask_mc"].width - 5)//if clicked on end (**check names!);
			{
				parent["move_mc"].x = e.localX + (parent["move_mc"] as Mover).startX - parent["move_mc"].width/2;//**check names
			}
			else if(e.localX <= 1)//if clicked on start
			{
				parent["move_mc"].x = e.localX + (parent["move_mc"] as Mover).startX;//**check names
			}
			else//if clicked in the middle
			{
				parent["move_mc"].x = e.localX + (parent["move_mc"] as Mover).startX - (parent["move_mc"] as Mover).width/2.5;//**check names
			}
			dispatchEvent(new Event(PLAY_MOVIE, true));
			}
			
		}
		
		public function get fromScroll():Boolean
		{
			return this.bFromScroll;
		}
		
		public function set fromScroll(b:Boolean):void
		{
			this.bFromScroll = b;
		}

	}
	
}
