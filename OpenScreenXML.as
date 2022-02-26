package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author lee lankri
	 */
	public class OpenScreenXML extends MovieClip 
	{
		private static var myRoot:OpenScreenXML;
		private static var myXML:XML = new XML();
		var XML_URL:String = "Settings.xml";
		var myXMLURL:URLRequest = new URLRequest(XML_URL);
		var myLoader:URLLoader = new URLLoader(myXMLURL);
		
		public function OpenScreenXML() 
		{	
			myRoot=this;
			myLoader.addEventListener("complete", xmlLoaded);		
		}
		
		function xmlLoaded(event:Event):void
		{
			myXML = XML(myLoader.data);
		}
		static public function ChangeDetails():void
		{
			myRoot.open_mc.clsssification_mc.clsssification_txt.text= TheStage.changeToHebrew(String(myXML.child(2)));
			myRoot.open_mc.version_mc.version_txt.text=TheStage.changeToHebrew(String(myXML.child(1)));
			myRoot.open_mc.year_mc.year_txt.text=TheStage.changeToHebrew(String(myXML.child(0)));
		}
		
		static public function Hafatza():void 
		{
			if (myXML.child(3) == "false")
			{
				myRoot.open_mc.Hafatza_mc.visible = false;
			}
			else
			{
				myRoot.open_mc.Hafatza_mc.visible = true;
			}			
		}
		
		static public function Kind():void 
		{
			
			var kindStr:String=String(myXML.child(4));
			switch(kindStr)
			{
				case "1":
				{
					myRoot.open_mc.kind_mc.gotoAndStop(1);
					break;
				}
				case "2":
				{
					myRoot.open_mc.kind_mc.gotoAndStop(2);
					break;
				}
				case "3":
				{
					myRoot.open_mc.kind_mc.gotoAndStop(3);
					break;
				}
				case "4":
				{
					myRoot.open_mc.kind_mc.gotoAndStop(4);
					break;
				}
				case "5":
				{
					myRoot.open_mc.kind_mc.gotoAndStop(5);
					break;
				}
				default:
				{
					break;
				}
			}
		}
	}

}