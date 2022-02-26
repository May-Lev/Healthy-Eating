package  {
	import flash.display.*;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.text.StaticText;
	import flash.ui.*;
	import flash.media.*;
	import flash.media.SoundChannel;
	import flash.net.URLLoader;
	import fl.motion.MotionEvent;

	public class AllBtnInProj 
	{
		private static var _sonOpen:Boolean = false;
		//mays
		public static var helpI:int = questionClass._theI;
		public function AllBtnInProj() 
		{
		}
		public static function createEventBtn(lLoad:Loader):void
		{
			rekursioNcreateEventBtns(MovieClip(lLoad.getChildAt(0)));
		}
		
		// handeling the events on all btn
		private static function rekursioNcreateEventBtns(mc:MovieClip):void
		{
			for (var i:Number = 0; i < mc.numChildren; i++)
			{
				// במידה ואת רוצה להוסיף מחלקה לכפתור ולא לבצע עבורה את אירוע זה, הוסיפי בתנאי זה ( כפיי שקיים עבור כפתור ההמשך)
				if ((mc.getChildAt(i) is SimpleButton) && (!(mc.getChildAt(i) is NextButtons)))
				{
					if (mc.getChildAt(i).name == "shakufMap_btn")
					{
						SimpleButton(mc.getChildAt(i)).addEventListener(MouseEvent.ROLL_OVER ,rollOveirme);
					}
					//if its the dads only
					else if((SimpleButton(mc.getChildAt(i)).name.charAt(0) == 'a' && TheStage.bIsLittleMapOpen && (MovieClip(SimpleButton(mc.getChildAt(i)).parent).currentFrame == 24)))
					{
						SimpleButton(mc.getChildAt(i)).addEventListener(MouseEvent.ROLL_OVER, ROLL_OVERfunc);
						//roll out from all the map
						SimpleButton(mc.getChildAt(i)).parent.addEventListener(MouseEvent.ROLL_OUT ,ROLL_OUTfunc);
					}
					SimpleButton(mc.getChildAt(i)).addEventListener(MouseEvent.CLICK,OnClick);
				}
				if (mc.getChildAt(i) is MovieClip)
				{
					rekursioNcreateEventBtns(mc.getChildAt(i) as MovieClip);
				}
			}
		}
		
		static private function rollOveirme(e:MouseEvent):void 
		{
			if (_sonOpen)
			{
				e.currentTarget.parent.gotoAndPlay("closeSon");
				e.currentTarget.parent.play();
				_sonOpen = false;
			}
		}
		
		static private function ROLL_OUTfunc(e:MouseEvent):void 
		{
			//only if the son is open make the close animation
			if (_sonOpen)
			{
				e.currentTarget.gotoAndPlay("closeSon");
				e.currentTarget.play();
				_sonOpen = false;
			}
		}
		
		static private function ROLL_OVERfunc(e:MouseEvent):void 
		{
			//if i have a son and he is close, open
			if (e.currentTarget.name.charAt(1) == 2 && !_sonOpen) 
			{
				_sonOpen = true;
				e.currentTarget.parent.gotoAndPlay("openSon");
			}
			//close the son only if the son is open and i'm not on his father
			else if(_sonOpen && e.currentTarget.name.charAt(1) != 2)
			{
				e.currentTarget.parent.gotoAndPlay("closeSon");
				e.currentTarget.parent.play();
				_sonOpen = false;
			}
		}
		
		// listener
		private static function OnClick(e:MouseEvent):void
		{
			if ((e.currentTarget.name.charAt(0) == 'a') && ((TheStage.nScreenNum == -1)||(TheStage.bIsLittleMapOpen)))
			{
				TheStage._isPlay = false;
				TheStage._canNextTheGame = false;
				TheStage._diceClick = false;
				if (TheStage.bIsLittleMapOpen)
				{
				MovieClip(TheStage.lKotLoader.getChildAt(0)).back_mc.mouseEnabled = true;
				}
				TheStage.bIsHarhava = false;
				TheStage.bIsFromBack = false;
				//if you are on the map screen
				if (TheStage.nScreenNum < 0)
				{
					MovieClip(TheStage.lKotLoader.getChildAt(0)).gotoAndStop(2);//$$
				}
				//if you are on the open map
				else
				{
					TheStage.bIsLittleMapOpen = false;
					//create a label in the map_mc for closeing the map (frame after the "stop" -- pay attention!!!!!!
					MovieClip(TheStage.lKotLoader.getChildAt(0)).map_mc.gotoAndPlay("close");//**changes name
					_sonOpen = false;
					//אם אין אנימצית סגירה , יש לשים את השורה מעל בהערה ואת השורה מתחת להוריד מהערה 
					//MovieClip(TheStage.lKotLoader.getChildAt(0)).map_mc.gotoAndStop(1);//**changes name
				} 
				TheStage.bIsFromBack = false;
				TheStage.LoadScreenNum(e.currentTarget.name.substring(1));
			}
			else if (TheStage.bIsLittleMapOpen)
			{
				
				if(TheStage.bWasAnim)
				{
				TheStage.bIsAnimation = true;
				}
				TheStage.bIsLittleMapOpen = false;	
				//create a label in the map_mc for closeing the map (frame after the "stop"
				MovieClip(TheStage.lKotLoader.getChildAt(0)).map_mc.gotoAndPlay("close");//**changes name
				_sonOpen = false;
				//אם אין אנימצית סגירה , יש לשים את השורה מעל בהערה ואת השורה מתחת להוריד מהערה 
				//MovieClip(TheStage.lKotLoader.getChildAt(0)).map_mc.gotoAndStop(1);//**changes name
			}
			else
			{
				//trace(e.currentTarget.name);
				// all the cases in the kotarot.
				switch(e.currentTarget.name)
				{
					case "shakufMap_btn":
					{
						if (TheStage.bIsLittleMapOpen)
						{
							TheStage.bIsLittleMapOpen = false;
							//create a label in the map_mc for closeing the map (frame after the "stop"
							MovieClip(TheStage.lKotLoader.getChildAt(0)).map_mc.gotoAndPlay("close");//**changes name
							MovieClip(TheStage.lKotLoader.getChildAt(0)).map_mc.play();
						}			
						break;
					}
					case "check_btn":
					{//Mays - game
						//the ans of the player
						TheStage._arrPlayerAns[questionClass._nChosenQ - 1] = Number(TheStage._nNumAns);	
						//Checks if true
						if (Number(TheStage._nNumAns) == Number(TheStage._arrRightAns[questionClass._nChosenQ-1])) 
						{
							//Right ans!  Display 'V'
							e.currentTarget.parent.parent.mashov_mc.nextFrame();
							//Unable the close btn
							e.currentTarget.parent.parent.closeQ_mc.nextFrame();
							TheStage._nWhoAns = Number(e.currentTarget.parent.parent.theGroup.currentFrame);
							//Update the points (=into the 'sum'(+=) property)
							TheStage["_pointsOf" + Number(TheStage._nWhoAns)] += questionClass._chosenQScore;
							//Update the points (=into the textField)
							MovieClip(e.currentTarget.parent.parent.parent.parent["nPoints"+Number(TheStage._nWhoAns)]).score_txt.text = String(TheStage["_pointsOf" + Number(TheStage._nWhoAns)]);
							//For the radio buttons
							TheStage._nNumAns = -1;
						}
						else
						{
							if (TheStage._onlyTwoTimes < 1) 
							{
								//Wrong 1 time
								TheStage._onlyTwoTimes++;
								//Don't choose this answer again
								(e.currentTarget.parent.parent["ans" + TheStage._nNumAns] as MovieClip).gotoAndStop(3);
								//Unable the passOther btn
								e.currentTarget.parent.parent.passOtherG_mc.nextFrame();
							}
							else 
							{
								//Wrong 2 times
								TheStage._onlyTwoTimes = 10;
								//Unable the closeQ_mc btn
								e.currentTarget.parent.parent.closeQ_mc.nextFrame();
								//Display the right answer
								e.currentTarget.parent.parent.rightAns_mc.gotoAndStop(Number(TheStage._arrRightAns[questionClass._nChosenQ-1] + 1));
							}
							//Display 'X'
							e.currentTarget.parent.parent.mashov_mc.gotoAndStop(3);
							
						}
						//Don't press the radio buttons
						for (var i:int = 1; i < 5; i++) 
						{
							(e.currentTarget.parent.parent["ans" + i] as MovieClip).mouseChildren = false;
							(e.currentTarget.parent.parent["ans" + i] as MovieClip).mouseEnabled = false;
						}
						//Don't press the check btn
						e.currentTarget.parent.parent.check_mc.prevFrame();						
					}
					break;
					case "passOtherG_btn":
					{
						//The next one
						var h:Number;
						helpI++;
						if (helpI < TheStage._arrRandom.length) 
						{
							h = Number(TheStage._arrRandom[Number(helpI)]);
						}
						else if(helpI == 5)
						{
							h = Number(TheStage._arrRandom[1]);
						}
						else
						{
							h = Number(TheStage._arrRandom[0]);
						}
						e.currentTarget.parent.parent.theGroup.gotoAndStop(Number(h - 1));
						
						//Can press the radio buttons
						for (var j:int = 1; j < 5; j++) 
						{
							if ((e.currentTarget.parent.parent["ans" + j] as MovieClip).currentFrame !=3)
							{
								(e.currentTarget.parent.parent["ans" + j] as MovieClip).mouseChildren = true;
								(e.currentTarget.parent.parent["ans" + j] as MovieClip).mouseEnabled = true;
							}
						}
						e.currentTarget.parent.parent.mashov_mc.gotoAndStop(0);
						e.currentTarget.parent.prevFrame();						
					}
					break;
					case "closeQ_btn":
					{
						questionClass._nNumOfAnsQ++;
						//Close the question
						e.currentTarget.parent.parent.play();
						e.currentTarget.parent.parent.addEventListener(Event.ENTER_FRAME , closeTheQ);
						//shakuf
						e.currentTarget.parent.parent.parent.parent.shakuf_btn.visible = false;
						//Function in questionClass
						questionClass(e.currentTarget.parent.parent.parent.parent["p" + questionClass._chosenQScore + "q" + questionClass._nChosenQ]).changeTheQFrame();
					}
					break;
					case "startGame_btn":
					{
						TheStage._startTheGame = true;
						TheStage._diceClick = false;
						TheStage.Nexting();
						break;
					}
					case "dice_btn":
					{
							TheStage.Nexting();
					}
						
					break;
					case "replay_btn":
					{
							e.currentTarget.parent.gotoAndPlay(1);
						break;
					}
					case "back_mc":
					{
						TheStage._diceClick = false;
						TheStage._canNextTheGame = false;
						TheStage.Backing();
					}
					break
					case "openMap_mc":
					{
						if(TheStage.bIsAnimation)
						{
							TheStage.bWasAnim = true;
						}
						else
						{
							TheStage.bWasAnim = false;
						}
						TheStage.bIsAnimation = false;//danielCode
						TheStage.bIsLittleMapOpen = !TheStage.bIsLittleMapOpen;
						if(!TheStage.bIsLittleMapOpen)
						{
							e.currentTarget.parent.map_mc.gotoAndPlay("close");
						}
						else 
						{
							e.currentTarget.parent.map_mc.play();//**changes names
						}
						//MovieClip(e.target.parent.map_mc.saman_mc).gotoAndStop(TheStage.nScreenNum + 1);//**changes names
						TheStage.checkBars(MovieClip(TheStage.lKotLoader.getChildAt(0))["map_mc"]["mapa"]);
						break;
					}
					case ("exit_mc"):
					{	
						if (TheStage.bIsLittleMapOpen)
						{
							MovieClip(TheStage.lKotLoader.getChildAt(0)).map_mc.gotoAndPlay("close");
						}
						TheStage.bIsLittleMapOpen = false;
						TheStage.bIsAnimation = false;//danielcode
						TheStage.bIsExitScreen = true;
						e.currentTarget.parent.exit1.play();//** need to change if the exit is animation or in another screen 
						
						break;
					}
					case "close_mc":
					{
						TheStage.bIsExitScreen = false;
						e.target.parent.parent.gotoAndStop(1);//** 
					}
					break;
					case "quit_mc":
					{
						TheStage.bIsAnimation = false;
						TheStage.nScreenNum = -100;//credits sign is -100
						TheStage.lKotLoader.unload();
						TheStage.LoadScreen("Credits.swf", TheStage.lScreenLoader);//**
						break;
					}
					case ("startAgain_btn"):
					{
						TheStage.bIsExitScreen = false;
						e.currentTarget.parent.parent.play();//**
						TheStage.LoadScreenNum( -1);	
						break;				
					}	
					case ("close2_mc"):
					{
						TheStage.bIsExitScreen = false;
						e.currentTarget.parent.parent.play();//**
						break;
					}
				}
			}
		
		}
		//Mays
		//Closing the question in the game after its animation
		private static function closeTheQ(e:Event):void 
		{
			if (e.currentTarget.currentFrame == 25) 
			{
				e.currentTarget.parent.gotoAndStop(0);
				e.currentTarget.removeEventListener(Event.ENTER_FRAME , closeTheQ);			
			}
		}
		private static function remmberAmin():void 
		{
			if(TheStage.bIsAnimation)
			{
				TheStage.bWasAnim = true;
			}
			else
			{
				TheStage.bWasAnim = false;
			}

		}
		private static function returnAnimation():void 
		{
			if(TheStage.bWasAnim)
			{
				TheStage.bIsAnimation = true;
			}	

		}
	}
	
}
