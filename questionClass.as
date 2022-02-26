package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	public class questionClass extends MovieClip
	{
		public static var _arrXVegPlaces:Array = [338.05,93,-171.05,-430.1];
		public static var _arrXPointsPlaces:Array = [262.05,16,-247.05,-493.1];
		public static var _qChosenQObj:questionClass;
		public static var _nChosenQ:Number;
		public static var _chosenQScore:Number;
		public static var _theI:int = 0;
		public static var _nNumIObjs:Number = 0;
		public static var _donePlaying:Boolean = false;
		public static var _nTheWinner:Number = -1;
		public static var _nTwoWinners:Number = -1;
		public static var _nNumOfAnsQ:Number = 0;
		public function questionClass()
		{
			//* ~~~~~~  THE GAME'S CODE IS IN : TheStage, radionButtonClass , AllBtnInProj , showKot ,500  ~~~~~~ *//
			changePlaces();
			showPoints();
			this.gotoAndStop(Number(TheStage._arrayOfFrames[_nNumIObjs]));
			this.addEventListener(MouseEvent.MOUSE_UP , chooseTheQ);
			_qChosenQObj = this;
			_nNumIObjs++;
			//If the game was over AND all the objects are on the stage
			if(_donePlaying && _nNumIObjs == 25)
			{
				_nNumIObjs = 0;
				TheStage._isPlay = false;
				TheStage._canNextTheGame = false;
				var myTimer:Timer = new Timer(50, 1);
				myTimer.start();
				myTimer.addEventListener(TimerEvent.TIMER, showAns);
			}
			else if (!_donePlaying && _nNumIObjs == 25) 
			{
				TheStage._isPlay = true;
				_nNumIObjs = 0;
			}
		}
		//Placing the vegetables and textFields
		private function changePlaces():void 
		{
			for (var i:int = 0; i < TheStage._arrRandom.length; i++) 
			{
				MovieClip(parent["veg" +String(TheStage._arrRandom[i] - 1)]).x = _arrXVegPlaces[i];
				MovieClip(parent["nPoints" +String(TheStage._arrRandom[i] - 1)]).x = _arrXPointsPlaces[i];
			}	
		}
		//Display the points of each group (CALL ONLY FROM THE CONSTRACTOR);
		private function showPoints():void 
		{
				for (var u:int = 1; u < 5; u++) 
				{
					MovieClip(this.parent["nPoints"+Number(u)]).score_txt.text = String(TheStage["_pointsOf" + Number(u)]);
				}
		}
		//Display the winnig group - win movieClip (CALL ONLY FROM THE CONSTRACTOR, AND HEPPENS ONLY WHEN THE GAME IS DONE.
		private function showAns(e:TimerEvent):void 
		{
			MovieClip(TheStage.lScreenLoader.getChildAt(0)).movGame_mc.shakuf_btn.visible = true;
			MovieClip(TheStage.lScreenLoader.getChildAt(0)).movGame_mc.shakuf_btn.addEventListener(MouseEvent.MOUSE_UP , nextTheGame);
			//stoping the movieclips 
				if (_nTwoWinners != -1)
				{
					MovieClip(_qChosenQObj.parent["win_mc"]).gotoAndStop(["two" + _nTwoWinners]);
					MovieClip(this.parent["win_mc"]).a.stop();
					MovieClip(this.parent["win_mc"]).b.stop();
					MovieClip(this.parent["win_mc"]).a.gotoAndStop(	MovieClip(this.parent["win_mc"]).a.totalFrames);
					MovieClip(this.parent["win_mc"]).b.gotoAndStop(	MovieClip(this.parent["win_mc"]).b.totalFrames);
				}
				else if(_nTheWinner != -1)
				{
					MovieClip(this.parent["win_mc"]).gotoAndStop(_nTheWinner);
					MovieClip(this.parent["win_mc"]).a.stop();
					MovieClip(this.parent["win_mc"]).a.gotoAndStop(	MovieClip(this.parent["win_mc"]).a.totalFrames);
				}
		}	
		//The player click on a specific question
		private function chooseTheQ(e:MouseEvent):void 
		{
			//  ~   for example - "p200q7"   ~
			//The num of question:  7
			_nChosenQ = Number(e.currentTarget.name.substring(5));
			//The Score of question:  200
			_chosenQScore = Number(e.currentTarget.name.substring(1, 4));
			//Display the question				
			e.currentTarget.parent.questions_mc.gotoAndPlay(_nChosenQ + 1);
			//shakuf
			e.currentTarget.parent.shakuf_btn.visible = true;
		}
		//Display the color of the question (CALL ONLY FROM AllBtnInProj)
		public function changeTheQFrame():void
		{
			//Don't press this question again
			this.removeEventListener(MouseEvent.MOUSE_UP , chooseTheQ);
			this.mouseChildren = false;
			if (TheStage._onlyTwoTimes != 10) 
			{
				//Show the color of the group
				this.gotoAndStop(Number(TheStage._nWhoAns+1));
			}
			else
			{
				//Wrong 2 time - show gray
				this.gotoAndStop(6);
			}
			TheStage._onlyTwoTimes = 0;
			AllBtnInProj.helpI = _theI;
			TheStage.enterToTheArray(this.currentFrame , _nChosenQ);
			chageThePlayer();
		}
		public function chageThePlayer():void 
		{
			_theI++;
			AllBtnInProj.helpI = _theI;
			//If the game isn't finished update the veg movieClips 
			if (!questionClass.checkIfFinishGame())
			{
				if (_theI < TheStage._arrRandom.length) 
				{	
					//The nextPlayer
					MovieClip(parent["veg" + Number(TheStage._arrRandom[ Number(_theI)] - 1)]).gotoAndPlay("smallToBig");
					//The lastPlayer
					MovieClip(parent["veg" + Number(TheStage._arrRandom[Number(_theI - 1)] - 1)]).gotoAndPlay("bigToSmall");
				}
				else
				{
					//The nextPlayer
					MovieClip(parent["veg" + Number(TheStage._arrRandom[Number(0)] -1)]).gotoAndPlay("smallToBig");
					//The lastPlayer
					MovieClip(parent["veg" + Number(TheStage._arrRandom[Number(_theI - 1)] - 1)]).gotoAndPlay("bigToSmall");
					_theI = 0;
				}
			}
			else 
			{
				//The game was finished
				TheStage._canNextTheGame = false;
				//Can next the game
				MovieClip(TheStage.lScreenLoader.getChildAt(0)).movGame_mc.shakuf_btn.visible = true;
				MovieClip(TheStage.lScreenLoader.getChildAt(0)).movGame_mc.shakuf_btn.addEventListener(MouseEvent.MOUSE_UP , nextTheGame);
				for (var i:int = 1; i < 5; i++) 
				{
					if (MovieClip(parent["veg" + i]).currentFrame != 1)
					{
						MovieClip(parent["veg" + i]).gotoAndPlay("smallToBig");
					}
				}
				var myTimer:Timer = new Timer(1200, 1);
				myTimer.start();
				myTimer.addEventListener(TimerEvent.TIMER, checkWhoWon);
			}
		}	
		private function nextTheGame(e:MouseEvent):void 
		{
			TheStage._isPlay = false;
			MovieClip(TheStage.lKotLoader.getChildAt(0)).back_mc.mouseEnabled = true;
			MovieClip(TheStage.lScreenLoader.getChildAt(0)).movGame_mc.shakuf_btn.removeEventListener(MouseEvent.MOUSE_UP , nextTheGame);
			TheStage.Nexting();
		}
		private function checkWhoWon(e:TimerEvent):void 
		{
			var nTheMaxVal:Number = 0;
			var nMaxI:Number = -1;
			var nExtra:Number = 0;
			var nExtraI:Number = 0;
			for (var j:int = 1; j < 5; j++) 
			{
				if (TheStage["_pointsOf" + Number(j)]  > nTheMaxVal)
				{
					nTheMaxVal = Number(TheStage["_pointsOf" + Number(j)]);
					nMaxI = j;
				}
			}
			for (var i:int = 0; i < 5; i++) 
			{
				if (TheStage["_pointsOf" + Number(i)]==nTheMaxVal && i !=nMaxI)
				{
					nExtra++;
					nExtraI = i;
				}
			}
			if (nExtra == 1)
			{
				//Two winners
				var nNumHelpMax:Number = Number(Math.max(nExtraI , nMaxI) + 1);
				var nNumHelpMin:Number = Number(Math.min(nExtraI , nMaxI) + 1);
				MovieClip(_qChosenQObj.parent["win_mc"]).gotoAndPlay(["two" + nNumHelpMin + nNumHelpMax]);
				var helpString:String = String(String(nNumHelpMin)+String(nNumHelpMax));
				_nTwoWinners = Number(helpString);
			}
			else if(nExtra == 0)
			{
				//One winner
				MovieClip(_qChosenQObj.parent["win_mc"]).gotoAndPlay(nMaxI + 1);
				_nTheWinner = Number(nMaxI + 1);
			}
		}
		//Call from backing and for the actions of 500
		public function bigSmallTheVegs():void
		{
			//If the first one in the array is playing now
			if(TheStage._isPlay && AllBtnInProj.helpI == 0)
			{
				for(var h:Number = 1 ; h<4; h++)
				{
					MovieClip(this.parent["veg" +String(TheStage._arrRandom[h] - 1)]).gotoAndPlay("bigToSmall");
				}
			}
			//If its in the middle of the game, and its not the first one turn
			else if(TheStage._isPlay)
			{
				for(var h2:Number = 0 ; h2<4; h2++)
				{
					if(h2 != Number(AllBtnInProj.helpI))
					{
						MovieClip(this.parent["veg" +String(TheStage._arrRandom[h2] - 1)]).gotoAndPlay("bigToSmall");
					}
				}
				if(Number(AllBtnInProj.helpI) == 4)
				{
					MovieClip(this.parent["veg" +String(TheStage._arrRandom[0] - 1)]).gotoAndStop("smallToBig");
					MovieClip(this.parent["veg" +String(TheStage._arrRandom[0] - 1)]).play();
				}
			}
		}
		public static function checkIfFinishGame():Boolean
		{
			var bIsAllAns:Boolean = true;
			if (_nNumOfAnsQ != 25) 
			{
				bIsAllAns = false;
			}
			if (bIsAllAns) 
			{
				_donePlaying = true;
			}
			return bIsAllAns;
		}
	}
}
