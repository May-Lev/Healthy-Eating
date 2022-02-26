package  
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class RewindMovie extends MovieClip
	{
		public static const REWIND_MOVIE:String = "MovieGoToStart";
		
		public function RewindMovie()
		{
			this.addEventListener(MouseEvent.CLICK, goToStart);
		}
		
		public function goToStart(e:MouseEvent):void
		{
			trace(TheStage.bIsLittleMapOpen + "TheStage.bIsLittleMapOpen"+"rewind");
			if (TheStage.bIsLittleMapOpen)
			{
				trace("rewind if");
				TheStage.bIsLittleMapOpen = false;	
				MovieClip(TheStage.lKotLoader.getChildAt(0)).map_mc.play();//**changes names
			}
			else
			{
				trace("rewind else");
			parent["play_mc"].stopMyMovie();//**check names
			dispatchEvent(new Event(REWIND_MOVIE, true));
			}
		}
		
	}
	
}
