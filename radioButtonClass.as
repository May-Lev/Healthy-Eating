package
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class radioButtonClass extends MovieClip
	{
		// constructor code
		public function radioButtonClass()
		{
			//Display the group (the small movieClip)
			if (AllBtnInProj.helpI == 0) 
			{
				(this.parent as MovieClip).theGroup.gotoAndStop(Number(TheStage._arrRandom[AllBtnInProj.helpI]- 1));
			}
			else
			{
				(this.parent as MovieClip).theGroup.gotoAndStop(Number(TheStage._arrRandom[questionClass._theI]-1));
			}
			//The radio buttons
			this.addEventListener(MouseEvent.CLICK , chooseAns);
		}	
		private function chooseAns(e:MouseEvent):void 
		{
			//If it's not the first time pressing one of the radio buttons
			if (TheStage._nNumAns != -1) 
			{
				//Remove the last one
				if (e.currentTarget.parent["ans" + TheStage._nNumAns].currentFrame !=3)
				{
					e.currentTarget.parent["ans" + TheStage._nNumAns].gotoAndStop(1);
				}
			}
			//The num of the new ans
			TheStage._nNumAns = Number(e.currentTarget.name.charAt(3));
			//Choose this one
			if (e.currentTarget.currentFrame !=3)
			{
				e.currentTarget.gotoAndStop(2);
			}
			//Check the ans
			e.currentTarget.parent.check_mc.nextFrame();
		}
	}	
}
