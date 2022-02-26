package 
{
	import flash.net.URLLoader;
	import flash.events.Event;
	import flash.net.URLRequest;
	//import fl.controls.*;
	import flash.display.*;
	public class HandleTextFiles
	{

		private static var bIsPreloader:Boolean = true;
		private static var signFunc:String = "";
		//private static var textAreaTake:TextArea;
		public function HandleTextFiles()
		{
			// constructor code
		}

		// Get text file 
		public static function handleInFiles(textFileName:String):void
		{
			bIsPreloader = true;

			var lTextFileLoader:URLLoader = new URLLoader  ;
			lTextFileLoader.load(new URLRequest(textFileName));
			lTextFileLoader.addEventListener(Event.COMPLETE,loaderComplete);
		}

		/*public static function handleClass(textFileName:String,sign:String,textAre:TextArea):void
		{
			textAreaTake = textAre;
			bIsPreloader = false;
			signFunc = sign;
			var lTextFileLoader:URLLoader = new URLLoader  ;
			lTextFileLoader.load(new URLRequest(textFileName));
			lTextFileLoader.addEventListener(Event.COMPLETE,loaderComplete);
		}*/

		// loader of text file complete
		private static function loaderComplete(e:Event):void
		{

			// If need to handle preloader alpha
			if (bIsPreloader && TheStage.nScreenNum >= 0)
			{
				if (MovieClip(TheStage.lScreenLoader.getChildAt(0)).currentFrame == 1)
				{
					MovieClip(MovieClip(TheStage.lScreenLoader.getChildAt(0)).getChildAt(0)).alpha = Number(URLLoader(e.target).data.substring(14,17));
				}
			}
			else
			{
				//GetFunc(e.target.data.toString());
			}

		}

		/*private static function GetFunc(strBig:String):void
		{
			var bIsFound:Boolean = false;
			var myString:String = signFunc;
			while (! bIsFound && strBig.length != 0)
			{
				while (myString.charAt(0) == strBig.charAt(0) && ! bIsFound)
				{
					if (myString.length == 1)
					{
						bIsFound = true;
					}
					else
					{
						myString = myString.substring(1);
						strBig = strBig.substring(1);
					}
				}
				if (! bIsFound)
				{
					myString = signFunc;
					strBig = strBig.substring(1);
				}
			}
			if (bIsFound)
			{
				var bStart:Boolean = false;
				var counter:Number = 0;
				myString = signFunc;
				strBig = strBig.substring(1);
				while (((counter != 0) || ! bStart))
				{
					if (strBig.charAt(0) == '{')
					{
						bStart = true;
						counter++;
					}
					if (strBig.charAt(0) == '}')
					{
						counter--;
					}
					if (strBig.charAt(0) != '\n')
					{
						myString = myString + strBig.charAt(0);
					}
					strBig = strBig.substring(1);
				}
			}
			textAreaTake.text = myString;
		}*/
	}

}