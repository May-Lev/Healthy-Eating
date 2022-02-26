package  
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.text.StaticText;
	import flash.ui.*;
	import flash.media.*;
	import flash.media.SoundChannel;
	import flash.net.URLLoader;
	
	/**
	 * ...
	 * @author Stav Rockah & Karin Zolondez
	 */
	public class TheStage extends MovieClip 
	{
		//May code
		//Groups' points
		//1- CERROT, 2- BROCLY , 3- LEMON , 4- TOMATO
		public static var _pointsOf1:Number = 0;
		public static var _pointsOf2:Number = 0;
		public static var _pointsOf3:Number = 0;
		public static var _pointsOf4:Number = 0;
		//For the game- saving the frame of the winning movieClip, to show the winnings groups
		// Can ans only two times on each question
		public static var _onlyTwoTimes:Number = 0;
		public static var _nNumAns:Number = -1;
		public static var _arrPlayerAns:Array = [25];
		public static var _arrRightAns:Array = [4, 2, 3, 4, 3, 1, 2, 2, 3, 3, 3, 2, 1, 1, 3, 3, 4, 2, 4, 2, 3, 2, 4, 2, 4];
		public static var _arrRandom:Array = [0, 0, 0, 0];
		//Random the order of the groups only one time
		private static var _bIsOneTimeGame:Boolean = true;
		public static var _nWhoAns:Number = -1;
		public static var _isPlay:Boolean = false;
		public static var _canNextTheGame:Boolean = false;
		//The frames of each question (p100q1 , p200q6..). Every frame has a different color :)
		public static var _arrayOfFrames:Array = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
		public static var _diceClick:Boolean = false;
		public static var _startTheGame:Boolean = false;
		// Variables
		private static var _myRoot:TheStage;
		
		//harhava
		static public var bIsHarhava = false;
		// The loaders on the screens&kot&debugNbw
		private static var _lScreenLoader:Loader;
		private static var _lKotLoader:Loader; 
		private static var _lBWDebugLoader:Loader;
		private static var _lCursorAnimation:Loader;
		private static var _uUrl:URLRequest;
		
		private static var _typeLoaderNow:Loader;
		
		// for the goto screen
		public static var _gotoFrame:Number = -1;//&&
		public static var _gotoScreen:Number = -1;//&&
		public static var bIsFocus:Boolean = true;
		
		private static var _bIsShowScreen:Boolean = false;

		//The array of the scrrens
		//////////////////////////////////////////////////////-0-------1--------2-------3-------4-------5-------6-------7------8------9---------10-
		private static const SCREENS_ARRAY:Array = new Array("$100", "$200", "$310", "$320", "$330", "$340", "$350", "$360", "$400", "$500", "$600");
		private static var _nScreenNum:Number;
		
		// bars
		private static var _barArray:Array = new Array();
		private static var _barsV:Array = new Array();
		
		// Boolean if nexting should be enabled
		private static var _bIsNextEnabled:Boolean;
		
		// Boolean that checks if you are from back
		private static var _bIsFromBack:Boolean;
		private static var _bIsMaavar:Boolean;
		
		// ShiftZ and CtrlN booleans
		private static var _bIsShift:Boolean = false;
		private static var _bIsCtrl:Boolean = false;
		private static var _bIsN:Boolean = false;
		public static var _bIsZ:Boolean = false;
		private static var _bIsF:Boolean = false;
		
		// screens Bollean
		private static var _bIsBlack:Boolean = false;
		private static var _bIsWhite:Boolean = false;
		private static var _bIsDebug:Boolean = false;		
		private static var _bIsExitScreen:Boolean = false;
		private static var _bIsLittleMapOpen:Boolean = false;
		private static var _bIsCursor:Boolean = false;
		
		// boolean that true if there is animation we don't want to append.
		private static var _bIsNotAnimation:Boolean = true;
		private static var _bIsAnimCursor:Boolean = false;
		private static var _bWasAnim:Boolean = false;
		//boolean that states if there's a movie in the screen
		private static var _bIsMovie:Boolean = false;
		
		//boolean that states if there's a movie preload in process
		private static var _bIsMovPreload:Boolean = false;
			
		// Boolean if it's open Screen and if need to publish mark or not.
		private static var _bIsPublish:Boolean;
		
		
		public function TheStage() 
		{
			_myRoot = this;
			
			// init the variables
			lKotLoader = new Loader();
			lScreenLoader = new Loader();
			_lBWDebugLoader = new Loader();
			_lCursorAnimation = new Loader();

			// add the kot and the screens loader into the main screen
			this.addChild(lScreenLoader);
			this.addChild(lKotLoader);
			this.addChild(_lBWDebugLoader);
			this.addChild(_lCursorAnimation);
			
			// Load DebugAnd b&W screen
			LoadScreen("BlackWhiteAndDebugScreen.swf", _lBWDebugLoader); //**
			TheStage.LoadScreen("kotarot.swf", TheStage.lKotLoader);//**
			
			
			nScreenNum = -2; //^Change to -3 if have mavo
			
			// Load the introduction Screen
			LoadScreenNum(nScreenNum);
			_bIsMaavar = false;
			
			bIsNextEnabled = true;
			barArray = [2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2];//**change the length of the array according to the number of screens
			_barsV = [false,false,false,false,false,false,false,false,false,false,false];//**change the length of the array according to the number of screens
			_bIsFromBack = false;
			// Create event listeners for the keyBoard
			this.addEventListener(Event.ENTER_FRAME, GetFocusAndAnimationMouse);
			this.addEventListener(KeyboardEvent.KEY_DOWN,KeyDown);
			this.addEventListener(KeyboardEvent.KEY_UP,KeyUp);
		}
		
		static public function get bWasAnim():Boolean 
		{
			return _bWasAnim;
		}
		
		static public function set bWasAnim(value:Boolean):void 
		{
			_bWasAnim = value;
		} 
		static public function get lScreenLoader():Loader 
		{
			return _lScreenLoader;
		}
		
		static public function set lScreenLoader(value:Loader):void 
		{
			_lScreenLoader = value;
		}
		
		static public function get uUrl():URLRequest 
		{
			return _uUrl;
		}
		
		static public function set uUrl(value:URLRequest):void 
		{
			_uUrl = value;
		}
		
		static public function get lKotLoader():Loader 
		{
			return _lKotLoader;
		}
		
		static public function set lKotLoader(value:Loader):void 
		{
			_lKotLoader = value;
		}
		
		static public function get SCREENS():Array 
		{
			return SCREENS_ARRAY;
		}
		
		static public function get nScreenNum():Number 
		{
			return _nScreenNum;
		}
		
		static public function set nScreenNum(value:Number):void 
		{
			_nScreenNum = value;
		}
		
		static public function get bIsNextEnabled():Boolean 
		{
			return _bIsNextEnabled;
		}
		
		static public function set bIsNextEnabled(value:Boolean):void 
		{
			_bIsNextEnabled = value;
		}
		
		static public function get barArray():Array 
		{
			return _barArray;
		}
		
		static public function set barArray(value:Array):void 
		{
			_barArray = value;
		}
		
		static public function get barsV():Array 
		{
			return _barsV;
		}
		
		static public function set barsV(value:Array):void 
		{
			_barsV = value;
		}
		
		static public function get bIsFromBack():Boolean 
		{
			return _bIsFromBack;
		}
		
		static public function set bIsFromBack(value:Boolean):void 
		{
			_bIsFromBack = value;
		}
		
		static public function get bIsMaavar():Boolean 
		{
			return _bIsMaavar;
		}
		
		static public function set bIsMaavar(value:Boolean):void 
		{
			_bIsMaavar = value;
		}

		static public function get lBWDebugLoader():Loader 
		{
			return _lBWDebugLoader;
		}
		
		static public function set lBWDebugLoader(value:Loader):void 
		{
			_lBWDebugLoader = value;
		}
		
		static public function get bIsExitScreen():Boolean 
		{
			return _bIsExitScreen;
		}
		
		static public function set bIsExitScreen(value:Boolean):void 
		{
			_bIsExitScreen = value;
		}
		
		static public function get bIsLittleMapOpen():Boolean 
		{
			return _bIsLittleMapOpen;
		}
		
		static public function set bIsLittleMapOpen(value:Boolean):void 
		{
			_bIsLittleMapOpen = value;
		}
		
		static public function get bIsNotAnimation():Boolean 
		{
			return _bIsNotAnimation;
		}
		
		static public function set bIsNotAnimation(value:Boolean):void 
		{
			_bIsNotAnimation = value;
		}
		
		
		static public function get bIsMovie():Boolean 
		{
			return _bIsMovie;
		}
		
		static public function set bIsMovie(value:Boolean):void 
		{
			_bIsMovie = value;
		}
		static public function get bIsMovPreload():Boolean 
		{
			return _bIsMovPreload;
		}
		
		static public function set bIsMovPreload(value:Boolean):void 
		{
			_bIsMovPreload = value;
		}
		static public function get bIsAnimation():Boolean 
		{
			return _bIsAnimCursor;
		}
		
		static public function set bIsAnimation(value:Boolean):void 
		{
			_bIsAnimCursor = value;
		}
		static public function set bIsDebug(value:Boolean):void //&&
		{
			_bIsDebug = value;
		}
		static public function get bIsDebug():Boolean //&&
		{
			return _bIsDebug;
		}
		static public function get bIsShowScreen():Boolean //&&
		{
			return _bIsShowScreen;
		}
		static public function set bIsShowScreen(value:Boolean):void //&&
		{
			_bIsShowScreen = value;
		}
		
		// Load all type of screens
		public static function LoadScreen(strScreenName:String, lLoader:Loader): void
		{
			SoundMixer.stopAll();
			_bIsMovie = false;
			TheStage.bIsNotAnimation = false;
			_typeLoaderNow = lLoader;//!!
			
			// remove the animation mouse
			_bIsCursor = false;
			_lCursorAnimation.unload();
			Mouse.show();
			
			lLoader.unload();
			uUrl = new URLRequest(strScreenName);
			lLoader.load(uUrl);//!!
			lLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, GetEvents);//!!
		}
		
		static private function GetEvents(e:Event):void 
		{
			AllBtnInProj.createEventBtn(_typeLoaderNow);
		}
		
		// Load the screen under the number 
		public static function LoadScreenNum(nNum:Number):void
		{
			TheStage.bIsAnimation = false ;
			_bIsMovie = false;
			TheStage.bIsNotAnimation = false;
			nScreenNum = nNum;
			try
			{
				finishAnimScreen(MovieClip(TheStage.lScreenLoader.getChildAt(0)));
			}
			catch (e:RangeError)
			{
				//trace("Error range:)");
			}
			catch (e:TypeError)
			{
				//trace("Error Type:)");
			}
			
			// remove the animation mouse
			_bIsCursor = false;
			_lCursorAnimation.unload();
			Mouse.show();

			if (nScreenNum >= 0)
			{
				MovieClip(TheStage.lKotLoader.getChildAt(0)).gotoAndStop(3);//$$
				AllBtnInProj.createEventBtn(lKotLoader);
				LoadScreen(SCREENS_ARRAY[nNum] + ".swf", lScreenLoader);
				//Mays - dont come back from $600 to $500 if you haven't random the groups
				if(TheStage.nScreenNum == 10 && !(TheStage._startTheGame))
				{
					MovieClip(TheStage.lKotLoader.getChildAt(0)).back_mc.mouseEnabled = false;
				}
				else if(TheStage.nScreenNum == 10)
				{
					MovieClip(TheStage.lKotLoader.getChildAt(0)).back_mc.mouseEnabled = true;
				}
			}
			
			//map screen
			else if(nScreenNum == -1)
			{
				bIsNotAnimation = false;
				changeBars();
				MovieClip(TheStage.lKotLoader.getChildAt(0)).gotoAndStop(2);//$$
				AllBtnInProj.createEventBtn(lKotLoader);
				LoadScreen("map.swf", lScreenLoader);//**change the name of the swf
			}
			//^ if there is mavo, change the next if to -3 and remove the next frame from hara
			//if openScreen 
			else if(nScreenNum == -2)
			{
				LoadScreen("OpenScreen.swf", lScreenLoader);
			}
			//if mavo
			/*else if(nScreenNum == -2)
			{
				MovieClip(TheStage.lKotLoader.getChildAt(0)).gotoAndStop(2);
				AllBtnInProj.createEventBtn(lKotLoader);
				LoadScreen("$10.swf", lScreenLoader);
			}*/
			
			lScreenLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, GotoLastFrameOnScreen);
		}
		
		static private function GotoLastFrameOnScreen(e:Event):void 
		{
			// Get if the preload need to show or not
			HandleTextFiles.handleInFiles("checkPreload.txt");
			
			// Check if need to go the last frame on screen
			if (_bIsFromBack)
			{
				lScreenLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,GotoLastFrameOnScreen);
				MovieClip(lScreenLoader.getChildAt(0)).gotoAndStop(MovieClip(lScreenLoader.getChildAt(0)).totalFrames);
				AllBtnInProj.createEventBtn(lScreenLoader);

				
				try
				{	
					
					if (nScreenNum != -1)
					{
						finishAnimScreen(MovieClip(lScreenLoader.getChildAt(0)));
						MovieClip(TheStage.lKotLoader.getChildAt(0)).kotarot_mc.gotoAndStop(TheStage.nScreenNum + 2); 
						MovieClip(TheStage.lKotLoader.getChildAt(0)).kotarot_mc.Show.gotoAndStop(MovieClip(TheStage.lKotLoader.getChildAt(0)).kotarot_mc.Show.totalFrames);//**	
						MouseClick();
					}
					
					AllBtnInProj.createEventBtn(lScreenLoader);
				}
				catch(e:RangeError){}
				
				
			}
			// if with mavo change the if to -3 and not -2
			else
			{
				if (nScreenNum == -2 )//^
				{
					MovieClip(_myRoot["BG_mc"]).gotoAndStop(1);//**change bg's movieClip name
				}
				else
				{
					MovieClip(_myRoot["BG_mc"]).gotoAndStop(2);//**change bg's movieClip name
				}
				//**here you can add more backgrounds, in case the project has more than one.
			}
		}
		
		// function that handles the simple nexting
		public static function Nexting():void
		{
			if (!(bIsHarhava))
			{
				TheStage.bWasAnim = false;
				TheStage.bIsAnimation = false ;
				SoundMixer.stopAll();
				_bIsMovie = false;
			
				// remove the animation mouse
				_bIsCursor = false;
				_lCursorAnimation.unload();
				Mouse.show();
				TheStage.bIsNotAnimation = false;
				TheStage.bIsAnimation = false;
			
				if (!(MovieClip(TheStage.lScreenLoader.getChildAt(0)).currentFrame == MovieClip(TheStage.lScreenLoader.getChildAt(0)).totalFrames))
				{
					try
					{
						finishAnimScreen(MovieClip(TheStage.lScreenLoader.getChildAt(0)));
					}
					catch (e:RangeError)
					{
					//	trace("Error range:)");
					}
				}
				_bIsFromBack = false;
				changeBars();
				
				// get next screen
				if (MovieClip(TheStage.lScreenLoader.getChildAt(0)).currentFrame == MovieClip(TheStage.lScreenLoader.getChildAt(0)).totalFrames)
				{
					if ((nScreenNum == SCREENS_ARRAY.length -1))
					{
						MovieClip(_lKotLoader.getChildAt(0)).exit2.play();
						AllBtnInProj.createEventBtn(lKotLoader);
						_bIsExitScreen = true;
					}
					else
					{
						TheStage.LoadScreenNum(TheStage.nScreenNum + 1);		
					}
				}
					// Get next frame if not finish the screen
				else 
				{
					MovieClip(TheStage.lScreenLoader.getChildAt(0)).nextFrame();
					AllBtnInProj.createEventBtn(lScreenLoader);
					MouseClick();
				}
			}
			
			
		}
		
		public static function Backing():void
		{
			if (!(bIsHarhava))
			{
				TheStage.bWasAnim = false;
				TheStage.bIsAnimation = false ;
				SoundMixer.stopAll();
				
				// remove the animation mouse
				TheStage.bIsNotAnimation = false;
				TheStage.bIsAnimation = false;
				
				TheStage.bIsNextEnabled = true;
				_bIsCursor = false;
				_lCursorAnimation.unload();
				Mouse.show();
				_bIsMovie = false;
				try
				{
					finishAnimScreen(MovieClip(TheStage.lScreenLoader.getChildAt(0)));
					AllBtnInProj.createEventBtn(lScreenLoader);
				}
				catch (e:RangeError)
				{
					//trace("Error range:)");
				}
				
				_bIsFromBack = true;	
				//TheStage.changeBars();
				//mays
				//if you go back and you are not on the first frame of the screen, go to the previous frame
				if (MovieClip(lScreenLoader.getChildAt(0)).currentFrame > 2&& nScreenNum >= 0 )//%%%%
				{
					MovieClip(lScreenLoader.getChildAt(0)).prevFrame();
					AllBtnInProj.createEventBtn(lScreenLoader);
					MouseClick();
					
					if (MovieClip(lScreenLoader.getChildAt(0)).currentFrame > 2)
					{
						finishAnimScreen(MovieClip(lScreenLoader.getChildAt(0)));
						
						AllBtnInProj.createEventBtn(lScreenLoader);
					}
				}
				//if you are in the second frame
				else
				{
					//trace("backing load");
					bIsMaavar = false;
					TheStage.bIsNotAnimation = false;	
					LoadScreenNum(nScreenNum - 1);
				}
			}
		}
		
		public static function finishAnimScreen(animation_mc:MovieClip):void
		{
			for (var nIndex:Number = 0; nIndex < animation_mc.numChildren; nIndex++)
			{
				if(animation_mc.getChildAt(nIndex) is MovieClip)
				{
					finishAnim(MovieClip(animation_mc.getChildAt(nIndex)));
				}		
			}
			
		}
		// go to the last frame of the animations on screen
		public static function finishAnim(animation_mc:MovieClip):void
		{
			//mays - one of the object, helps to call the bigSmallTheVegs func
			if (animation_mc.name == "p100q1") 
			{
				questionClass(animation_mc).bigSmallTheVegs();
			}
			if(_bIsFromBack && animation_mc.name.substring(0,3) != "veg" && animation_mc.name != "questions_mc"  && animation_mc.name.charAt(0) != "p" && animation_mc.name.charAt(4) != "q" && animation_mc.name != "win_mc")
			{
				if (animation_mc.name.substring(0,4) == "dice" && animation_mc.name.charAt(4) == String(_arrRandom[0]))
				{
					animation_mc.gotoAndStop(animation_mc.totalFrames);
					animation_mc.dicePlay.gotoAndStop(animation_mc.dicePlay.totalFrames);
				}
				else if (animation_mc.name.substring(0, 4) != "dice")
				{
					animation_mc.gotoAndStop(animation_mc.totalFrames);
				}				
			}
			else
			{
				animation_mc.stop();
			}
			
			for(var nCounts:Number = 0; nCounts < animation_mc.numChildren; nCounts ++)
			{
				
				
				if(animation_mc.getChildAt(nCounts) is MovieClip)
				{
					
					
					finishAnim(MovieClip(animation_mc.getChildAt(nCounts)));
				}
			}
		}
		
		private function KeyUp(e:KeyboardEvent):void 
		{
			_bIsCtrl = false;
			_bIsN = false;
			_bIsShift = false;
			_bIsZ = false;
			_bIsF = false;

		}
		
		private function KeyDown(e:KeyboardEvent):void 
		{			
			// Black and white handles.
			if (e.keyCode == Keyboard.W)
			{
				if ((!_bIsWhite) &&(!_bIsBlack))
				{
					LoadOrRemove(3, true);
					_bIsWhite = !_bIsWhite;
				}
				else if (!_bIsBlack)
				{
					LoadOrRemove(3, false);
					_bIsWhite = !_bIsWhite;
				}
			}
			if (e.keyCode == Keyboard.B)
			{
				if ((!_bIsWhite) &&(!_bIsBlack))
				{
					LoadOrRemove(2, true);
					_bIsBlack = !_bIsBlack;

				}
				else if (!_bIsWhite)
				{
					LoadOrRemove(2, false);
					_bIsBlack = !_bIsBlack;
				}
			}
			
			// Check CTRL+SHIFT+Z and SHIFT+N
			if (e.keyCode == Keyboard.SHIFT)
			{
				_bIsShift = true;
			}
			if (e.keyCode == Keyboard.CONTROL)
			{
				_bIsCtrl = true;
			}
			if (e.keyCode == Keyboard.Z)
			{
				_bIsZ = true;
			}
			if (e.keyCode == Keyboard.N)
			{
				_bIsN = true;
			}
			if (e.keyCode == Keyboard.F)
			{
				_bIsF = true;
			}
			if (_bIsShift && _bIsZ && (nScreenNum == -2)) //^ if with mavo change -2 to -3
			{
				TheStage.LoadScreenNum(-1); //^ if with mavo change -1 to -2
			}
			///////@skip Maavaron
			else if (!bIsFromBack &&_bIsShift && _bIsZ && bIsMaavar && (nScreenNum >=0)) // if you are at maavaron
			{
				//pass to the context, skip the ,maavaron --- 
				TheStage._gotoFrame = 3;
				LoadScreenNum(nScreenNum);
				bIsMaavar = false;
			}
			/////////////////////
			else if ((_bIsCtrl) && (_bIsShift) && (_bIsN) && (!_bIsWhite) &&(!_bIsBlack))
			{
				if (!_bIsDebug)
				{
					LoadOrRemove(4, true);
					MovieClip(lBWDebugLoader.getChildAt(0)).Frame_text.text = String(MovieClip(lScreenLoader.getChildAt(0)).currentFrame);
					MovieClip(lBWDebugLoader.getChildAt(0)).Screen_text.text = String(SCREENS_ARRAY[nScreenNum]).substring(1, 6);
				}
			}
			else if ((_bIsCtrl) && (_bIsShift) && (_bIsF) && (!_bIsWhite) &&(!_bIsBlack))
			{
				if (!_bIsShowScreen)
				{
					LoadOrRemove(5, true);
				}
			}
			
			// If not debug or BW screen need to work
			else if ((!_bIsDebug && (!_bIsWhite) && (!_bIsBlack)) && (!bIsExitScreen))
			{
				// If it's the mavo or first map
				if ((nScreenNum < 0) && (nScreenNum != -2)) //^ if with mavo change -2 to -3
				{
					if (e.keyCode == Keyboard.SPACE || e.keyCode == Keyboard.ENTER || e.keyCode == Keyboard.DOWN || e.keyCode == Keyboard.LEFT || e.keyCode == 34 || e.keyCode == 98 || e.keyCode == 102)
					{
						if (nScreenNum == -1)
						{
							TheStage.bIsFromBack = false;
							MovieClip(TheStage.lKotLoader.getChildAt(0)).gotoAndStop(2);//$$
							AllBtnInProj.createEventBtn(lKotLoader);
						}
						
						LoadScreenNum(nScreenNum + 1);
					}
				}
				else
				{
					if (e.keyCode == Keyboard.SPACE || e.keyCode == Keyboard.ENTER || e.keyCode == Keyboard.DOWN || e.keyCode == Keyboard.LEFT || e.keyCode == 34 || e.keyCode == 98 || e.keyCode == 100)
					{
						if (questionClass._donePlaying)
						{
							_canNextTheGame = false;
						}
						if (bIsLittleMapOpen)
						{
							bIsLittleMapOpen = false;
							//create a label in the map_mc for closeing the map (frame after the "stop"
							MovieClip(TheStage.lKotLoader.getChildAt(0)).map_mc.gotoAndPlay("close");//**changes name
							//אם אין אנימצית סגירה , יש לשים את השורה מעל בהערה ואת השורה מתחת להוריד מהערה 
							//MovieClip(TheStage.lKotLoader.getChildAt(0)).map_mc.gotoAndStop(1);//**changes name
						}
						else if (!bIsMaavar && !bIsHarhava && !_diceClick && !_canNextTheGame)
						{
							_isPlay = false;
							MovieClip(TheStage.lKotLoader.getChildAt(0)).back_mc.mouseEnabled = true;
							Nexting();
						}
					}
					else if (e.keyCode == Keyboard.RIGHT || e.keyCode == Keyboard.UP || e.keyCode == 33 || e.keyCode == 104 || e.keyCode == 102)
					{
						if (bIsLittleMapOpen)
						{
							bIsLittleMapOpen = false;
							//create a label in the map_mc for closeing the map (frame after the "stop"
							MovieClip(TheStage.lKotLoader.getChildAt(0)).map_mc.gotoAndPlay("close");//**changes name
							//אם אין אנימצית סגירה , יש לשים את השורה מעל בהערה ואת השורה מתחת להוריד מהערה 
							//MovieClip(TheStage.lKotLoader.getChildAt(0)).map_mc.gotoAndStop(1);//**changes name
						}
						else if(!bIsHarhava && (MovieClip(TheStage.lKotLoader.getChildAt(0)).back_mc.mouseEnabled))
						{
							_diceClick = false;
							trace(_canNextTheGame + " 2");
							_canNextTheGame = false;
							Backing();
						}						
					}
				}
			}
		}
		
		// Load/remove Debug screen or b&w screen
		public function LoadOrRemove(nNumberFrame:Number,bIsShow:Boolean)//?????????????
		{
			if (bIsShow)
			{
				MovieClip(_lBWDebugLoader.getChildAt(0)).gotoAndStop(nNumberFrame);
			}
			else
			{
				MovieClip(MovieClip(_lBWDebugLoader.getChildAt(0)).getChildAt(0)).play();
			}
		}
		
		private function GetFocusAndAnimationMouse(e:Event):void 
		{
			if (TheStage.bIsFocus)
			{
				stage.focus = this;
			}
			if (bIsAnimation)
			{
				if (!_bIsCursor)
				{
					LoadScreen("MouseCursor.swf", _lCursorAnimation);//**
					_lCursorAnimation.contentLoaderInfo.addEventListener(Event.COMPLETE, mouseCursor);
					_bIsCursor = true;
				}
				else
				{
					mouseCursorShange();
				}
			}
			else
			{
				_bIsCursor = false;
				_lCursorAnimation.unload();
				Mouse.show();
			}
			
		}
		
		private function mouseCursorShange():void
		{
			Mouse.hide();
			try
			{
				MovieClip(MovieClip(_lCursorAnimation.getChildAt(0)).getChildAt(0)).x = stage.mouseX + 1;
				MovieClip(MovieClip(_lCursorAnimation.getChildAt(0)).getChildAt(0)).y = stage.mouseY + 1;
			}
			catch(e:RangeError)
			{
				
			}
		}
		
		private  function mouseCursor(e:Event):void
		{
			_bIsCursor = true;
			mouseCursorShange();
		}

		
		// MouseClick
		public static function MouseClick():void
		{
			try
			{
				if (MovieClip(lScreenLoader.getChildAt(0)).currentFrame > 2)
				{
					
					MovieClip(_lKotLoader.getChildAt(0)).kotarot_mc.mouseClick_mc.visible = true;
					
					if (MovieClip(lScreenLoader.getChildAt(0)).currentFrame == MovieClip(lScreenLoader.getChildAt(0)).totalFrames)
					{
						MovieClip(_lKotLoader.getChildAt(0)).kotarot_mc.mouseClick_mc.gotoAndStop(2);
					}
					else
					{
						MovieClip(_lKotLoader.getChildAt(0)).kotarot_mc.mouseClick_mc.gotoAndStop(1);
					}
					MovieClip(TheStage.lKotLoader.getChildAt(0)).kotarot_mc.mouseClick_mc.mouse_mc.visible = true;
					MovieClip(_lKotLoader.getChildAt(0)).kotarot_mc.mouseClick_mc.mouse_mc.currFrame_txt.text = MovieClip(lScreenLoader.getChildAt(0)).currentFrame - 2;
					MovieClip(_lKotLoader.getChildAt(0)).kotarot_mc.mouseClick_mc.mouse_mc.totalFrame_mc.text = MovieClip(lScreenLoader.getChildAt(0)).totalFrames - 2;
					MovieClip(_lKotLoader.getChildAt(0)).kotarot_mc.mouseClick_mc.mouse_mc.gotoAndPlay(1);
				}
				else
				{
					try
					{
						MovieClip(_lKotLoader.getChildAt(0)).kotarot_mc.mouseClick_mc.visible = false;
					}
					catch(e:TypeError){}
				}
			}
			catch (e:RangeError)
			{}
		}
		
		//function that handles the bars array.
		public static function changeBars():void
		{
			//function that counts how many frames have you been through in the screen by nexting.
			if (MovieClip(_lScreenLoader.getChildAt(0)).currentFrame == barArray[nScreenNum] + 1)
			{
				barArray[nScreenNum] ++;
			}
			//function that checks if been through all the frames of the screen.
			if(barArray[nScreenNum] == MovieClip(_lScreenLoader.getChildAt(0)).totalFrames)
			{
				barsV[nScreenNum] = true;
			}
		}
		
		//function that checks the arrBarV array. if it's true changes the bar to V.
		public static function checkBars(mcNativ:MovieClip):void
		{	
			// variable defintion
			var nFirstNum:Number;
			var nSecNum:Number;
			
			// run over all the childrens in the map.
			for(var nCounter = 0; nCounter < mcNativ.numChildren; nCounter ++ )
			{
				var bIsAllTrue:Boolean = true;
				
				// Check if the children is bar
				if (mcNativ.getChildAt(nCounter).name.substring(0, 3) == "bar")
				{
					// Gets the first and the last number of the subject's children 
					if (mcNativ.getChildAt(nCounter).name.length == 6)
					{
						nFirstNum = Number(mcNativ.getChildAt(nCounter).name.charAt(3));
						nSecNum = Number(mcNativ.getChildAt(nCounter).name.charAt(5));
					}
					else if (mcNativ.getChildAt(nCounter).name.length == 7)
					{
						nFirstNum = Number(mcNativ.getChildAt(nCounter).name.charAt(3));
						nSecNum = Number(mcNativ.getChildAt(nCounter).name.substring(5,7));
					}
					else if (mcNativ.getChildAt(nCounter).name.length == 8)
					{
						nFirstNum = Number(mcNativ.getChildAt(nCounter).name.substring(3,5));
						nSecNum = Number(mcNativ.getChildAt(nCounter).name.substring(6,8));
					}
					
					//run through all the children of the subject.
					for(var nCount:Number = nFirstNum; nCount <= nSecNum; nCount ++)
					{
						if(!barsV[nCount])
						{
							bIsAllTrue = false;
						}
					}
					
					//when you are through all of the screens, the V is shown. 
					if(bIsAllTrue)
					{
						mcNativ["bar" + nFirstNum + "_" + nSecNum].gotoAndStop(2);					
					}
				}
			}
		}
		
		// change text field to hebrew
		public static function changeToHebrew(str:String):String
		{
			var myNewString:String ="";
			var myNumber:String="";
			var myHebrewString:String = "";
			for (var i:Number = 0; i < str.length; i++)
			{
				if (((str.charAt(i) >= 'א')&&(str.charAt(i) <='ת'))||(str.charAt(i) =='"'))
				{
					myHebrewString = str.charAt(i) + myHebrewString;
					myNewString = myNewString+ myNumber;
					myNumber = "";
				}
				else
				{
					myNewString = myNewString + myHebrewString;
					myHebrewString = "";
					myNumber = myNumber + str.charAt(i); 
				}
			}
			if (myNumber == "")
			{
				myNewString = myNewString + myHebrewString;
			}
			else
			{
				myNewString = myNewString+ myNumber;
			}
			return myNewString;
		}
		//May code
		public static function enterToTheArray(nFrame:Number , theI:Number):void
		{
			_arrayOfFrames[Number(theI-1)] = nFrame;
		}
		//Random the order of the groups
		public static function randomFunc():void
		{
			if (_bIsOneTimeGame)
			{
				_bIsOneTimeGame = false;
				var nRandom:Number = Math.floor(Math.random() * (4) - 0.001);
				for (var i:int = 2; i < 6; i++) 
				{
					while (_arrRandom[nRandom] != 0) 
					{
						nRandom = Math.floor(Math.random() * (4) - 0.001);
					}
					_arrRandom[nRandom] = i;
				}
				trace(_arrRandom);
			}
		}
	}
}