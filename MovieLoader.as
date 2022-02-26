package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class MovieLoader extends MovieClip
	{
		private var nPrecentage:Number;
		
		public function MovieLoader() 
		{
			TheStage.bIsMovPreload = true;
			TheStage.bIsNotAnimation = true;
			this.addEventListener(Event.ENTER_FRAME, LoadMovie);
		}
		private function LoadMovie(e:Event):void
		{
			if(TheStage.bIsMovPreload)
			{
				try
				{
					this.nPrecentage = Math.floor(this.currentFrame / this.totalFrames * 100);
					MovieClip(parent)["txtPercentage"].text = String(this.nPrecentage) + "%";//**check names
					
					if(this.nPrecentage == 100)
					{
						TheStage.bIsMovPreload = false;
						var theMovie:MyMovie = new MyMovie();
						this.parent.parent.addChild(theMovie);//**change nativ
						this.removeEventListener(Event.ENTER_FRAME, LoadMovie);
					}
				}
				catch(e:TypeError)
				{
					removeListeners();
				}
			}
			else
			{
				removeListeners();
			}
		}
		
		public function removeListeners():void
		{
			TheStage.bIsMovPreload = false;
			TheStage.bIsNotAnimation = false;
			this.removeEventListener(Event.ENTER_FRAME, LoadMovie);
		}

	}
	
}
