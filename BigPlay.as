package  
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Karin Zolondez
	 */
	public class BigPlay extends SimpleButton 
	{
		
		public function BigPlay() 
		{
			this.addEventListener(MouseEvent.CLICK, startMovie);
		}
		
		private function startMovie(e:MouseEvent):void 
		{
			if(TheStage.bIsLittleMapOpen)
			{
				TheStage.bIsLittleMapOpen = false;	
				MovieClip(TheStage.lKotLoader.getChildAt(0)).map_mc.play();//**changes names
			}
			else if(MovieClip(parent).currentFrame == MovieClip(parent).totalFrames)
			{
				MovieClip(parent).fromEnd = false;
			   MovieClip(parent).isMoviePlayed = true;//** change nativ if needed
			   MovieClip(parent)["panel_mc"]["play_mc"].gotoAndStop(2);//** change nativ if needed
			    MovieClip(parent)["panel_mc"]["play_mc"].bPlays = true;//** change nativ if needed
				MovieClip(e.currentTarget.parent).gotoAndPlay(2);
			}
			else
			{
			MovieClip(parent).isMoviePlayed = true;//** change nativ if needed
			MovieClip(parent)["panel_mc"]["play_mc"].gotoAndStop(2);//** change nativ if needed
			MovieClip(parent)["panel_mc"]["play_mc"].bPlays = true;//** change nativ if needed
			MovieClip(parent).play();//** change nativ if needed
			}
		}
		
	}

}