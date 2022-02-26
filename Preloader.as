package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.LoaderInfo;
	
	public class Preloader extends MovieClip
	{
		private var nPrecentage:Number;
		private var _targetLoaderInfo:LoaderInfo;
		
		public function Preloader() 
		{
			
			TheStage.bIsNotAnimation = true;
			this.addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		private function init(e:Event):void
		{
			this.addEventListener(Event.ENTER_FRAME, LoadScreen);
			_targetLoaderInfo = stage.loaderInfo;
		}
		
		private function LoadScreen(e:Event):void
		{
			try
			{
				this.nPrecentage = _targetLoaderInfo.bytesLoaded / _targetLoaderInfo.bytesTotal * 100;//**;
				this.gotoAndStop(_targetLoaderInfo.bytesLoaded / _targetLoaderInfo.bytesTotal * this.totalFrames);
				MovieClip(parent)["txtPercentage"].text = String(this.nPrecentage) + "%";//**check names
				if(this.nPrecentage == 100)
				{
					MovieClip(TheStage.lScreenLoader.getChildAt(0)).nextFrame();
					AllBtnInProj.createEventBtn(TheStage.lScreenLoader);
					this.removeEventListener(Event.ENTER_FRAME, LoadScreen);
				}
			}
			catch(e:TypeError)
			{
				trace("error catched");
				removeListeners();
			}
		}
		
		public function removeListeners():void
		{
			TheStage.bIsNotAnimation = false;
			this.removeEventListener(Event.ENTER_FRAME, LoadScreen);
		}

	}
	
}
