package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class MyMovie extends MovieClip
	{
		public static const MOVIE_ENDING:String = "MovieEnded";
		private var myCurrentFrame:Number;
		private var MOVER_START:Number; 
		private var bIsMoviePlayed:Boolean;
		private var nMoverX:Number;
		private var strMinutes:String;
		private var strSeconds:String;
		private var bFromEnd:Boolean;
		private var _bIsFromRewind:Boolean;
		private var bIsStarted:Boolean;//if the movie needs to start on press-false else true
		private var strStartSeconds:Number;
		private var nMaxDrag:Number;
				
		public function MyMovie()
		{
			TheStage.bIsMovie = true;
			this.addEventListener(Event.ADDED_TO_STAGE, handleMovie);
			this.addEventListener(Event.REMOVED_FROM_STAGE, MovieEnding2);
			TheStage.bIsNotAnimation = true;
			this.bFromEnd = false;
			this.bIsStarted=true;
			this._bIsFromRewind=false;
		}
		
		private function handleMovie(e:Event):void
		{
			this.x =464.3;//** change position
			this.y = 457.65;//** change position
			//this["panel_mc"]["move_mc"].x = this["panel_mc"]["move_mc"].x + this["panel_mc"]["mask_mc"].width-this["panel_mc"]["move_mc"].width;
			this["panel_mc"]["btn"].useHandCursor = false;//**change nativ and names if needed
			this["panel_mc"]["mask_mc"].mouseEnabled = false;//**change nativ and names if needed
			this["panel_mc"]["seen"].mouseEnabled = false;//**change nativ and names if needed
			this.removeEventListener(Event.ADDED_TO_STAGE, handleMovie);
			changeTime();
			this.panel_mc.mask_mc.x = this.panel_mc.move_mc.x+(this.panel_mc.move_mc.width/2);//**check names			
			this.MOVER_START = this.panel_mc.move_mc.x;//**check names
			this.strStartSeconds=this.totalFrames/stage.frameRate;
			//trace(this.totalFrames * ((this.panel_mc.mask_mc.width/this.strStartSeconds)/stage.frameRate)+ this.MOVER_START);
			//this.nMaxDrag=this.totalFrames * ((this.panel_mc.mask_mc.width/this.strStartSeconds)/stage.frameRate)+ this.MOVER_START ; 
			trace(this.nMaxDrag+"this.nMaxDrag");
			//this.nMaxDrag+=1;
			//this.nMaxDrag=Math.abs(this.nMaxDrag)+(1-Math.abs(this.nMaxDrag)%1);
			this.nMaxDrag = this["panel_mc"]["move_mc"].x+this["panel_mc"]["mask_mc"].width-this["panel_mc"]["move_mc"].width+1;
			//this.strStartSeconds=Math.abs((this.totalFrames- Math.round((this.panel_mc.move_mc.x - this.MOVER_START)/(this.panel_mc.mask_mc.width)  * this.totalFrames))/stage.frameRate);
			this.nMoverX = this.MOVER_START;
			this.myCurrentFrame = 1;
			this.bFromEnd = false;
			this.addEventListener(PlayMovie.PLAY_MOVIE, playMyMovie);
			this.addEventListener(Scroll.PLAY_MOVIE, playByScroll);
			this.addEventListener(PlayMovie.STOP_MOVIE, stopMyMovie);
			this.addEventListener(Mover.CHANGE_MOVIE, changeMovie);
			this.addEventListener(Event.ENTER_FRAME, MovieEnding);
			this.addEventListener(RewindMovie.REWIND_MOVIE, startOver);
			
			
			if(this.bIsStarted)
			{
				this.gotoAndPlay(this.myCurrentFrame);
				this.bIsMoviePlayed = true;
				
				this["panel_mc"]["play_mc"].gotoAndStop(2);
				this["panel_mc"]["play_mc"].bPlays=true;
			}
			else
			{
				this.stop();
				this.bIsMoviePlayed = false;
			}
		}
		
		private function playMyMovie(e:Event):void
		{
			this.bFromEnd = false;
			this.gotoAndPlay(this.myCurrentFrame);
			/*if(this.currentFrame == this.totalFrames)
			{
				this.bIsStarted=true;
				this.bIsMoviePlayed = true;
			    this.gotoAndPlay(2);
			}
			else
			{
				this.play();
				this.bIsMoviePlayed = true;
			}*/
			this.bIsMoviePlayed = true;
			
		}
		
		private function playByScroll(e:Event)
		{
			changeMyMovie();
		}
		private function stopMyMovie(e:Event):void
		{
			this.bIsMoviePlayed = false;
			this.stop();
		}
		
		private function MovieEnding(e:Event):void
		{
			
			if (TheStage.bIsMovie)
			{
				try
				{
					this.panel_mc.mask_mc.x = this.panel_mc.move_mc.x+(this.panel_mc.move_mc.width/2);
					
					
					//this.panel_mc.mask_mc.x = this.panel_mc.move_mc.x - this.panel_mc.mask_mc.width + 5;//**check names
					changeTime();
					
					this.myCurrentFrame = this.currentFrame;
					
					if(this.bIsMoviePlayed)
					{
						//**check names
						if(!(this.panel_mc.move_mc.dragged))
						{
							//**check names
							if(!this.panel_mc.scroll_mc.fromScroll)
							{
								//this.panel_mc.move_mc.x=this.MOVER_START+;
								this.panel_mc.move_mc.x = this.currentFrame * (((this.panel_mc.mask_mc.width-this.panel_mc.move_mc.width)/this.strStartSeconds)/stage.frameRate)+ this.MOVER_START+1; 
								this.nMoverX = this.panel_mc.move_mc.x;//**check names
							}
							else
							{
								this.nMoverX = this.panel_mc.move_mc.x;//**check names
								changeMyMovie();
								this.panel_mc.scroll_mc.fromScroll = false;
							}
							
						}
						else
						{
							this.stop();
						}
						
					}
					
					if((this.currentFrame == 1 || this.currentFrame == this.totalFrames)&&(!this.bIsStarted))//if dragged to start
					{
						this.stop();
						this.panel_mc.play_mc.stopMyMovie();//**check names
						
					}
					if(this.currentFrame == this.totalFrames)
					{
						this.bFromEnd = true;
						this.panel_mc.play_mc.bPlays = false;//**check names
					}
				 //   if(this.currentFrame>1)// i hadded this if 
					//{
					this.bIsStarted=false;
					//}
				}
				catch(e:TypeError)
				{
					removeListeners();
				}
			}
			else
			{
				removeListeners();
				MovieClip(parent).removeChild(this);//**make sure the nativ is right
			}
		}
		
		private function MovieEnding2(e:Event):void
		{
			for (var i:Number = this.numChildren-1; i >=0 ; i--)
			{
				this.removeChildAt(i);
			}

		}
		
		public function set bIsFromRewind(bBool:Boolean):void
		{
			this._bIsFromRewind=bBool;
		}
		public function get bIsFromRewind():Boolean
		{
			return this._bIsFromRewind;
		}
		public function get getCurrentFrame():Number
		{
			return this.myCurrentFrame;
		}
		
		private function changeMovie(e:Event):void
		{
			changeMyMovie();
		}
	
		public function get moverX():Number
		{
			return this.nMoverX;
		}
		
		public function set moverX(nNum:Number):void
		{
			this.nMoverX = nNum;
		}
		
		public function changeMyMovie():void
		{
			var nGoToFrame:Number=Math.abs(Math.round((this.moverX-this.MOVER_START)/(((this.panel_mc.mask_mc.width-this.panel_mc.move_mc.width)/(Math.abs(this.strStartSeconds)+(1-Math.abs(this.strStartSeconds)%1)))/stage.frameRate)));
			if (this._bIsFromRewind)
			{
				nGoToFrame = 1;
				this._bIsFromRewind = false;
			}
			//**check names
			if(this.panel_mc.play_mc.plays)
			{
				this.gotoAndPlay(nGoToFrame);
			}
			else
			{
				this.gotoAndStop(nGoToFrame);
			}
		}
		
		public function changeTime():void
		{
			var currFrame =Math.round((this.panel_mc.move_mc.x-this.MOVER_START)/((this.panel_mc.mask_mc.width/this.strStartSeconds)/stage.frameRate));
			this.strMinutes='0';
			//(this.panel_mc.move_mc.x-this.MOVER_START)/((this.panel_mc.mask_mc.width/this.strStartSeconds)/stage.frameRate) = this.currentFrame * ((this.panel_mc.mask_mc.width/this.strStartSeconds)/stage.frameRate)+ this.MOVER_START ; 
			//this.strSeconds = 
			//this.strSeconds =String( Math.round(this.strStartSeconds- ( Math.round(this.panel_mc.move_mc.x-this.panel_mc.mask_mc.x)*((this.panel_mc.mask_mc.width/this.strStartSeconds)/stage.frameRate))));
			this.strSeconds = String(Math.round((this.totalFrames-this.currentFrame)/stage.frameRate));
			//this.strSeconds = String(Math.abs((this.totalFrames- Math.round((this.panel_mc.move_mc.x - this.MOVER_START)/(this.panel_mc.mask_mc.width - 14)  * this.totalFrames))/stage.frameRate));//**check names
			//this.strMinutes = String(Math.abs((this.totalFrames - Math.round((this.panel_mc.move_mc.x - this.MOVER_START)/(this.panel_mc.mask_mc.width - 10)  * this.totalFrames))/stage.frameRate/60));//**check names
			while(Number(this.strSeconds) >= 60)
			{
				this.strSeconds = String(Number(this.strSeconds)-60);
				this.strMinutes=String(Number(Number(this.strMinutes) + 1));
			}
			resetTime(this.strMinutes);
			resetTime(this.strSeconds);
			if(this.strMinutes.length == 1)
			{
				this.panel_mc.min_txt.text = this.strMinutes.charAt(0);//**check names
			}
			else if(this.strMinutes.length == 2)
			{
				this.panel_mc.min_txt.text = this.strMinutes.charAt(1);//**check names
				this.panel_mc.min10_txt.text = this.strMinutes.charAt(0);//**check names
			}
			if(this.strSeconds.length == 2)
			{
				this.panel_mc.sec_txt.text = this.strSeconds.charAt(1);//**check names
				this.panel_mc.sec10_txt.text = this.strSeconds.charAt(0);//**check names
			}
			else if(this.strSeconds.length == 1)
			{
				
				this.panel_mc.sec_txt.text = this.strSeconds.charAt(0);//**check names
				this.panel_mc.sec10_txt.text = 0;//**check names
			}
		}
		
		private function resetTime(strTime:String):void
		{
			var nDotIndex:Number = strTime.length;
			for (var nCounter:Number = 0; nCounter < strTime.length; nCounter ++)
			{
				if(strTime.charAt(nCounter) == ".")
				{
					nDotIndex = nCounter;
				}
			}
			
			if(strTime == this.strMinutes)
			{
				this.strMinutes = strTime.substring(0, nDotIndex);
			}
			else
			{
				this.strSeconds = strTime.substring(0, nDotIndex);
			  
			}
		}
		
		
		
		private function startOver(e:Event):void
		{
			this.gotoAndStop(1);
			this.bIsFromRewind=true;
			this.panel_mc.mask_mc.x = this.panel_mc.move_mc.x - this.panel_mc.mask_mc.width + 5;//**check names
			this.panel_mc.move_mc.x = (this.currentFrame/this.totalFrames * (this.panel_mc.mask_mc.width-this.panel_mc.move_mc.width))+this.MOVER_START;//**check names
		}
		
		public function removeListeners():void
		{
			this.removeEventListener(Event.ENTER_FRAME, MovieEnding);
			TheStage.bIsNotAnimation = false;
		}
		
		public function get fromEnd():Boolean
		{
			return this.bFromEnd;
		}
		public function set fromEnd(b:Boolean):void
		{
			this.bFromEnd = b;
		}
		
		public function get isMoviePlayed():Boolean 
		{
			return this.bIsMoviePlayed;
		}
		
		public function set isMoviePlayed(value:Boolean):void 
		{
			this.bIsMoviePlayed = value;
		}
		
		public function get getMovStart():Number 
		{
			return MOVER_START;
		}
		public function set MaxDrag(value:Number):void
		{
			this.nMaxDrag = value;
		}
		public function get MaxDrag():Number
		{
			return this.nMaxDrag;
		}
	}
	
}
