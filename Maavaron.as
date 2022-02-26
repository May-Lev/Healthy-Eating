package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * class linked to the maavaron MC
	 * ...
	 * @author Stav Rockah & Karin Zolondez
	 */
	public class Maavaron extends MovieClip 
	{
		
		public function Maavaron() 
		{
			if (TheStage._gotoFrame > 2)
			{
				this.gotoAndStop(this.totalFrames);
			}
			if (this.totalFrames != 1)
			{
				MovieClip(TheStage.lKotLoader.getChildAt(0)).kotarot_mc.gotoAndStop(1);
				AllBtnInProj.createEventBtn(TheStage.lKotLoader);
			}
			TheStage.bIsNotAnimation = true;
			TheStage.bIsMaavar = true;
			this.addEventListener(Event.ADDED_TO_STAGE, addListener);
			
		}
		
		private function addListener(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addListener);
			addEventListener(Event.ENTER_FRAME, listenForEnding);
		}
		
		private function listenForEnding(e:Event):void 
		{
			try
			{
				if (!TheStage.bIsMaavar)
				{
					RemoveListeners();
				}
				else if (this.currentFrame == this.totalFrames)
				{
					if ((this.totalFrames == 1)&&(TheStage.bIsFromBack))
					{
						TheStage.Backing();
					}
					this.gotoAndStop(1);//hides the maavaron
					TheStage.bIsNotAnimation = false;
					MovieClip(TheStage.lKotLoader.getChildAt(0)).kotarot_mc.gotoAndStop(TheStage.nScreenNum + 2);
					try
					{
						MovieClip(TheStage.lKotLoader.getChildAt(0)).kotarot_mc.Show.gotoAndPlay(2);
					}
					catch (e:TypeError)
					{
						trace("Error in Maavaron");
					}
					MovieClip(TheStage.lKotLoader.getChildAt(0)).kotarot_mc.mouseClick_mc.visible = false;
					RemoveListeners();
					MovieClip(TheStage.lKotLoader.getChildAt(0)).kotarot_mc.mouseClick_mc.mouse_mc.visible = false;

				}
				
			}
			catch (e:RangeError)
			{
				RemoveListeners();
			}
		}
		
		public function RemoveListeners():void
		{
			TheStage.bIsMaavar = false;
			TheStage.bIsNotAnimation = false;
			TheStage.bIsNextEnabled = true;
			this.removeEventListener(Event.ENTER_FRAME, listenForEnding);
		}
			
	}

}