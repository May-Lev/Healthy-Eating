package  
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class PlayMovie extends MovieClip
	{
		private var _bPlays:Boolean;//boolean that determines if the movie is played right now
		public static const PLAY_MOVIE:String = "playMovie";
		public static const STOP_MOVIE:String = "stopMovie";

		public function PlayMovie() 
		{
			_bPlays = false;
			this.addEventListener(MouseEvent.CLICK, playPause);
			//this.addEventListener(Event.ENTER_FRAME, checking);
		}
		
		
		private function playPause(e:MouseEvent):void
		{
			if(TheStage.bIsLittleMapOpen)
			{
				TheStage.bIsLittleMapOpen = false;	
				MovieClip(TheStage.lKotLoader.getChildAt(0)).map_mc.play();//**changes names
			}
			else if(e.currentTarget.parent.parent.currentFrame == e.currentTarget.parent.parent.totalFrames)
			{
				e.currentTarget.parent.parent.fromEnd = false;
				_bPlays = true;
				this.gotoAndStop(2);
				MovieClip(parent).isMoviePlayed = true;
				this.dispatchEvent(new Event(PLAY_MOVIE, true));
				MovieClip(parent).myCurrentFrame=2;
				//e.currentTarget.parent.parent.panel_mc.move_mc.x = 2*((e.currentTarget.parent.parent.panel_mc.mask_mc.width/e.currentTarget.parent.parent.strStartSeconds)/stage.frameRate)+ e.currentTarget.parent.parent.MOVER_START ; 
				e.currentTarget.parent.parent.gotoAndPlay(2);
			}
			
			else if(this.currentFrame == 1)//if movie is paused, play it
			{
				_bPlays = true;
				this.gotoAndStop(2);
				trace("---------------------------:" + this.currentFrame);
				this.dispatchEvent(new Event(PLAY_MOVIE, true));
				
				
			}
			else//if movie is played, pause it
			{
				this.stopMyMovie();
				this.dispatchEvent(new Event(STOP_MOVIE, true));
			}
		}
		
		
		public function stopMyMovie():void
		{
			this.gotoAndStop(1);
			this._bPlays = false;
		}
		
		public function get plays():Boolean
		{
			return this._bPlays;
		}
		
		public function set bPlays(value:Boolean):void 
		{
			this._bPlays = value;
		}
	}
	
}
