package  
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import TheStage;
	
	/**
	 * ...
	 * all kinds of next buttons
	 * @author stav rockah & karin zolondez
	 */
	public class NextButtons extends SimpleButton 
	{
		
		public function NextButtons() 
		{
			// hides the btn mode(handCursor)
			this.useHandCursor = false;
			
			// The click event
			this.addEventListener(MouseEvent.CLICK, onClick);
			this.addEventListener(Event.ADDED_TO_STAGE, onAdd);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
		}
		private function onRemove(e:Event):void 
		{if (e.currentTarget.name == "speicalNext")
			{
				try
				{
					MovieClip(TheStage.lKotLoader.getChildAt(0)).next_mc.visible = true;
				}
				catch(e:Error)
				{
					trace("Code");
				}
				
				TheStage.bIsNextEnabled = true;
			}
		}
		private function onAdd(e:Event):void 
		{
			// Meens it's the map
			if (TheStage.nScreenNum == -1)
			{
				//TheStage.checkBars(e.currentTarget.parent);
			}
			if (e.currentTarget.name == "speicalNext")
			{
				MovieClip(TheStage.lKotLoader.getChildAt(0)).next_mc.visible = false;
				TheStage.bIsNextEnabled = false;

			}
			removeEventListener(Event.ADDED_TO_STAGE, onAdd);
			
		}
		
		private function onClick(e:MouseEvent):void 
		{
			if (TheStage.bIsLittleMapOpen)
			{
				TheStage.bIsLittleMapOpen = false;
				//create a label in the map_mc for closeing the map (frame after the "stop"
				MovieClip(TheStage.lKotLoader.getChildAt(0)).map_mc.gotoAndPlay("close");//**changes name
				MovieClip(TheStage.lKotLoader.getChildAt(0)).map_mc.play();
				//אם אין אנימצית סגירה , יש לשים את השורה מעל בהערה ואת השורה מתחת להוריד מהערה 
				//MovieClip(TheStage.lKotLoader.getChildAt(0)).map_mc.gotoAndStop(1);//**changes name
			}
			else if(!TheStage.bIsMaavar)
			{
				switch (e.currentTarget.name)
				{
					//the simple nexting button 
					case ("next_mc"):
					{
						// case it's in the map
						if (TheStage.nScreenNum == -1)
						{
							TheStage.bIsFromBack = false;
							TheStage.LoadScreenNum(0);
							MovieClip(TheStage.lKotLoader.getChildAt(0)).gotoAndStop(3);//$$
							AllBtnInProj.createEventBtn(TheStage.lKotLoader);
						}
						else if (TheStage.nScreenNum == -2)
						{
							TheStage.LoadScreenNum(-1);
						}
						else if (TheStage.bIsNextEnabled)
						{
							MovieClip(TheStage.lKotLoader.getChildAt(0)).gotoAndStop(3);//$$
							TheStage.Nexting();
						} 
						break;
					}
					
					//the special nexting button in case of questions/harhavot and all other cases you need to click on the screen (buttons that are on the screen)   
					case ("speicalNext"):
					{
						if (TheStage.nScreenNum == -1)
						{
							TheStage.bIsFromBack = false;
							TheStage.LoadScreenNum(0);
							MovieClip(TheStage.lKotLoader.getChildAt(0)).gotoAndStop(3);//$$
							AllBtnInProj.createEventBtn(TheStage.lKotLoader);
						}
						else if (TheStage.nScreenNum == -2)
						{
							MovieClip(TheStage.lKotLoader.getChildAt(0)).gotoAndStop(2);//$$
							TheStage.LoadScreenNum(-1);
						}
						else 
						{
							MovieClip(TheStage.lKotLoader.getChildAt(0)).gotoAndStop(3);//$$
							TheStage.Nexting();
						} 
						break;
					}		
					case ("OpenScreenNext"):
					{
						e.currentTarget.parent.parent.nextFrame();
						break;
					}
					case ("DebugNext"):
					{
						MovieClip(TheStage.lBWDebugLoader.getChildAt(0)).gotoAndStop(1);
						TheStage.bIsShowScreen = false;//&&
						TheStage.bIsDebug = false;//&&
						TheStage.bIsFocus = true;//&&

						break;
					}
				}
			}
		}
	}

}