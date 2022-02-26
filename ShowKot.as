package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author stav rockah & karin zolondez
	 */
	public class ShowKot extends MovieClip 
	{
		public function ShowKot() 
		{
			MovieClip(TheStage.lKotLoader.getChildAt(0))["kotarot_mc"]["mouseClick_mc"].visible = true;
			this.addEventListener(Event.ADDED_TO_STAGE, addListener);
		}
		private function addListener(e:Event):void 
		{
			//Mays
			if (TheStage.nScreenNum == 9 && TheStage._startTheGame)
			{
				TheStage._canNextTheGame = true;
				MovieClip(TheStage.lScreenLoader.getChildAt(0)).gotoAndStop(5);
			}
			else if (TheStage._gotoFrame > 2)
			{
				MovieClip(TheStage.lScreenLoader.getChildAt(0)).gotoAndStop(TheStage._gotoFrame);
				TheStage._gotoFrame = -1;
				TheStage.bIsFromBack = false;
			}
			else
			{
				MovieClip(TheStage.lScreenLoader.getChildAt(0)).nextFrame();
				removeEventListener(Event.ADDED_TO_STAGE, addListener);
			}				
			AllBtnInProj.createEventBtn(TheStage.lScreenLoader);
			TheStage.MouseClick();
		}
	}

}