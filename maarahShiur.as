package  
{
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.net.*;
	
	/**
	 * ...
	 * @author lee lankri
	 */
	public class maarahShiur extends SimpleButton 
	{
		
		public function maarahShiur() 
		{
			addEventListener(MouseEvent.CLICK, gotoAdobeSite);
		}
		function gotoAdobeSite(event:MouseEvent):void
		{
			var targetURL:URLRequest = new URLRequest("fscommand/מערך שיעור.docx");
			navigateToURL(targetURL);
		}	
	}

}